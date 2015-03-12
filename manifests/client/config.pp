# == Class: icinga::config::client::common
#
# This class provides common client configuration.
#
class icinga::client::config {

  File {
    owner   => $::icinga::client::client_user,
    group   => $::icinga::client::client_group,
    notify  => Service[$::icinga::client::service_client],
    require => Class['icinga::client::install'],
  }

  file{$::icinga::client::confdir_client:
    ensure  => directory,
    recurse => true,
  }

  file{$::icinga::client::plugindir:
    ensure => directory,
  }

  file{"${::icinga::client::confdir_client}/nrpe.cfg":
    ensure  => present,
    content => template('icinga/common/nrpe.cfg.erb'),
  }

  file{$::icinga::client::logdir_client:
    ensure => directory,
  }

  file{$::icinga::client::includedir_client:
    ensure => directory,
  }

}
