FROM alpine:latest as mybase

# https://github.com/moby/moby/issues/37345

# docker images --quiet --filter=dangling=true | xargs --no-run-if-empty docker rmi -f && time docker build -t manios/nagios:bu .

# docker run --rm -u $(id -u):$(id -g) -v $PWD:/data vimagick/youtube-dl --limit-rate 150K http://streamcloud.eu/vtc949crkb3g/GR_God_Willing_2015.mp4.html

# docker run --rm -u $(id -u):$(id -g) -v $PWD:/data vimagick/youtube-dl -F

ENV NAGIOS_HOME=/opt/nagios \
    NAGIOS_USER=nagios \
    NAGIOS_GROUP=nagios \
    NAGIOS_CMDUSER=nagios \
    NAGIOS_CMDGROUP=nagcmd \
    NAGIOS_FQDN=nagios.example.com \
    NAGIOSADMIN_USER=nagiosadmin \
    NAGIOSADMIN_PASS=nagios \
    NAGIOS_BRANCH=nagios-4.4.2 \
    NAGIOS_PLUGINS_BRANCH=release-2.2.1 \
    NRPE_BRANCH=nrpe-3.2.1

FROM mybase as sourcebuilder

# NAGIOS_BRANCH=nagios-4.4.2 && \
# NAGIOS_PLUGINS_BRANCH=release-2.2.1 && \
# NRPE_BRANCH=nrpe-3.2.1

RUN  addgroup -S ${NAGIOS_GROUP} && \
       addgroup -S ${NAGIOS_CMDGROUP} && \
       adduser -S ${NAGIOS_USER} -G ${NAGIOS_CMDGROUP} && \
       apk update && \
       apk add --no-cache git build-base automake libtool autoconf py-docutils gnutls  \
                        gnutls-dev g++ make alpine-sdk build-base gcc git curl autoconf \
                        unzip gettext-dev linux-headers openssl-dev \
                        apache2 apache2-utils php5 php5-gd php5-cli runit parallel ssmtp

# Download Nagios core, plugins and nrpe sources                        
RUN    cd /tmp && \
       echo -n "Downloading Nagios ${NAGIOS_BRANCH} source code: " && \
       wget -q -O nagios-core.tar.gz "https://github.com/NagiosEnterprises/nagioscore/archive/${NAGIOS_BRANCH}.tar.gz" && \
       echo -n -e "OK\nDownloading Nagios plugins ${NAGIOS_PLUGINS_BRANCH} source code: " && \
       wget -q -O nagios-plugins.tar.gz "https://github.com/nagios-plugins/nagios-plugins/archive/${NAGIOS_PLUGINS_BRANCH}.tar.gz" && \
       echo -n -e "OK\nDownloading NRPE ${NRPE_BRANCH} source code: " && \
       wget -q -O nrpe.tar.gz "https://github.com/NagiosEnterprises/nrpe/archive/${NRPE_BRANCH}.tar.gz" && \
       echo "OK"

# Compile Nagios Core
RUN    cd /tmp && \
       tar zxf nagios-core.tar.gz && \
       tar zxf nagios-plugins.tar.gz && \
       tar zxf nrpe.tar.gz && \
       cd  "/tmp/nagioscore-${NAGIOS_BRANCH}" && \
       echo -e "\n ===========================\n  Configure Nagios Core\n ===========================\n" && \
       ./configure \
            --prefix=${NAGIOS_HOME}                  \
            --exec-prefix=${NAGIOS_HOME}             \
            --enable-event-broker                    \
            --with-command-user=${NAGIOS_CMDUSER}    \
            --with-command-group=${NAGIOS_CMDGROUP}  \
            --with-nagios-user=${NAGIOS_USER}        \
            --with-nagios-group=${NAGIOS_GROUP}      && \
       echo -n "Replacing \"<sys\/poll.h>\" with \"<poll.h>\": " && \
       sed -i 's/<sys\/poll.h>/<poll.h>/g' ./include/config.h && \
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
       cd  /tmp/nagios-plugins-${NAGIOS_PLUGINS_BRANCH} && \
       ./autogen.sh && \
       ./configure  --with-nagios-user=${NAGIOS_USER} \
                    --with-nagios-group=${NAGIOS_USER} \
                    --with-openssl \
                    --prefix=${NAGIOS_HOME}                                 \
                    --with-ipv6                                             \
                    --with-ping6-command="/bin/ping6 -n -U -W %d -c %d %s"  && \
       echo "Nagios plugins configured: OK" && \
       echo -n "Replacing \"<sys\/poll.h>\" with \"<poll.h>\": " && \
       egrep -rl "\<sys\/poll.h\>" . | xargs sed -i 's/<sys\/poll.h>/<poll.h>/g' && \
       egrep -rl "\"sys\/poll.h\"" . | xargs sed -i 's/"sys\/poll.h"/"poll.h"/g' && \
       echo "OK" && \
       echo -e "\n\n ===========================\n Compile Nagios Plugins\n ===========================\n" && \
       make && \
       echo "Nagios plugins compile successfully: OK" && \
       echo -e "\n\n ===========================\nInstall Nagios Plugins\n ===========================\n" && \
       make install && \
       echo "Nagios plugins installed successfully: OK"

# Compile NRPE
RUN    echo -e "\n\n =====================\n  Configure NRPE\n =====================\n" && \
       cd  /tmp/nrpe-${NRPE_BRANCH} && \
       ./configure --enable-command-args \
                    --with-nagios-user=${NAGIOS_USER} \
                    --with-nagios-group=${NAGIOS_USER} \
                    --with-ssl=/usr/bin/openssl \
                    --with-ssl-lib=/usr/lib && \
       echo "NRPE client configured: OK" && \
       echo -e "\n\n ===========================\n  Compile NRPE\n ===========================\n" && \
        #    make all && \
       make check_nrpe                                                          && \
       echo "NRPE compiled successfully: OK" && \
       echo -e "\n\n ===========================\n  Install NRPE\n ===========================\n" && \
    #    make install && \
       cp src/check_nrpe ${NAGIOS_HOME}/libexec/                                && \
       echo "NRPE installed successfully: OK" && \
       echo -n "Final Nagios installed size: " && \
       du -h -s ${NAGIOS_HOME} 

# Compile Nagios files
# Create SSMTP configuration

FROM mybase 
RUN mkdir -p ${NAGIOS_HOME}
WORKDIR ${NAGIOS_HOME}
COPY --from=sourcebuilder ${NAGIOS_HOME} .
