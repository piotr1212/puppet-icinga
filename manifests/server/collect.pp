# == Class: icinga::server::client::collect
#
# This class provides resource collection.
#
class icinga::server::collect {

  if $::icinga::server::collect_resources {
    # Set defaults for collected resources.
    Nagios_host <<| |>>              { notify => Service[$::icinga::server::service_server] }
    Nagios_service <<| |>>           { notify => Service[$::icinga::server::service_server] }
    Nagios_hostextinfo <<| |>>       { notify => Service[$::icinga::server::service_server] }
    Nagios_command <<| |>>           { notify => Service[$::icinga::server::service_server] }
    Nagios_contact <<| |>>           { notify => Service[$::icinga::server::service_server] }
    Nagios_contactgroup <<| |>>      { notify => Service[$::icinga::server::service_server] }
    Nagios_hostdependency <<| |>>    { notify => Service[$::icinga::server::service_server] }
    Nagios_hostescalation <<| |>>    { notify => Service[$::icinga::server::service_server] }
    Nagios_hostgroup <<| |>>         {
      notify => Service[$::icinga::server::service_server],
      target => "${::icinga::server::targetdir}/hostgroups.cfg",
    }
    Nagios_servicedependency <<| |>> { notify => Service[$::icinga::server::service_server] }
    Nagios_serviceescalation <<| |>> { notify => Service[$::icinga::server::service_server] }
    Nagios_serviceextinfo <<| |>>    { notify => Service[$::icinga::server::service_server] }
    Nagios_servicegroup <<| |>>      { notify => Service[$::icinga::server::service_server] }
    Nagios_timeperiod <<| |>>        {
      notify => Service[$::icinga::server::service_server],
      target => "${::icinga::server::targetdir}/timeperiods.cfg",
    }
    Icinga::Downtime <<| |>>         { notify => Service[$::icinga::server::service_server] }
  }
}
