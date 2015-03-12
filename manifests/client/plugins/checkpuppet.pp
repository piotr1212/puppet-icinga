# == Class: icinga::client::plugins::checkpuppet
#
# This class provides a checkpuppet plugin.
#
class icinga::client::plugins::checkpuppet (
  $contact_groups        = $::icinga::client::contact_groups,
  $max_check_attempts    = $::icinga::client::max_check_attempts,
  $notification_period   = $::icinga::client::notification_period,
  $notifications_enabled = $::icinga::client::notifications_enabled,
) inherits icinga::client {

  file { "${::icinga::client::plugindir}/check_puppet":
    ensure  => present,
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    seltype => 'nagios_admin_plugin_exec_t',
    content => template ('icinga/plugins/check_puppet.rb.erb'),
    notify  => Service[$icinga::client::service_client],
    require => Class['icinga::client::config'];
  }

  file{"${::icinga::client::includedir_client}/puppet.cfg":
    ensure  => 'file',
    mode    => '0644',
    owner   => $::icinga::client::client_user,
    group   => $::icinga::client::client_group,
    content => "command[check_puppet]=${::icinga::client::plugindir}/check_puppet -w 604800 -c 907200\n",
    notify  => Service[$::icinga::client::service_client],
  }

  @@nagios_service { "check_puppet_${::fqdn}":
    check_command         => 'check_nrpe_command!check_puppet',
    service_description   => 'Puppet',
    host_name             => $::fqdn,
    contact_groups        => $contact_groups,
    max_check_attempts    => $max_check_attempts,
    notification_period   => $notification_period,
    notifications_enabled => $notifications_enabled,
    target                => "${::icinga::client::targetdir}/services/${::fqdn}.cfg",
  }
}
