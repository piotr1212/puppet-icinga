# == Class: icinga::client::plugins::checkmem
#
# This class provides a checkmem plugin.
#
class icinga::client::plugins::checkmem (
  $contact_groups        = $::icinga::contact_groups,
  $max_check_attempts    = $::icinga::max_check_attempts,
  $notification_period   = $::icinga::notification_period,
  $notifications_enabled = $::icinga::notifications_enabled,
) inherits icinga::client {

  if $icinga::client {
    package{'nagios-plugins-mem':
      ensure => 'present',
    }

    @@nagios_service{"check_mem_${::fqdn}":
      check_command         => 'check_nrpe_command!check_mem',
      service_description   => 'RAM',
      host_name             => $::fqdn,
      contact_groups        => $contact_groups,
      max_check_attempts    => $max_check_attempts,
      notification_period   => $notification_period,
      notifications_enabled => $notifications_enabled,
      target                => "${::icinga::targetdir}/services/${::fqdn}.cfg",
    }
  }

}