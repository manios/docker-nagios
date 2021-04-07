
# Changelog

This Docker image contains more than one software (Nagios, Nagios plugins, NRPE, Apache HTTPD, etc.) with different versions. Hence we decided to name the releases with the naming `Build - <number>` which will an incremental unsigned integer. In this document we will describe the contents of every image in every build.

## Build 3 (2021-04-08)

* Nagios core: v4.4.6
* Nagios plugins: v2.3.3
* NRPE: 4.0.3

### Bug Fixes

* Fix `ldap`,`snmp`,`check_pgsql`,`dbi`,`radius`,`mysql` plugins build failing. Compilation was failing due to unmet dependencies. ([#3](https://github.com/manios/docker-nagios/issues/3) ,[#22](https://github.com/manios/docker-nagios/issues/22))

## Build 2 (2020-12-24)

* Nagios core: v4.4.6
* Nagios plugins: v2.3.3
* NRPE: 4.0.3

### Bug Fixes

* Fix rsyslog runsv loop ([#8](https://github.com/manios/docker-nagios/issues/8))
* Fix httpd runsv loop ([#13](https://github.com/manios/docker-nagios/issues/13), [#17](https://github.com/manios/docker-nagios/issues/17), [#18](https://github.com/manios/docker-nagios/issues/18))
* Fix check_ping version 2.2.1 Plugin Timeout ([#12](https://github.com/manios/docker-nagios/issues/12))

### Features

* Add the ability to override default timezone inside the container and Nagios ([#11](https://github.com/manios/docker-nagios/issues/11))
* Build the Docker images using Github Actions ([#19](https://github.com/manios/docker-nagios/issues/19))

## Build 1 (2020-11-24)

* Nagios core: v4.4.5
* Nagios plugins: v2.2.1
* NRPE: 4.0.0
