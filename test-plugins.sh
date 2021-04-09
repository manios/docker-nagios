#!/usr/bin/env bats

NAGIOS_PLUGINS=${NAGIOS_HOME}/libexec

# @test "Test check_apt" {
#   result="$($NAGIOS_PLUGINS/check_apt | egrep )"
#   [ "$result" -eq 4 ]
# }

@test "Test check_breeze" {
  result="$($NAGIOS_PLUGINS/check_breeze | egrep )"
  [ "$result" -eq 4 ]
}

@test "addition using dc" {
  result="$(echo 2 2+p | dc)"
  [ "$result" -eq 4 ]
}
