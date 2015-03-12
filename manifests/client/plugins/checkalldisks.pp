# == Class: icinga::client::plugins::checkalldisks
#
# This class provides a checkalldisks plugin.
#
class icinga::client::plugins::checkalldisks (
  $check_warning         = '10%',
  $check_critical        = '5%',
  $max_check_attempts    = $::icinga::client::max_check_attempts,
  $contact_groups        = $::icinga::client::contact_groups,
  $notification_period   = $::icinga::client::notification_period,
  $notifications_enabled = $::icinga::client::notifications_enabled,
) inherits icinga::client {

  file{"${::icinga::includedir_client}/all_disks.cfg":
    ensure  => 'file',
    mode    => '0644',
    owner   => $::icinga::client::client_user,
    group   => $::icinga::client::client_group,
    content => "command[check_all_disks]=sudo ${::icinga::client::plugindir}/check_disk -w ${check_warning} -c ${check_critical} -W ${check_warning} -C ${check_critical}\n",
    notify  => Service[$::icinga::client::service_client],
  }

  @@nagios_service { "check_all_disks_${::fqdn}":
    check_command         => 'check_nrpe_command!check_all_disks',
    service_description   => 'Disks',
    host_name             => $::fqdn,
    contact_groups        => $contact_groups,
    max_check_attempts    => $max_check_attempts,
    notification_period   => $notification_period,
    notifications_enabled => $notifications_enabled,
    target                => "${::icinga::client::targetdir}/services/${::fqdn}.cfg",
    action_url            => '/pnp4nagios/graph?host=$HOSTNAME$&srv=$SERVICEDESC$',
  }

}
