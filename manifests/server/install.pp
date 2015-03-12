# == Class: icinga::server::install
#
# This class provides the main install selector.
#
class icinga::server::install {
  #Package {
    #require => Class['icinga::server::preinstall'],
  #}

  package { $::icinga::server::package_server:
    ensure => $::icinga::server::package_server_ensure;
  }
}
