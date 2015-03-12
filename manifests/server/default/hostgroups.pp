# == Class: icinga::default::hostgroups
#
# This class provides default hostgroup configuration.
#
class icinga::server::default::hostgroups {

  Nagios_hostgroup {
    notify => Service[$::icinga::server::service_server],
    target => "${::icinga::server::targetdir}/hostgroups.cfg",
  }

  nagios_hostgroup{'all':
    hostgroup_name => 'all',
    alias          => 'All Servers',
    members        => '*',
  }

  nagios_hostgroup{'default':
    hostgroup_name => 'default',
    alias          => 'Default hostgroup',
  }

}
