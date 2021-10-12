### ================================== ###
###   STAGE 1 CREATE PARENT IMAGE      ###
### ================================== ###

# https://www.docker.com/blog/docker-arm-virtual-meetup-multi-arch-with-buildx/

FROM alpine:3.12 as builder-base

ARG TARGETPLATFORM
ARG BUILDPLATFORM

ENV NAGIOS_HOME=/opt/nagios \
    NAGIOS_USER=nagios \
    NAGIOS_GROUP=nagios \
    NAGIOS_CMDUSER=nagios \
    NAGIOS_CMDGROUP=nagios \
    NAGIOS_TIMEZONE=UTC \
    NAGIOS_FQDN=nagios.example.com \
    NAGIOSADMIN_USER=nagiosadmin \
    NAGIOSADMIN_PASS=nagios \
    NAGIOS_VERSION=4.4.6 \
    NAGIOS_PLUGINS_VERSION=2.3.3 \
    NRPE_VERSION=4.0.3 \
    APACHE_LOCK_DIR=/var/run \
    APACHE_LOG_DIR=/var/log/apache2


RUN addgroup -S ${NAGIOS_GROUP} && \
    adduser  -S ${NAGIOS_USER} -G ${NAGIOS_CMDGROUP} && \
    apk update && \
    apk add --no-cache git curl unzip apache2 apache2-utils rsyslog \
                        php7 php7-gd php7-cli runit parallel ssmtp \
                        libltdl libintl openssl-dev php7-apache2 procps tzdata \
                        libldap mariadb-connector-c freeradius-client-dev libpq libdbi \
                        lm-sensors perl net-snmp-perl perl-net-snmp perl-crypt-x509 \
                        perl-timedate perl-libwww perl-text-glob samba-client openssh openssl \
                        net-snmp-tools && \
                                                \
    : '# For x64 the binary is : gosu-amd64' && \
    : '# For arm-v6 the binary is : gosu-armel' && \
    : '# For arm-v7 the binary is : gosu-armhf' && \
    : '# For arm64 the binary is : gosu-arm64' && \
    : '#######################################' && \
    : '# Creating an associative array with the platforms and their respective gosu release DOES NOT WORK in /bin/sh' && \
    echo "Arguments TARGETPLATFORM: ${TARGETPLATFORM} and BUILDPLATFORM: ${BUILDPLATFORM}" && \
    echo "$TARGETPLATFORM" | awk '{ gosuBinArr["linux/amd64"]="gosu-amd64"; gosuBinArr["linux/arm/v6"]="gosu-armel"; gosuBinArr["linux/arm/v7"]="gosu-armhf"; gosuBinArr["linux/arm64"]="gosu-arm64"; print gosuBinArr[$0];}' > mygosuver.txt && \
    gosuPlatform=$(cat mygosuver.txt) && \
    echo "Downloading ${gosuPlatform} for platform $TARGETPLATFORM" &&\
    curl -L -o gosu "https://github.com/tianon/gosu/releases/download/1.13/${gosuPlatform}"  && \
    mv gosu /bin/ && \
    chmod 755 /bin/gosu && \
    chmod +s /bin/gosu && \
    addgroup -S apache ${NAGIOS_CMDGROUP}
   
    
### ================================== ###
###   STAGE 2 COMPILE NAGIOS SOURCES   ###
### ================================== ###

FROM builder-base as builder-compile
ARG TARGETPLATFORM
ARG BUILDPLATFORM

# Add dependencies required to build Nagios
RUN apk update && \
    apk add --no-cache build-base automake libtool autoconf py-docutils gnutls  \
                        gnutls-dev g++ make alpine-sdk build-base gcc autoconf \
                        gettext-dev linux-headers openssl-dev net-snmp net-snmp-tools \
                        libcrypto1.1 libpq musl libldap libssl1.1 libdbi freeradius-client mariadb-connector-c \
                        openssh-client bind-tools samba-client fping grep rpcbind \
                        lm-sensors net-snmp-tools \
                        file freeradius-client-dev libdbi-dev libpq linux-headers mariadb-dev \
                        mariadb-connector-c-dev perl \
                        net-snmp-dev openldap-dev openssl-dev postgresql-dev

