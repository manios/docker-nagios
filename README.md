# Docker Nagios

Docker image for [Nagios](https://www.nagios.org/), the Industry Standard In IT Infrastructure Monitoring. Nagios Core is running on [Alpine Linux](https://alpinelinux.org/), using [Apache HTTP](http://httpd.apache.org/) as a web server and [sSMTP](https://wiki.debian.org/sSMTP) as mail agent for email notifications.

The image is inspired by [JasonRivers/Docker-Nagios](https://github.com/JasonRivers/Docker-Nagios) image (Kudos to Jason!) but follows a differeent approach targetted to lightweight size and basic features. 

Build Status: 
 [![build status badge](https://img.shields.io/travis/manios/docker-nagios?branch=master)](https://travis-ci.org/manios/docker-nagios/branches) [![](https://images.microbadger.com/badges/image/manios/nagios.svg)](https://microbadger.com/images/manios/nagios) [![Docker pulls badge](https://img.shields.io/docker/pulls/manios/nagios.svg)](https://hub.docker.com/r/manios/nagios)  [![Docker stars badge](https://img.shields.io/docker/stars/manios/nagios.svg)](https://hub.docker.com/r/manios/nagios)

## Supported tags and respective `Dockerfile` links

* `4.4.5`, `4.4`, `latest` [(4.4.5/Dockerfile)](https://github.com/manios/docker-nagios/blob/dokimes/Dockerfile)


## Running

Run with the example configuration with the following:

```sh
docker run --name nagios4 -p 0.0.0.0:8080:80 manios/nagios:latest
```

alternatively you can use external Nagios configuration & log data with the following:

```sh
docker run --name nagios4  \
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

The default credentials for the web interface is `nagiosadmin` / `nagios`

## Flavours

This Docker image is designed with optimising resources usage in mind and is build for 3 architectures.

|Tag|Architecture|Variant|Notes|
|-|-|-|-|
|latest|x64|-|Normal image for x64 PCs|
|latest-armv6|arm|v6|Image for ARM v6 processors. Compatible with Raspberry Pi 1 boards|
|latest-armv7|arm|v7|Image for ARM v7 processors. Compatible with Raspberry Pi [Model 2 B](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/) and [3 Model B](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/), [3 Model B+](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/) boards|

## Test configuration

To check if your Nagios configuration is OK, you can run the following while your container is running. We assume that you use `/opt/nagios/etc/nagios.cfg` as your main configuration file.

```bash
docker exec -it mynagioscontainer bin/nagios -v etc/nagios.cfg
```
