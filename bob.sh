#!/usr/bin/env bats

# apk add libldap mariadb-connector-c freeradius-client-dev libpq libdbi lm-sensors perl net-snmp-perl perl-net-snmp perl-crypt-x509 perl-timedate perl-libwww perl-text-glob

# https://github.com/sstephenson/bats

NAGIOS_PLUGINS=/opt/nagios/libexec

cmd_check_apt="$NAGIOS_PLUGINS/check_apt 2>&1"
cmd_check_breeze="$NAGIOS_PLUGINS/check_breeze 2>&1"
cmd_check_by_ssh="$NAGIOS_PLUGINS/check_by_ssh 2>&1"
cmd_check_clamd="$NAGIOS_PLUGINS/check_clamd 2>&1"
cmd_check_cluster="$NAGIOS_PLUGINS/check_cluster 2>&1"
cmd_check_dbi="$NAGIOS_PLUGINS/check_dbi 2>&1"
cmd_check_dhcp="$NAGIOS_PLUGINS/check_dhcp 2>&1"
cmd_check_dig="$NAGIOS_PLUGINS/check_dig 2>&1"
cmd_check_disk="$NAGIOS_PLUGINS/check_disk 2>&1"
cmd_check_disk_smb="$NAGIOS_PLUGINS/check_disk_smb 2>&1"
cmd_check_dns="$NAGIOS_PLUGINS/check_dns 2>&1"
cmd_check_dummy="$NAGIOS_PLUGINS/check_dummy 2>&1"
cmd_check_file_age="$NAGIOS_PLUGINS/check_file_age 2>&1"
cmd_check_flexlm="$NAGIOS_PLUGINS/check_flexlm 2>&1"
cmd_check_fping="$NAGIOS_PLUGINS/check_fping 2>&1"
cmd_check_ftp="$NAGIOS_PLUGINS/check_ftp 2>&1"
cmd_check_hpjd="$NAGIOS_PLUGINS/check_hpjd 2>&1"
cmd_check_http="$NAGIOS_PLUGINS/check_http 2>&1"
cmd_check_icmp="$NAGIOS_PLUGINS/check_icmp 2>&1"
cmd_check_ide_smart="$NAGIOS_PLUGINS/check_ide_smart 2>&1"
cmd_check_ifoperstatus="$NAGIOS_PLUGINS/check_ifoperstatus 2>&1"
cmd_check_ifstatus="$NAGIOS_PLUGINS/check_ifstatus 2>&1"
cmd_check_imap="$NAGIOS_PLUGINS/check_imap 2>&1"
cmd_check_ircd="$NAGIOS_PLUGINS/check_ircd 2>&1"
cmd_check_jabber="$NAGIOS_PLUGINS/check_jabber 2>&1"
cmd_check_ldap="$NAGIOS_PLUGINS/check_ldap 2>&1"
cmd_check_ldaps="$NAGIOS_PLUGINS/check_ldaps 2>&1"
cmd_check_load="$NAGIOS_PLUGINS/check_load 2>&1"
cmd_check_log="$NAGIOS_PLUGINS/check_log 2>&1"
cmd_check_mailq="$NAGIOS_PLUGINS/check_mailq 2>&1"
cmd_check_mrtg="$NAGIOS_PLUGINS/check_mrtg 2>&1"
cmd_check_mrtgtraf="$NAGIOS_PLUGINS/check_mrtgtraf 2>&1"
cmd_check_mysql="$NAGIOS_PLUGINS/check_mysql 2>&1"
cmd_check_mysql_query="$NAGIOS_PLUGINS/check_mysql_query 2>&1"
cmd_check_nagios="$NAGIOS_PLUGINS/check_nagios 2>&1"
cmd_check_nntp="$NAGIOS_PLUGINS/check_nntp 2>&1"
cmd_check_nntps="$NAGIOS_PLUGINS/check_nntps 2>&1"
cmd_check_nrpe="$NAGIOS_PLUGINS/check_nrpe 2>&1"
cmd_check_nt="$NAGIOS_PLUGINS/check_nt 2>&1"
cmd_check_ntp="$NAGIOS_PLUGINS/check_ntp 2>&1"
cmd_check_ntp_peer="$NAGIOS_PLUGINS/check_ntp_peer 2>&1"
cmd_check_ntp_time="$NAGIOS_PLUGINS/check_ntp_time 2>&1"
cmd_check_nwstat="$NAGIOS_PLUGINS/check_nwstat 2>&1"
cmd_check_oracle="$NAGIOS_PLUGINS/check_oracle 2>&1"
cmd_check_overcr="$NAGIOS_PLUGINS/check_overcr 2>&1"
cmd_check_pgsql="$NAGIOS_PLUGINS/check_pgsql 2>&1"
cmd_check_ping="$NAGIOS_PLUGINS/check_ping 2>&1"
cmd_check_pop="$NAGIOS_PLUGINS/check_pop 2>&1"
cmd_check_procs="$NAGIOS_PLUGINS/check_procs 2>&1"
cmd_check_radius="$NAGIOS_PLUGINS/check_radius 2>&1"
cmd_check_real="$NAGIOS_PLUGINS/check_real 2>&1"
cmd_check_rpc="$NAGIOS_PLUGINS/check_rpc 2>&1"
cmd_check_sensors="$NAGIOS_PLUGINS/check_sensors 2>&1"
cmd_check_simap="$NAGIOS_PLUGINS/check_simap 2>&1"
cmd_check_smtp="$NAGIOS_PLUGINS/check_smtp 2>&1"
cmd_check_snmp="$NAGIOS_PLUGINS/check_snmp 2>&1"
cmd_check_spop="$NAGIOS_PLUGINS/check_spop 2>&1"
cmd_check_ssh="$NAGIOS_PLUGINS/check_ssh 2>&1"
cmd_check_ssl_validity="$NAGIOS_PLUGINS/check_ssl_validity 2>&1"
cmd_check_ssmtp="$NAGIOS_PLUGINS/check_ssmtp 2>&1"
cmd_check_swap="$NAGIOS_PLUGINS/check_swap 2>&1"
cmd_check_tcp="$NAGIOS_PLUGINS/check_tcp 2>&1"
cmd_check_time="$NAGIOS_PLUGINS/check_time 2>&1"
cmd_check_udp="$NAGIOS_PLUGINS/check_udp 2>&1"
cmd_check_ups="$NAGIOS_PLUGINS/check_ups 2>&1"
cmd_check_uptime="$NAGIOS_PLUGINS/check_uptime 2>&1"
cmd_check_users="$NAGIOS_PLUGINS/check_users 2>&1"
cmd_check_wave="$NAGIOS_PLUGINS/check_wave 2>&1"


