#!/usr/bin/env bats

# apk add libldap mariadb-connector-c freeradius-client-dev libpq libdbi lm-sensors perl net-snmp-perl perl-net-snmp perl-crypt-x509 perl-timedate perl-libwww perl-text-glob

# https://github.com/sstephenson/bats

NAGIOS_PLUGINS=/opt/nagios/libexec

cmd_check_apt="$NAGIOS_PLUGINS/check_apt"
cmd_check_breeze="$NAGIOS_PLUGINS/check_breeze"
cmd_check_by_ssh="$NAGIOS_PLUGINS/check_by_ssh"
cmd_check_clamd="$NAGIOS_PLUGINS/check_clamd"
cmd_check_cluster="$NAGIOS_PLUGINS/check_cluster"
cmd_check_dbi="$NAGIOS_PLUGINS/check_dbi"
cmd_check_dhcp="$NAGIOS_PLUGINS/check_dhcp"
cmd_check_dig="$NAGIOS_PLUGINS/check_dig"
cmd_check_disk="$NAGIOS_PLUGINS/check_disk"
cmd_check_disk_smb="$NAGIOS_PLUGINS/check_disk_smb"
cmd_check_dns="$NAGIOS_PLUGINS/check_dns"
cmd_check_dummy="$NAGIOS_PLUGINS/check_dummy"
cmd_check_file_age="$NAGIOS_PLUGINS/check_file_age"
cmd_check_flexlm="$NAGIOS_PLUGINS/check_flexlm"
cmd_check_fping="$NAGIOS_PLUGINS/check_fping"
cmd_check_ftp="$NAGIOS_PLUGINS/check_ftp"
cmd_check_hpjd="$NAGIOS_PLUGINS/check_hpjd"
cmd_check_http="$NAGIOS_PLUGINS/check_http"
cmd_check_icmp="$NAGIOS_PLUGINS/check_icmp"
cmd_check_ide_smart="$NAGIOS_PLUGINS/check_ide_smart"
cmd_check_ifoperstatus="$NAGIOS_PLUGINS/check_ifoperstatus"
cmd_check_ifstatus="$NAGIOS_PLUGINS/check_ifstatus"
cmd_check_imap="$NAGIOS_PLUGINS/check_imap"
cmd_check_ircd="$NAGIOS_PLUGINS/check_ircd"
cmd_check_jabber="$NAGIOS_PLUGINS/check_jabber"
cmd_check_ldap="$NAGIOS_PLUGINS/check_ldap"
cmd_check_ldaps="$NAGIOS_PLUGINS/check_ldaps"
cmd_check_load="$NAGIOS_PLUGINS/check_load"
cmd_check_log="$NAGIOS_PLUGINS/check_log"
cmd_check_mailq="$NAGIOS_PLUGINS/check_mailq"
cmd_check_mrtg="$NAGIOS_PLUGINS/check_mrtg"
cmd_check_mrtgtraf="$NAGIOS_PLUGINS/check_mrtgtraf"
cmd_check_mysql="$NAGIOS_PLUGINS/check_mysql"
cmd_check_mysql_query="$NAGIOS_PLUGINS/check_mysql_query"
cmd_check_nagios="$NAGIOS_PLUGINS/check_nagios"
cmd_check_nntp="$NAGIOS_PLUGINS/check_nntp"
cmd_check_nntps="$NAGIOS_PLUGINS/check_nntps"
cmd_check_nrpe="$NAGIOS_PLUGINS/check_nrpe"
cmd_check_nt="$NAGIOS_PLUGINS/check_nt"
cmd_check_ntp="$NAGIOS_PLUGINS/check_ntp"
cmd_check_ntp_peer="$NAGIOS_PLUGINS/check_ntp_peer"
cmd_check_ntp_time="$NAGIOS_PLUGINS/check_ntp_time"
cmd_check_nwstat="$NAGIOS_PLUGINS/check_nwstat"
cmd_check_oracle="$NAGIOS_PLUGINS/check_oracle"
cmd_check_overcr="$NAGIOS_PLUGINS/check_overcr"
cmd_check_pgsql="$NAGIOS_PLUGINS/check_pgsql"
cmd_check_ping="$NAGIOS_PLUGINS/check_ping"
cmd_check_pop="$NAGIOS_PLUGINS/check_pop"
cmd_check_procs="$NAGIOS_PLUGINS/check_procs"
cmd_check_radius="$NAGIOS_PLUGINS/check_radius"
cmd_check_real="$NAGIOS_PLUGINS/check_real"
cmd_check_rpc="$NAGIOS_PLUGINS/check_rpc"
cmd_check_sensors="$NAGIOS_PLUGINS/check_sensors"
cmd_check_simap="$NAGIOS_PLUGINS/check_simap"
cmd_check_smtp="$NAGIOS_PLUGINS/check_smtp"
cmd_check_snmp="$NAGIOS_PLUGINS/check_snmp"
cmd_check_spop="$NAGIOS_PLUGINS/check_spop"
cmd_check_ssh="$NAGIOS_PLUGINS/check_ssh"
cmd_check_ssl_validity="$NAGIOS_PLUGINS/check_ssl_validity"
cmd_check_ssmtp="$NAGIOS_PLUGINS/check_ssmtp"
cmd_check_swap="$NAGIOS_PLUGINS/check_swap"
cmd_check_tcp="$NAGIOS_PLUGINS/check_tcp"
cmd_check_time="$NAGIOS_PLUGINS/check_time"
cmd_check_udp="$NAGIOS_PLUGINS/check_udp"
cmd_check_ups="$NAGIOS_PLUGINS/check_ups"
cmd_check_uptime="$NAGIOS_PLUGINS/check_uptime"
cmd_check_users="$NAGIOS_PLUGINS/check_users"
cmd_check_wave="$NAGIOS_PLUGINS/check_wave"


