
# Changelog

This Docker image contains more than one software (Nagios, Nagios plugins, NRPE, Apache HTTPD, etc.) with different versions. Hence we decided to name the releases with the naming `Build - <number>` which will have an incremental unsigned integer. In this document we will describe the contents of every image in every build.


## Build 18 (2024-03-10)

* Nagios core: v4.5.1
* Nagios plugins: v2.4.8
* NRPE: 4.1.0

### Features

* Upgrade to Nagios Core to `4.5.1`, Nagios plugins to `2.4.8`. ([#68](https://github.com/manios/docker-nagios/issues/68))

## Build 17 (2023-11-20)

* Nagios core: v4.5.0
* Nagios plugins: v2.4.7
* NRPE: 4.1.0

### Features

* Upgrade to Nagios Core to `4.5.0`, Nagios plugins to `2.4.7`. ([#66](https://github.com/manios/docker-nagios/issues/66))
* Avoid busybox wget `too many redirect` issue. ([#65](https://github.com/manios/docker-nagios/pull/65))

## Build 16 (2023-08-09)

* Nagios core: v4.4.14
* Nagios plugins: v2.4.6
* NRPE: 4.1.0

## Build 15 (2023-06-12)

* Nagios core: v4.4.13
* Nagios plugins: v2.4.5
* NRPE: 4.1.0

### Features

* Upgrade to Nagios Core to `4.4.13`, Nagios plugins to `2.4.5`. ([#61](https://github.com/manios/docker-nagios/issues/61))

## Build 14 (2023-06-01)

* Nagios core: v4.4.12
* Nagios plugins: v2.4.4
* NRPE: 4.1.0

### Features

* Upgrade to Nagios Core to `4.4.12`. ([#60](https://github.com/manios/docker-nagios/issues/60))

## Build 13 (2023-05-10)

* Nagios core: v4.4.11
* Nagios plugins: v2.4.4
* NRPE: 4.1.0

### Features

* Upgrade to Nagios Core to `4.4.11`, Nagios plugins to `2.4.4`. ([#58](https://github.com/manios/docker-nagios/issues/58))

## Build 12 (2023-03-03)

* Nagios core: v4.4.10
* Nagios plugins: v2.4.3
* NRPE: 4.1.0

### Features

* Upgrade to Nagios Core to `4.4.10`, Nagios plugins to `2.4.3`. ([#53](https://github.com/manios/docker-nagios/issues/53))

## Build 11 (2022-12-12)

* Nagios core: v4.4.9
* Nagios plugins: v2.4.2
* NRPE: 4.1.0

### Features

* Upgrade to Nagios Core to `4.4.9`.

## Build 10 (2022-11-17)

* Nagios core: v4.4.8
* Nagios plugins: v2.4.2
* NRPE: 4.1.0

### Features

* Upgrade to Nagios Core to `4.4.8`, Nagios plugins to `2.4.2` and NRPE to `4.1.0`. ([#49](https://github.com/manios/docker-nagios/issues/42), [#50](https://github.com/manios/docker-nagios/issues/50), [#51](https://github.com/manios/docker-nagios/issues/51))
* Enable again automatic update checks as they are fixed in Nagios 4.4.8. ([nagioscore/#861](https://github.com/NagiosEnterprises/nagioscore/issues/861))
* Updating adduser options to include username. ([#44](https://github.com/manios/docker-nagios/pull/44))

## Build 9 (2022-05-08)

* Nagios core: v4.4.7
* Nagios plugins: v2.4.0
* NRPE: 4.0.3

### Bug Fixes

* Add missing dependencies to build legacy map cgi. ([#36](https://github.com/manios/docker-nagios/issues/36))
* Add missing `bind-tools` package. ([#37](https://github.com/manios/docker-nagios/issues/37))

### Features

* Upgrade to Nagios Core to `4.4.7` and Nagios plugins to `2.4.0`. ([#42](https://github.com/manios/docker-nagios/issues/42))
* Add mail client symbolic links to [sSMTP](https://wiki.debian.org/sSMTP). ([#39](https://github.com/manios/docker-nagios/issues/39))

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
