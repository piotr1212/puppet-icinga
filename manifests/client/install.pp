# == Class: icinga::install
#
# This class provides the main install selector.
#
class icinga::client::install {
  #Package {
    #require => Class['icinga::client::preinstall'],
  #}

  package { $::icinga::client::package_client:
    ensure => $::icinga::client::package_client_ensure;
  }
}
