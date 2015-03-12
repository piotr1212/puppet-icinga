# == Class: icinga::config::server
#
# This class provides server configuration.
#
class icinga::server::config {
  include ::icinga::server::config::common

  case $::operatingsystem {
    'Debian', 'Ubuntu': {
      include icinga::server::config::debian
    }

    'RedHat', 'CentOS', 'Scientific', 'OEL', 'Amazon': {
      include icinga::server::config::redhat
    }

    default: {
      fail 'Operatingsystem not supported.'
    }
  }

  @group { 'nagios':
    ensure  => present,
    members => [
      $::icinga::server::server_group,
      $::icinga::server::webserver_group
    ];
  }

  @group { 'icinga':
    ensure  => present,
    members => [
      $::icinga::server::server_group,
      $::icinga::server::webserver_group
    ];
  }

  @group { 'icingacmd':
    ensure  => present,
    members => [
      $::icinga::server::server_group,
      $::icinga::server::webserver_group
    ];
  }

  realize Group[$::icinga::server::server_cmd_group]

  include ::icinga::server::default::hostgroups
  include ::icinga::server::default::timeperiods
}
