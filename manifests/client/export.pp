# == Class: icinga::client::export
#
# This class provides resource exporting.
#
class icinga::client::export {

  if $::icinga::client::export_resources {
    @@nagios_host{$::icinga::client::collect_hostname:
      ensure                => present,
      address               => $::icinga::client::collect_ipaddress,
      max_check_attempts    => $::icinga::client::max_check_attempts,
      check_command         => 'check-host-alive',
      use                   => 'linux-server',
      parents               => $::icinga::client::parents,
      hostgroups            => $::icinga::client::hostgroups,
      action_url            => '/pnp4nagios/graph?host=$HOSTNAME$',
      notification_period   => $::icinga::client::notification_period,
      notifications_enabled => $::icinga::client::notifications_enabled,
      icon_image_alt        => $::operatingsystem,
      icon_image            => "os/${::operatingsystem}.png",
      statusmap_image       => "os/${::operatingsystem}.png",
      target                => "${::icinga::client::targetdir}/hosts/host-${::fqdn}.cfg",
    }
  }
}
