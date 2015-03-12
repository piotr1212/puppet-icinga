# == Class: icinga::client::service
#
# This class provides the daemon configuration.
#
class icinga::client::service {
  Service {
    require => Class['icinga::client::config'],
  }

  case $::operatingsystem {
    'Debian', 'Ubuntu': {
      service {
        $icinga::client::service_client:
          ensure     => $icinga::client::service_client_ensure,
          enable     => $icinga::client::service_client_enable,
          hasrestart => $icinga::client::service_client_hasrestart,
          hasstatus  => $icinga::client::service_client_hasstatus,
          pattern    => $icinga::client::service_client_pattern,
      }
    }

    'RedHat', 'CentOS', 'Scientific', 'OEL', 'Amazon': {
      service {
        $icinga::client::service_client:
          ensure     => $icinga::client::service_client_ensure,
          enable     => $icinga::client::service_client_enable,
          hasrestart => $icinga::client::service_client_hasrestart,
          hasstatus  => $icinga::client::service_client_hasstatus,
      }
    }

    default: {}
  }
}

