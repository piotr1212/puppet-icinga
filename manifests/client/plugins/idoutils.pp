# == Class: icinga::client::plugins::idoutils
#
# This class provides the idoutils plugin.
#
class icinga::client::plugins::idoutils {
  if $icinga::server {
    include icinga::client::plugins::idoutils::install
    include icinga::client::plugins::idoutils::config
    include icinga::client::plugins::idoutils::service

    Class['icinga::client::plugins::idoutils::install'] ->
    Class['icinga::client::plugins::idoutils::config'] ->
    Class['icinga::client::plugins::idoutils::service']
  }
}
