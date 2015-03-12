# == Class: icinga::client::plugins::pnp4nagios
#
# This class provides the pnp4nagios plugin.
#
class icinga::client::plugins::pnp4nagios (
  $ensure = present
) {
  if $icinga::server {
    include icinga::client::plugins::pnp4nagios::install
    include icinga::client::plugins::pnp4nagios::config

    Class['icinga::client::plugins::pnp4nagios::install'] -> Class['icinga::plugins::pnp4nagios::config']
  }
}