# TESTING AREA! 
#   WARNING!
# FLAMMABLE MATERIALS!

@test "Test run check_apt with no arguments" {
  result=$(${cmd_check_apt})
  echo "$result" | egrep overlay
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
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_log with no arguments" {
  result=$(${cmd_check_log})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_mailq with no arguments" {
  result=$(${cmd_check_mailq})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_mrtg with no arguments" {
  result=$(${cmd_check_mrtg})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_mrtgtraf with no arguments" {
  result=$(${cmd_check_mrtgtraf})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_mysql with no arguments" {
  result=$(${cmd_check_mysql})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_mysql_query with no arguments" {
  result=$(${cmd_check_mysql_query})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_nagios with no arguments" {
  result=$(${cmd_check_nagios})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_nntp with no arguments" {
  result=$(${cmd_check_nntp})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_nntps with no arguments" {
  result=$(${cmd_check_nntps})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_nrpe with no arguments" {
  result=$(${cmd_check_nrpe})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_nt with no arguments" {
  result=$(${cmd_check_nt})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_ntp with no arguments" {
  result=$(${cmd_check_ntp})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_ntp_peer with no arguments" {
  result=$(${cmd_check_ntp_peer})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_ntp_time with no arguments" {
  result=$(${cmd_check_ntp_time})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_nwstat with no arguments" {
  result=$(${cmd_check_nwstat})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_oracle with no arguments" {
  result=$(${cmd_check_oracle})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_overcr with no arguments" {
  result=$(${cmd_check_overcr})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_pgsql with no arguments" {
  result=$(${cmd_check_pgsql})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_ping with no arguments" {
  result=$(${cmd_check_ping})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_pop with no arguments" {
  result=$(${cmd_check_pop})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_procs with no arguments" {
  result=$(${cmd_check_procs})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_radius with no arguments" {
  result=$(${cmd_check_radius})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_real with no arguments" {
  result=$(${cmd_check_real})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_rpc with no arguments" {
  result=$(${cmd_check_rpc})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_sensors with no arguments" {
  result=$(${cmd_check_sensors})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_simap with no arguments" {
  result=$(${cmd_check_simap})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_smtp with no arguments" {
  result=$(${cmd_check_smtp})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_snmp with no arguments" {
  result=$(${cmd_check_snmp})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_spop with no arguments" {
  result=$(${cmd_check_spop})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_ssh with no arguments" {
  result=$(${cmd_check_ssh})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_ssl_validity with no arguments" {
  result=$(${cmd_check_ssl_validity})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_ssmtp with no arguments" {
  result=$(${cmd_check_ssmtp})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_swap with no arguments" {
  result=$(${cmd_check_swap})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_tcp with no arguments" {
  result=$(${cmd_check_tcp})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_time with no arguments" {
  result=$(${cmd_check_time})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_udp with no arguments" {
  result=$(${cmd_check_udp})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_ups with no arguments" {
  result=$(${cmd_check_ups})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_uptime with no arguments" {
  result=$(${cmd_check_uptime})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_users with no arguments" {
  result=$(${cmd_check_users})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}

@test "Test run check_wave with no arguments" {
  result=$(${cmd_check_wave})
  echo "$result" | egrep overlay
  [ "$?" -eq 0 ]
}