# TESTING AREA! 
#   WARNING!
# FLAMMABLE MATERIALS!

@test "Test run check_apt with no arguments" {
  result=$(${cmd_check_apt})
  echo "$result" | egrep "APT UNKNOWN: 0 packages available for upgrade"
  [ "$?" -eq 0 ]
}

@test "Test run check_breeze with no arguments" {
  result=$(${cmd_check_breeze})
  echo "$result" | egrep "Host name/address not specified"
  [ "$?" -eq 0 ]
}

@test "Test run check_by_ssh with no arguments" {
  result=$(${cmd_check_by_ssh})
  echo "$result" | egrep "check_by_ssh: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_clamd with no arguments" {
  result=$(${cmd_check_clamd})
  echo "$result" | egrep "check_clamd: No arguments found"
  [ "$?" -eq 0 ]
}

@test "Test run check_cluster with no arguments" {
  result=$(${cmd_check_cluster})
  echo "$result" | egrep "Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_dbi with no arguments" {
  result=$(${cmd_check_dbi})
  echo "$result" | egrep "Must specify a DBI driver"
  [ "$?" -eq 0 ]
}

@test "Test run check_dhcp with no arguments" {
  result=$(${cmd_check_dhcp})
  echo "$result" | egrep "CRITICAL: No DHCPOFFERs were received."
  [ "$?" -eq 0 ]
}

@test "Test run check_dig with no arguments" {
  result=$(${cmd_check_dig})
  echo "$result" | egrep "check_dig: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_disk with no arguments" {
  result=$(${cmd_check_disk})
  echo "$result" | egrep "check_disk: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_disk_smb with no arguments" {
  result=$(${cmd_check_disk_smb})
  echo "$result" | egrep TODO
  [ "$?" -eq 0 ]
}

@test "Test run check_dns with no arguments" {
  result=$(${cmd_check_dns})
  echo "$result" | egrep "check_dns: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_dummy with no arguments" {
  result=$(${cmd_check_dummy})
  echo "$result" | egrep "check_dummy: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_file_age with no arguments" {
  result=$(${cmd_check_file_age})
  echo "$result" | egrep "FILE_AGE UNKNOWN: No file specified"
  [ "$?" -eq 0 ]
}

@test "Test run check_flexlm with no arguments" {
  result=$(${cmd_check_flexlm})
  echo "$result" | egrep "Missing license.dat file"
  [ "$?" -eq 0 ]
}

@test "Test run check_fping with no arguments" {
  result=$(${cmd_check_fping})
  echo "$result" | egrep "check_fping: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_ftp with no arguments" {
  result=$(${cmd_check_ftp})
  echo "$result" | egrep "check_ftp: No arguments found"
  [ "$?" -eq 0 ]
}

@test "Test run check_hpjd with no arguments" {
  result=$(${cmd_check_hpjd})
  echo "$result" | egrep "check_hpjd: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_http with no arguments" {
  result=$(${cmd_check_http})
  echo "$result" | egrep "check_http: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_icmp with no arguments" {
  result=$(${cmd_check_icmp})
  echo "$result" | egrep "check_icmp: No hosts to check"
  [ "$?" -eq 0 ]
}

@test "Test run check_ide_smart with no arguments" {
  result=$(${cmd_check_ide_smart})
  echo "$result" | egrep "check_ide_smart \[-d <device>\]"
  [ "$?" -eq 0 ]
}

@test "Test run check_ifoperstatus with no arguments" {
  result=$(${cmd_check_ifoperstatus})
  echo "$result" | egrep "Hostname invalid or not given"
  [ "$?" -eq 0 ]
}

@test "Test run check_ifstatus with no arguments" {
  result=$(${cmd_check_ifstatus})
  echo "$result" | egrep "Hostname invalid or not given"
  [ "$?" -eq 0 ]
}

@test "Test run check_imap with no arguments" {
  result=$(${cmd_check_imap})
  echo "$result" | egrep "check_imap: No arguments found"
  [ "$?" -eq 0 ]
}

@test "Test run check_ircd with no arguments" {
  result=$(${cmd_check_ircd})
  echo "$result" | egrep "Host name/address not specified"
  [ "$?" -eq 0 ]
}

@test "Test run check_jabber with no arguments" {
  result=$(${cmd_check_jabber})
  echo "$result" | egrep "check_jabber: No arguments found"
  [ "$?" -eq 0 ]
}

@test "Test run check_ldap with no arguments" {
  result=$(${cmd_check_ldap})
  echo "$result" | egrep "check_ldap: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_ldaps with no arguments" {
  result=$(${cmd_check_ldaps})
  echo "$result" | egrep "check_ldaps: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_load with no arguments" {
  result=$(${cmd_check_load})
  echo "$result" | egrep "check_load: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_log with no arguments" {
  result=$(${cmd_check_log})
  echo "$result" | egrep "Usage: check_log -F logfile -O oldlog -q query"
  [ "$?" -eq 0 ]
}

@test "Test run check_mailq with no arguments" {
  result=$(${cmd_check_mailq})
  echo "$result" | egrep "Usage: check_mailq -w"
  [ "$?" -eq 0 ]
}

@test "Test run check_mrtg with no arguments" {
  result=$(${cmd_check_mrtg})
  echo "$result" | egrep "check_mrtg: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_mrtgtraf with no arguments" {
  result=$(${cmd_check_mrtgtraf})
  echo "$result" | egrep "check_mrtgtraf: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_mysql with no arguments" {
  result=$(${cmd_check_mysql})
  echo "$result" | egrep "Can't connect to local MySQL server through socket"
  [ "$?" -eq 0 ]
}

@test "Test run check_mysql_query with no arguments" {
  result=$(${cmd_check_mysql_query})
  echo "$result" | egrep "Must specify a SQL query to run"
  [ "$?" -eq 0 ]
}

@test "Test run check_nagios with no arguments" {
  result=$(${cmd_check_nagios})
  echo "$result" | egrep "check_nagios: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_nntp with no arguments" {
  result=$(${cmd_check_nntp})
  echo "$result" | egrep "check_nntp: No arguments found"
  [ "$?" -eq 0 ]
}

@test "Test run check_nntps with no arguments" {
  result=$(${cmd_check_nntps})
  echo "$result" | egrep "check_nntps: No arguments found"
  [ "$?" -eq 0 ]
}

@test "Test run check_nrpe with no arguments" {
  result=$(${cmd_check_nrpe})
  echo "$result" | egrep "Incorrect command line arguments supplied"
  [ "$?" -eq 0 ]
}

@test "Test run check_nt with no arguments" {
  result=$(${cmd_check_nt})
  echo "$result" | egrep "check_nt: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_ntp with no arguments" {
  result=$(${cmd_check_ntp})
  echo "$result" | egrep "check_ntp -H"
  [ "$?" -eq 0 ]
}

@test "Test run check_ntp_peer with no arguments" {
  result=$(${cmd_check_ntp_peer})
  echo "$result" | egrep "check_ntp_peer -H <host>"
  [ "$?" -eq 0 ]
}

@test "Test run check_ntp_time with no arguments" {
  result=$(${cmd_check_ntp_time})
  echo "$result" | egrep "check_ntp_time -H <host>"
  [ "$?" -eq 0 ]
}

@test "Test run check_nwstat with no arguments" {
  result=$(${cmd_check_nwstat})
  echo "$result" | egrep "check_nwstat: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_oracle with no arguments" {
  result=$(${cmd_check_oracle})
  echo "$result" | egrep "Cannot determine ORACLE_HOME for sid "
  [ "$?" -eq 0 ]
}

@test "Test run check_overcr with no arguments" {
  result=$(${cmd_check_overcr})
  echo "$result" | egrep "check_overcr: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_pgsql with no arguments" {
  result=$(${cmd_check_pgsql})
  echo "$result" | egrep "CRITICAL - no connection to 'template1'"
  [ "$?" -eq 0 ]
}

@test "Test run check_ping with no arguments" {
  result=$(${cmd_check_ping})
  echo "$result" | egrep "check_ping: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_pop with no arguments" {
  result=$(${cmd_check_pop})
  echo "$result" | egrep "check_pop: No arguments found"
  [ "$?" -eq 0 ]
}

@test "Test run check_procs with no arguments" {
  result=$(${cmd_check_procs})
  echo "$result" | egrep "PROCS OK:"
  [ "$?" -eq 0 ]
}

@test "Test run check_radius with no arguments" {
  result=$(${cmd_check_radius})
  echo "$result" | egrep "check_radius: Hostname was not supplied"
  [ "$?" -eq 0 ]
}

@test "Test run check_real with no arguments" {
  result=$(${cmd_check_real})
  echo "$result" | egrep "check_real: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_rpc with no arguments" {
  result=$(${cmd_check_rpc})
  echo "$result" | egrep "check_rpc -H host"
  [ "$?" -eq 0 ]
}

@test "Test run check_sensors with no arguments" {
  result=$(${cmd_check_sensors})
  echo "$result" | egrep "WARNING - sensors returned state"
  [ "$?" -eq 0 ]
}

@test "Test run check_simap with no arguments" {
  result=$(${cmd_check_simap})
  echo "$result" | egrep "check_simap: No arguments found"
  [ "$?" -eq 0 ]
}

@test "Test run check_smtp with no arguments" {
  result=$(${cmd_check_smtp})
  echo "$result" | egrep "check_smtp: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_snmp with no arguments" {
  result=$(${cmd_check_snmp})
  echo "$result" | egrep "check_snmp: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_spop with no arguments" {
  result=$(${cmd_check_spop})
  echo "$result" | egrep "check_spop: No arguments found"
  [ "$?" -eq 0 ]
}

@test "Test run check_ssh with no arguments" {
  result=$(${cmd_check_ssh})
  echo "$result" | egrep "check_ssh: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_ssl_validity with no arguments" {
  result=$(${cmd_check_ssl_validity})
  echo "$result" | egrep "check_ssl_validity -H <cert"
  [ "$?" -eq 0 ]
}

@test "Test run check_ssmtp with no arguments" {
  result=$(${cmd_check_ssmtp})
  echo "$result" | egrep "check_ssmtp: No arguments found"
  [ "$?" -eq 0 ]
}

@test "Test run check_swap with no arguments" {
  result=$(${cmd_check_swap})
  echo "$result" | egrep "check_swap: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_tcp with no arguments" {
  result=$(${cmd_check_tcp})
  echo "$result" | egrep "check_tcp: No arguments found"
  [ "$?" -eq 0 ]
}

@test "Test run check_time with no arguments" {
  result=$(${cmd_check_time})
  echo "$result" | egrep "check_time -H <host_address>"
  [ "$?" -eq 0 ]
}

@test "Test run check_udp with no arguments" {
  result=$(${cmd_check_udp})
  echo "$result" | egrep "check_udp: No arguments found"
  [ "$?" -eq 0 ]
}

@test "Test run check_ups with no arguments" {
  result=$(${cmd_check_ups})
  echo "$result" | egrep "check_ups: Could not parse arguments"
  [ "$?" -eq 0 ]
}

@test "Test run check_uptime with no arguments" {
  result=$(${cmd_check_uptime})
  echo "$result" | egrep "Uptime OK:"
  [ "$?" -eq 0 ]
}

@test "Test run check_users with no arguments" {
  result=$(${cmd_check_users})
  echo "$result" | egrep "check_users -w"
  [ "$?" -eq 0 ]
}

@test "Test run check_wave with no arguments" {
  result=$(${cmd_check_wave})
  echo "$result" | egrep "Usage: ./check_wave"
  [ "$?" -eq 0 ]
}