# Download Nagios core, plugins and nrpe sources                        
RUN    cd /tmp && \
       echo -n "Downloading Nagios ${NAGIOS_VERSION} source code: " && \
       wget -O nagios-core.tar.gz "https://github.com/NagiosEnterprises/nagioscore/archive/nagios-${NAGIOS_VERSION}.tar.gz" && \
       echo -n -e "OK\nDownloading Nagios plugins ${NAGIOS_PLUGINS_VERSION} source code: " && \
       wget -O nagios-plugins.tar.gz "https://github.com/nagios-plugins/nagios-plugins/archive/release-${NAGIOS_PLUGINS_VERSION}.tar.gz" && \
       echo -n -e "OK\nDownloading NRPE ${NRPE_VERSION} source code: " && \
       wget -O nrpe.tar.gz "https://github.com/NagiosEnterprises/nrpe/archive/nrpe-${NRPE_VERSION}.tar.gz" && \
       env && \
       echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM !! == " && \
       echo "OK"

# Compile Nagios Core
RUN    ls -l /tmp && cd /tmp && \
       tar zxf nagios-core.tar.gz && \
       tar zxf nagios-plugins.tar.gz && \
       tar zxf nrpe.tar.gz && \
       cd  "/tmp/nagioscore-nagios-${NAGIOS_VERSION}" && \
       echo -e "\n ===========================\n  Configure Nagios Core\n ===========================\n" && \
       ./configure \
            --prefix=${NAGIOS_HOME}                  \
            --exec-prefix=${NAGIOS_HOME}             \
            --enable-event-broker                    \
            --with-command-user=${NAGIOS_CMDUSER}    \
            --with-command-group=${NAGIOS_CMDGROUP}  \
            --with-nagios-user=${NAGIOS_USER}        \
            --with-nagios-group=${NAGIOS_GROUP}      && \
       : 'Apply patches to Nagios Core sources:' && \
       echo -n "Replacing \"<sys\/poll.h>\" with \"<poll.h>\": " && \
       sed -i 's/<sys\/poll.h>/<poll.h>/g' ./include/config.h && \
       echo -n "Patching cgi scripts in order not to throw segmentation fault. For more info please check: https://gitlab.alpinelinux.org/alpine/aports/-/issues/12516" && \
       wget "https://gitlab.alpinelinux.org/alpine/aports/-/raw/f22889166a9e09b63fbfa1ddc34d3057813931f1/main/nagios/cgi-pairlist-truncation-fix.patch" && \
       patch cgi/getcgi.c cgi-pairlist-truncation-fix.patch && \
       echo "OK" && \
       echo -e "\n\n ===========================\n Compile Nagios Core\n ===========================\n" && \
       make all && \
       echo -e "\n\n ===========================\n  Install Nagios Core\n ===========================\n" && \
       make install && \
       make install-commandmode && \
       make install-config && \
       make install-webconf && \
       echo -n "Nagios installed size: " && \
       du -h -s ${NAGIOS_HOME}

