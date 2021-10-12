
# Changelog

This Docker image contains more than one software (Nagios, Nagios plugins, NRPE, Apache HTTPD, etc.) with different versions. Hence we decided to name the releases with the naming `Build - <number>` which will have an incremental unsigned integer. In this document we will describe the contents of every image in every build.

## Build 8 (2021-10-21)

* Nagios core: v4.4.6
* Nagios plugins: v2.3.3
* NRPE: 4.0.3

### Bug Fixes

* Rollback to Alpine 3.12 as base image as Alpine 3.14 causes multiple issues in ARM devices. ([#32](https://github.com/manios/docker-nagios/issues/32), [#35](https://github.com/manios/docker-nagios/issues/35))

## Build 7 (2021-08-24)

* Nagios core: v4.4.6
* Nagios plugins: v2.3.3
* NRPE: 4.0.3

### Bug Fixes

* Fix HTTP 500 Internal Server Error due to getcgi.c bug. ([#34](https://github.com/manios/docker-nagios/issues/34))

## Build 6 (2021-08-20)

* Nagios core: v4.4.6
* Nagios plugins: v2.3.3
* NRPE: 4.0.3

### Bug Fixes

* Fix `check_mysql_query` plugin segmentation fault error. ([#33](https://github.com/manios/docker-nagios/issues/33))

## Build 5 (2021-08-14)

* Nagios core: v4.4.6
* Nagios plugins: v2.3.3
* NRPE: 4.0.3

### Bug Fixes

* Add missing `net-snmp-tools` package. ([#31](https://github.com/manios/docker-nagios/issues/31))
* Add missing missing `gosu` for `amd64` architecture. ([#30](https://github.com/manios/docker-nagios/issues/30))
* Add missing `openssl` package. ([#28](https://github.com/manios/docker-nagios/issues/28))
* Add missing `openssh` package. ([#27](https://github.com/manios/docker-nagios/issues/27))

### Features

* Update to `alpine:3.14` as base image.
* Build and tag the docker image automatically according to git branch and tag information.

## Build 4 (2021-04-20)

* Nagios core: v4.4.6
* Nagios plugins: v2.3.3
* NRPE: 4.0.3

### Bug Fixes

* Use `alpine:3.11` as base image as musl libc 1.2.2-r0 causes multiple issues. ([#3](https://github.com/manios/docker-nagios/issues/3) ,[#24](https://github.com/manios/docker-nagios/issues/24))

### Features

* Add a new build flavour for `arm64`. ([#25](https://github.com/manios/docker-nagios/issues/25))

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
