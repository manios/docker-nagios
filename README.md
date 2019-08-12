# Docker Nagios

Docker image for [Nagios](https://www.nagios.org/), the Industry Standard In IT Infrastructure Monitoring. Nagios Core is running on [Alpine Linux](https://alpinelinux.org/), using [Apache HTTP](http://httpd.apache.org/) as a web server and [sSMTP](https://wiki.debian.org/sSMTP) as mail agent for email notifications.

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
