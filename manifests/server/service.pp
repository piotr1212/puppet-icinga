# == Class: icinga::server::service
#
# This class provides the daemon configuration.
#
class icinga::server::service {
  Service {
    require => Class['icinga::server::config'],
  }

  case $::operatingsystem {
    'Debian', 'Ubuntu': {
      service {
        $icinga::server::service_server:
          ensure     => $icinga::server::service_server_ensure,
          enable     => $icinga::server::service_server_enable,
          hasrestart => $icinga::server::service_server_hasrestart,
          hasstatus  => $icinga::server::service_server_hasstatus,
      }
    }

    'RedHat', 'CentOS', 'Scientific', 'OEL', 'Amazon': {
      service {
        $icinga::server::service_server:
          ensure     => $icinga::server::service_server_ensure,
          enable     => $icinga::server::service_server_enable,
          hasrestart => $icinga::server::service_server_hasrestart,
          hasstatus  => $icinga::server::service_server_hasstatus,
      }
    }

    default: {}
  }
}

