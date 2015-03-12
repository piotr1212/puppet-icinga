# == Class: icinga::plugins
#
# Full description of class.
#
class icinga::client::plugins {
  if $icinga::client::plugins {
    icinga::client::plugin { $icinga::client::plugins:; }
  }
}

