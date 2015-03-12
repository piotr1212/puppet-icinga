# == Class: icinga::server::config::redhat
#
# This class provides server configuration for RHEL and derivative distro's.
#
class icinga::server::config::redhat {

  File {
    ensure  => present,
    owner   => $::icinga::server::server_user,
    group   => $::icinga::server::server_group,
    require => Class['icinga::server::config'],
    notify  => [
      #Service[$::icinga::server::service_client],
      Service[$::icinga::server::service_server],
      Exec['fix_collected_permissions']
    ],
  }

  exec { 'fix_collected_permissions':
    # temporary work-around
    command     => "/bin/chown -R ${::icinga::server::server_user}:${::icinga::server::server_group} .",
    cwd         => $icinga::params::targetdir, # TODO: check
    notify      => Service[$::icinga::server::service_server],
    require     => File[$::icinga::server::targetdir],
    refreshonly => true,
  }

  file{$::icinga::server::icinga_vhost:
    content => template('icinga/redhat/httpd.conf.erb'),
    notify  => Service[$::icinga::server::service_webserver],
  }

  file{$::icinga::server::vardir_server:
    ensure => directory,
  }

  file{$::icinga::server::logdir_server:
    ensure => directory,
  }

  file{"${::icinga::server::confdir_server}/modules":
    ensure  => directory,
    recurse => true,
  }

  file{"${::icinga::server::targetdir}/notifications.cfg":
    content => template('icinga/redhat/notifications.cfg.erb'),
  }

  file{"${::icinga::server::targetdir}/templates.cfg":
    content => template('icinga/redhat/templates.cfg.erb'),
  }

  file{"${::icinga::server::confdir_server}/cgi.cfg":
    content => template('icinga/redhat/cgi.cfg.erb'),
  }

  file{"${::icinga::server::confdir_server}/icinga.cfg":
    content => template('icinga/redhat/icinga.cfg.erb'),
  }

  file{"${::icinga::server::logdir_server}/archives":
    ensure => directory,
  }

  file{"${::icinga::server::vardir_server}/rw":
    ensure => directory,
    group  => $::icinga::server::server_cmd_group,
  }

  file{"${::icinga::server::vardir_server}/rw/icinga.cmd":
    group => $::icinga::server::webserver_group,
  }

  file{"${::icinga::server::vardir_server}/checkresults":
    ensure => directory,
  }
}
