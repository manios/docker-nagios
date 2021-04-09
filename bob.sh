#!/bin/sh

set -x


# apk add libldap mariadb-connector-c freeradius-client-dev libpq libdbi lm-sensors perl net-snmp-perl perl-net-snmp perl-crypt-x509 perl-timedate perl-libwww perl-text-glob

# https://github.com/sstephenson/bats

./check_apt
./check_breeze
./check_by_ssh
./check_clamd
./check_cluster
./check_dbi
./check_dhcp
./check_dig
./check_disk
./check_disk_smb
./check_dns
./check_dummy
./check_file_age
./check_flexlm
./check_fping
./check_ftp
./check_hpjd
./check_http
./check_icmp
./check_ide_smart
./check_ifoperstatus
./check_ifstatus
./check_imap
./check_ircd
./check_jabber
./check_ldap
./check_ldaps
./check_load
./check_log
./check_mailq
./check_mrtg
./check_mrtgtraf
./check_mysql
./check_mysql_query
./check_nagios
./check_nntp
./check_nntps
./check_nrpe
./check_nt
./check_ntp
./check_ntp_peer
./check_ntp_time
./check_nwstat
./check_oracle
./check_overcr
./check_pgsql
./check_ping
./check_pop
./check_procs
./check_radius
./check_real
./check_rpc
./check_sensors
./check_simap
./check_smtp
./check_snmp
./check_spop
./check_ssh
./check_ssl_validity
./check_ssmtp
./check_swap
./check_tcp
./check_time
./check_udp
./check_ups
./check_uptime
./check_users
./check_wave
