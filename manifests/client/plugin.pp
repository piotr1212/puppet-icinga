# == Define: icinga::plugin
#
# This class provides plugin support.
#
## TODO: is this needed?
define icinga::client::plugin {
  class {
    "icinga::client::plugins::${name}":;
  }
}