# Compile Nagios Plugins
RUN    echo -e "\n\n ===========================\n  Configure Nagios Plugins\n ===========================\n" && \
       cd  /tmp/nagios-plugins-release-${NAGIOS_PLUGINS_VERSION} && \
       ./autogen.sh && \
       ./configure  --with-nagios-user=${NAGIOS_USER} \
                    --with-nagios-group=${NAGIOS_USER} \
                    --with-openssl \
                    --prefix=${NAGIOS_HOME}                                 \
                    --with-ping-command="/bin/gosu root /bin/ping -n -w %d -c %d %s"  \
                    --with-ipv6                                             \
                    --with-ping6-command="/bin/gosu root /bin/ping6 -n -w %d -c %d %s"  && \
       echo "Nagios plugins configured: OK" && \
       echo -n "Replacing \"<sys\/poll.h>\" with \"<poll.h>\": " && \
       egrep -rl "\<sys\/poll.h\>" . | xargs sed -i 's/<sys\/poll.h>/<poll.h>/g' && \
       egrep -rl "\"sys\/poll.h\"" . | xargs sed -i 's/"sys\/poll.h"/"poll.h"/g' && \
       echo "OK" && \
       echo -n "Patching check_mysql_query plugin. For more info please check: https://gitlab.alpinelinux.org/alpine/aports/-/issues/12601" && \
       wget "https://gitlab.alpinelinux.org/alpine/aports/-/raw/074d8cfb5ef7bd3fdb922b6a6cb86f0fd5db346d/main/nagios-plugins/check_mysql_query-fix-use-after-free.patch" && \
       patch plugins/check_mysql_query.c check_mysql_query-fix-use-after-free.patch && \
       echo "OK" && \
       echo -e "\n\n ===========================\n Compile Nagios Plugins\n ===========================\n" && \
       make && \
       echo "Nagios plugins compile successfully: OK" && \
       echo -e "\n\n ===========================\nInstall Nagios Plugins\n ===========================\n" && \
       make install && \
       echo "Nagios plugins installed successfully: OK"

# Compile NRPE
RUN    echo -e "\n\n =====================\n  Configure NRPE\n =====================\n" && \
       cd  /tmp/nrpe-nrpe-${NRPE_VERSION} && \
       ./configure --enable-command-args \
                    --with-nagios-user=${NAGIOS_USER} \
                    --with-nagios-group=${NAGIOS_USER} \
                    --with-ssl=/usr/bin/openssl \
                    --with-ssl-lib=/usr/lib && \
       echo "NRPE client configured: OK" && \
       echo -e "\n\n ===========================\n  Compile NRPE\n ===========================\n" && \
       # make all && \
       make check_nrpe                                                          && \
       echo "NRPE compiled successfully: OK" && \
       echo -e "\n\n ===========================\n  Install NRPE\n ===========================\n" && \
       # make install && \
       cp src/check_nrpe ${NAGIOS_HOME}/libexec/                                && \
       echo "NRPE installed successfully: OK" && \
       echo -n "Final Nagios installed size: " && \
       du -h -s ${NAGIOS_HOME} 

# Compile Nagios files
# Create SSMTP configuration


# RUN sed -i.bak 's/.*\=www\-data//g' /etc/apache2/envvars
RUN export DOC_ROOT="DocumentRoot $(echo $NAGIOS_HOME/share)"                                        && \
    sed -i "s,DocumentRoot.*,$DOC_ROOT," /etc/apache2/httpd.conf                                     && \
    sed -i "s|^ *ScriptAlias.*$|ScriptAlias /cgi-bin $NAGIOS_HOME/sbin|g" /etc/apache2/httpd.conf    && \
    sed -i 's/^\(.*\)#\(LoadModule cgi_module\)\(.*\)/\1\2\3/' /etc/apache2/httpd.conf               && \
    echo "ServerName ${NAGIOS_FQDN}" >> /etc/apache2/httpd.conf

