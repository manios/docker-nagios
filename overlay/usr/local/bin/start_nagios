#!/bin/sh

set -eu

# adapted from https://github.com/discourse/discourse_docker/blob/master/image/base/boot
# this script becomes PID 1 inside the container, catches termination signals, and stops
# processes managed by runit

if [ -z "$(ls -A ${NAGIOS_HOME}/etc)" ]; then
    echo "Started with empty ETC, copying example data in-place"
    cp -Rp /orig/etc/* ${NAGIOS_HOME}/etc/
fi

if [ -z "$(ls -A ${NAGIOS_HOME}/var)" ]; then
    echo "Started with empty VAR, copying example data in-place"
    cp -Rp /orig/var/* ${NAGIOS_HOME}/var/
fi

if [ ! -f "${NAGIOS_HOME}/etc/htpasswd.users" ] ; then
  htpasswd -c -b -s "${NAGIOS_HOME}/etc/htpasswd.users" "${NAGIOSADMIN_USER}" "${NAGIOSADMIN_PASS}"
  chown -R ${NAGIOS_USER}.${NAGIOS_GROUP} "${NAGIOS_HOME}/etc/htpasswd.users"
fi

# Remove pid files

echo -n "Removing Apache HTTPD PID file before starting it ..."
(rm -f /var/run/apache2/httpd.pid || true)
echo "OK"

echo -n "Removing rsyslogd PID file before starting it ..."
(rm -f /var/run/rsyslogd.pid || true)
echo "OK"

# This function sets the timezone to Nagios and Apache configuration files
setTimezone() {

    # If TZ env is not set, continue
    # https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
    if [ -z "${TZ+x}" ]; then
        echo "TZ env variable is not set. Continue."
        return 0
    fi

    # Check if timezone is set in nagios.cfg
    NAGIOS_CFG="${NAGIOS_HOME}/etc/nagios.cfg"
    NAGIOS_HTTPD_CFG="/etc/apache2/conf.d/nagios.conf"

    TZ_EXIST_NAGIOS_CFG=$(egrep -q "^use_timezone" ${NAGIOS_CFG} ; echo $?)
    TZ_EXIST_APACHE_CFG=$(egrep -q "SetEnv *TZ *" ${NAGIOS_HTTPD_CFG} ; echo $?)

    #echo "Exists in Nagios conf: $TZ_EXIST_NAGIOS_CFG or Apache conf: $TZ_EXIST_APACHE_CFG"

    # Set timezone to Nagios config
    if [ ${TZ_EXIST_NAGIOS_CFG} -eq 0 ]; then
        echo -n "Timezone setting exists in ${NAGIOS_CFG}. Modifying it ..."
        sed -i "s|^use_timezone.*$|use_timezone=$TZ|g" "${NAGIOS_CFG}"
        echo " OK"
    else
        echo -n "No timezone setting in ${NAGIOS_CFG} ..."
        echo "use_timezone=$TZ" >> ${NAGIOS_CFG}
        echo " OK"
    fi

    # Set timezone to Apache httpd Nagios config
    if [ ${TZ_EXIST_APACHE_CFG} -eq 0 ]; then
        echo -n "Timezone setting exists in ${NAGIOS_HTTPD_CFG}. Modifying it ..."
        sed -i "s|^ *SetEnv *TZ.*$|   SetEnv TZ \"${TZ}\"|g" "${NAGIOS_HTTPD_CFG}"
        echo " OK"
    else
        echo -n "No timezone setting in ${NAGIOS_HTTPD_CFG} ..."
        sed -i "s|#  *SSLRequireSSL|#  SSLRequireSSL\n    SetEnv TZ \"${TZ}\"|g" "${NAGIOS_HTTPD_CFG}"
        echo " OK"
    fi

}

shutdown() {
  echo Shutting Down
  ls /etc/service | SHELL=/bin/sh parallel --no-notice sv force-stop {}
  if [ -e "/proc/${RUNSVDIR}" ]; then
    kill -HUP "${RUNSVDIR}"
    wait "${RUNSVDIR}"
  fi

  # give stuff a bit of time to finish
  sleep 1

  ORPHANS=$(ps -eo pid= | tr -d ' ' | grep -Fxv 1)
  SHELL=/bin/bash parallel --no-notice 'timeout 5 /bin/bash -c "kill {} && wait {}" || kill -9 {}' ::: "${ORPHANS}" 2> /dev/null
  exit
}

# Set timezones before start
setTimezone

exec runsvdir -P /etc/service &
RUNSVDIR=$!
echo "Started runsvdir, PID is ${RUNSVDIR}"

trap shutdown SIGTERM SIGHUP SIGINT
wait "${RUNSVDIR}"

shutdown

