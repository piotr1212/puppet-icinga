# == Class: icinga::server::config::common
#
# This class provides common server configuration
#
class icinga::server::config::common {

  include icinga::server

  File {
    ensure  => 'directory',
    owner   => $::icinga::server::server_user,
    group   => $::icinga::server::server_group,
    notify  => [
      #Service[$::icinga::server::service_client],
      Service[$::icinga::server::service_server],
    ],
  }

#  file{$::icinga::server::confdir_server:
#    recurse => true,
#    purge   => true,
#  }

  file{"${::icinga::server::confdir_server}/resource.cfg":
    ensure  => file,
    content => template('icinga/common/resource.cfg.erb'),
  }

  file{$::icinga::server::targetdir:
    recurse => true,
    purge   => true,
  }

  file{"${::icinga::server::targetdir}/hosts":
    recurse => true,
  }

  file{"${::icinga::server::sharedir_server}/bin":
    recurse => true,
  }

  file{"${::icinga::server::sharedir_server}/bin/sched_down.pl":
    ensure => file,
    owner  => $::icinga::server::server_user,
    group  => $::icinga::server::server_group,
    source => 'puppet:///modules/icinga/sched_down.pl',
  }

  file{"${::icinga::server::targetdir}/hostgroups.cfg":
    ensure => 'present',
  }

  concat{"${::icinga::server::confdir_server}/downtime.cfg":}
  concat::fragment {'header':
    target  => "${::icinga::server::confdir_server}/downtime.cfg",
    order   => 0,
    content => "# Managed by Puppet\n",
  }

  file{"${::icinga::server::targetdir}/timeperiods.cfg":
    ensure => 'present',
  }

  file{"${::icinga::server::targetdir}/contacts":
    recurse => true,
  }

  file{"${::icinga::server::targetdir}/services":
    recurse => true,
  }

  file{"${::icinga::server::targetdir}/commands":
    recurse => true,
  }

  file{"${::icinga::server::targetdir}/commands.cfg":
    ensure  => file,
    content => template('icinga/common/commands.cfg.erb'),
  }

  file{"${::icinga::server::targetdir}/generic-host.cfg":
    ensure  => file,
    content => template('icinga/common/generic-host.cfg'),
  }

  file{"${::icinga::server::targetdir}/generic-service.cfg":
    ensure  => file,
    content => template('icinga/common/generic-service.cfg'),
  }

  file{"${::icinga::server::sharedir_server}/images/logos":}

  file{"${::icinga::server::sharedir_server}/images/logos/os":
    recurse => true,
    source  => 'puppet:///modules/icinga/img-os',
  }

  file{$::icinga::server::htpasswd_file:
    ensure => 'present',
    mode   => '0644',
  }

  nagios_command {'schedule_script':
    command_line => "${::icinga::server::sharedir_server}/bin/sched_down.pl -c ${::icinga::server::confdir_server}/icinga.cfg -s ${::icinga::server::confdir_server}/downtime.cfg \$ARG1\$",
    target       => "${::icinga::server::targetdir}/commands/schedule_script.cfg",
  }

  nagios_command{'check_nrpe_command':
    command_line => "\$USER1\$/check_nrpe -t ${::icinga::server::nrpe_connect_timeout} -H \$HOSTADDRESS\$ -c \$ARG1\$",
    target       => "${::icinga::server::targetdir}/commands/check_nrpe_command.cfg",
  }

  nagios_service {'schedule_downtimes':
    check_command       => 'schedule_script!-d0',
    service_description => 'Schedule Downtimes',
    host_name           => $::fqdn,
    target              => "/etc/icinga/objects/services/${::fqdn}.cfg",
    max_check_attempts  => '4',
  }
}
