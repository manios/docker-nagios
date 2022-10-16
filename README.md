# Docker Nagios

Docker image for [Nagios](https://www.nagios.org/), the Industry Standard In IT Infrastructure Monitoring. Nagios Core is running on [Alpine Linux](https://alpinelinux.org/), using [Apache HTTP](http://httpd.apache.org/) as a web server and [sSMTP](https://wiki.debian.org/sSMTP) as mail agent for email notifications.

The image is inspired by [JasonRivers/Docker-Nagios](https://github.com/JasonRivers/Docker-Nagios) image (Kudos to Jason!) but follows a different approach targetted to lightweight size and basic features.

Build Status: 
 ![build status badge](https://github.com/manios/docker-nagios/workflows/Nagios%20Build/badge.svg?branch=master) [![](https://images.microbadger.com/badges/image/manios/nagios.svg)](https://microbadger.com/images/manios/nagios) [![Docker pulls badge](https://img.shields.io/docker/pulls/manios/nagios.svg)](https://hub.docker.com/r/manios/nagios)  [![Docker stars badge](https://img.shields.io/docker/stars/manios/nagios.svg)](https://hub.docker.com/r/manios/nagios) ![GitHub Manios Docker Nagios Licence](https://img.shields.io/badge/license-MIT-green)

## Quick reference

* **Available architectures**: `x86`, `amd64`, `arm/v6`, `arm/v7`, `arm64`
* **Where to file issues**: https://github.com/manios/docker-nagios/issues

## Supported tags and respective `Dockerfile` links

* `4.4.8`, `4.4`, `latest` [(4.4.8/Dockerfile)](https://github.com/manios/docker-nagios/blob/master/Dockerfile)

For more information about the image versions you may refer to the [CHANGELOG](https://github.com/manios/docker-nagios/blob/master/CHANGELOG.md)

## Running

Run with the example configuration with the following:

```sh
docker run --name nagios -p 0.0.0.0:8080:80 manios/nagios:latest
```

alternatively you can use external Nagios configuration & log data with the following:

```sh
docker run --name nagios  \
  -v /path-to-nagios/etc/:/opt/nagios/etc/ \
  -v /path-to-nagios/var:/opt/nagios/var/ \
  -v /path-to-nagios/ssmtp.conf:/etc/ssmtp/ssmtp.conf \
  -v /path-to-custom-plugins:/opt/Custom-Nagios-Plugins \
  -p 0.0.0.0:8080:80 \
  manios/nagios:latest
```

Notes: 

1. The container populates with default configuration files if the configuration directories are empty.
1. The path for the custom plugins will be /opt/Custom-Nagios-Plugins, you will need to reference this directory in your configuration scripts.
1. In order to receive mail notifications, you have to configure SSMTP. You can find example configuration in `docker-nagios`.

For best results your Nagios container should have access to both IPv4 & IPv6 networks 

### Credentials

The default credentials for the web interface is `nagiosadmin` / `nagios`. However you can define your own credentials by overriding `NAGIOSADMIN_USER` and `NAGIOSADMIN_PASS` when you run the container. For example:

```sh
docker run --name nagios  \
  -e NAGIOSADMIN_USER="godmode" \
  -e NAGIOSADMIN_PASS="super-Duper-Secret!" \
  -p 0.0.0.0:8080:80 \
  manios/nagios:latest
```

### Timezones

By default the Alpine container and Nagios both use `UTC`. In order to change the timezone we can pass the [tz timezone database name](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) as an environmental variable in `docker run` such as:

```bash
docker run -e "TZ=Europe/Athens" manios/nagios:latest
```

This will configure and use globally `"Europe/Athens"` in both container and Nagios process.

## Flavours

This Docker image is designed with optimising resources usage in mind and is build for multiple hardware architectures. The following matrix can be used to determine if your hardware architecture is represented in a docker image tag:

|Hardware|Image OS/Arch|
|-|-|
|PC (32bit)|linux/i386|
|PC (64bit)|linux/amd64
|Raspberry Pi 1|linux/arm/v6|
|Raspberry Pi 2|linux/arm/v7|
|Raspberry Pi 3|linux/arm/v7 or linux/arm64|
|Raspberry Pi 4|linux/arm/v7 or linux/arm64|
|Apple Silicon M1|linux/arm64|

## Test configuration

To check if your Nagios configuration is OK, you can run the following while your container is running. We assume that you use `/opt/nagios/etc/nagios.cfg` as your main configuration file.

```bash
docker exec -it mynagioscontainer bin/nagios -v etc/nagios.cfg
```

## Troubleshooting

### Nagios keeps restarting or shows a strange behaviour

In docker tag `build-5`, `build-6`, `build-7` we have used Alpine 3.14 as our base image. This comes with security updates which may cause trouble as described in [Release Notes forAlpine 3.14.0 > faccessat2](https://wiki.alpinelinux.org/wiki/Release_Notes_for_Alpine_3.14.0#faccessat2).

In order to resolve this issue you should use docker tag `build-8` or you can follow the workarounds provided here: [#32 (comment)](https://github.com/manios/docker-nagios/issues/32#issuecomment-940355201).

### My image does not run on Raspberry Pi

As already mentioned in [#17](https://github.com/manios/docker-nagios/issues/17), sometimes, because docker manifest related features are still experimental (after 2+ years of their introduction) it has happened when we tested in Raspberry Pi 1 (`arm-v6`) and Raspberry Pi 3 (`arm-v7`) that it does not download the `arm` image but the `amd64`.

Thus you can define explicitly which architecture to pull:

```bash
docker pull --platform=linux/arm/v6 manios/nagios
# or
docker pull --platform=linux/arm/v7 manios/nagios
```

and it works. Be advised that the `--platform` switch requires that you enable the [Docker Experimental Features](https://github.com/docker/cli/blob/master/experimental/README.md).