RUN sed -i 's,/bin/mail,/usr/bin/mail,' ${NAGIOS_HOME}/etc/objects/commands.cfg  && \
    sed -i 's,/usr/usr,/usr,'           ${NAGIOS_HOME}/etc/objects/commands.cfg  && \
                                                                                    \
    : '# Modify Nagios mail commands in order to work with SSMTP'         && \
    sed -i 's/^.*command_line.*Host Alert.*$//g' /opt/nagios/etc/objects/commands.cfg && \
    sed -i 's/^.*command_line.*Service Alert.*$//g' /opt/nagios/etc/objects/commands.cfg && \
    sed -i '/notify-host-by-email/a command_line /usr/bin/printf "%b" "Subject: $NOTIFICATIONTYPE$ Host Alert: $HOSTNAME$ is $HOSTSTATE$\\n\\n***** Nagios *****\\n\\nNotification Type: $NOTIFICATIONTYPE$\\nHost: $HOSTNAME$\\nState: $HOSTSTATE$\\nAddress: $HOSTADDRESS$\\nInfo: $HOSTOUTPUT$\\n\\nDate/Time: $LONGDATETIME$\\n" | /usr/sbin/sendmail -v $CONTACTEMAIL$' ${NAGIOS_HOME}/etc/objects/commands.cfg  && \
    sed -i '/notify-service-by-email/a command_line /usr/bin/printf "%b" "Subject: $NOTIFICATIONTYPE$ Service Alert: $HOSTALIAS$/$SERVICEDESC$ is $SERVICESTATE$\\n\\n***** Nagios *****\\n\\nNotification Type: $NOTIFICATIONTYPE$\\n\\nService: $SERVICEDESC$\\nHost: $HOSTALIAS$\\nAddress: $HOSTADDRESS$\\nState: $SERVICESTATE$\\n\\nDate/Time: $LONGDATETIME$\\n\\nAdditional Info:\\n\\n$SERVICEOUTPUT$\\n" | /usr/sbin/sendmail -v $CONTACTEMAIL$' ${NAGIOS_HOME}/etc/objects/commands.cfg

RUN echo "use_timezone=${NAGIOS_TIMEZONE}" >> ${NAGIOS_HOME}/etc/nagios.cfg && \
    sed -i 's/date_format=us/date_format=iso8601/g' ${NAGIOS_HOME}/etc/nagios.cfg

# Copy original configuration to /orig directory
RUN mkdir -p /orig/apache2                     && \
    cp -r /etc/apache2/*  /orig/apache2        && \
    cp -r ${NAGIOS_HOME}/etc  /orig/etc        && \
    cp -r ${NAGIOS_HOME}/var  /orig/var         


### ========================== ###
### START OF ACTUAL DOCKERFILE ###
### ========================== ###

FROM builder-base

MAINTAINER Christos Manios <maniopaido@gmail.com>

LABEL name="Nagios" \
      nagiosVersion="4.4.6" \
      nagiosPluginsVersion="2.3.3" \
      nrpeVersion="4.0.3" \
      homepage="https://www.nagios.com/" \
      maintainer="Christos Manios <maniopaido@gmail.com>" \
      build="8"

RUN mkdir -p ${NAGIOS_HOME}  && \
    mkdir -p /orig/apache2

WORKDIR ${NAGIOS_HOME}
COPY --from=builder-compile ${NAGIOS_HOME} ${NAGIOS_HOME}

COPY --from=builder-compile /orig /orig

ADD overlay/ /

# Make 
RUN chmod +x /usr/local/bin/start_nagios                 \
            /etc/sv/apache/run                           \
            /etc/sv/nagios/run                           \
            /etc/sv/rsyslog/run                       && \
            rm -rf /etc/sv/getty-5                    && \
                                                         \
            : '# enable all runit services'           && \
            ln -s /etc/sv/* /etc/service              && \
                                                         \
            : '# Copy initial settings files'         && \
            chown -R nagios:nagios ${NAGIOS_HOME}     && \
            : '# Create special dirs'                 && \
            (mkdir /run/apache2 || true)              && \
            mkdir -p /var/spool/rsyslog               && \
            : '# Copy Apache configuration'           && \
            cp -Rp /orig/apache2/* /etc/apache2       && \
            : '# Convert files to Unix format'        && \
            dos2unix /etc/rsyslog.conf                && \
            dos2unix /usr/local/bin/start_nagios      && \
            dos2unix /etc/sv/**/run                   && \
            dos2unix /etc/ssmtp/ssmtp.conf
            
            
EXPOSE 80

VOLUME "${NAGIOS_HOME}/var" "${NAGIOS_HOME}/etc" "/var/log/apache2" "/opt/Custom-Nagios-Plugins"

CMD [ "/usr/local/bin/start_nagios" ]
