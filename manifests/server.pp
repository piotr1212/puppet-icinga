# = Class: icinga
#
# == Sample Usage:
#
#
#
# == Known issues:
#  Admin users listed in cgi.cfg will be removed after a second puppet run
#  after the users have been removed from the htpasswd.users file. Once removed
#  from htpasswd.users they won't be able to login anymore.
#
class icinga::server (
  $client                                    = $::icinga::params::client,
  $client_group                              = $::icinga::params::client_group,
  $client_user                               = $::icinga::params::client_user,
  $use_auth                                  = $::icinga::params::use_auth,
  $confdir_client                            = $::icinga::params::confdir_client,
  $confdir_server                            = $::icinga::params::confdir_server,
  $icinga_admins                             = $::icinga::params::icinga_admins,
  $icinga_vhost                              = $::icinga::params::icinga_vhost,
  $includedir_client                         = $::icinga::params::includedir_client,
  $logdir_client                             = $::icinga::params::logdir_client,
  $logdir_server                             = $::icinga::params::logdir_server,
  $manage_repo                               = $::icinga::params::manage_repo,
  $max_check_attempts                        = $::icinga::params::max_check_attempts,
  $notification_period                       = $::icinga::params::notification_period,
  $notification_interval                     = $::icinga::params::notification_interval,
  $nrpe_allowed_hosts                        = $::icinga::params::nrpe_allowed_hosts,
  $nrpe_command_timeout                      = $::icinga::params::nrpe_command_timeout,
  $nrpe_connect_timeout                      = $::icinga::params::nrpe_connect_timeout,
  $nrpe_server_address                       = $::icinga::params::nrpe_server_address,
  $nrpe_server_port                          = $::icinga::params::nrpe_server_port,
  $nrpe_allow_arguments                      = $::icinga::params::nrpe_allow_arguments,
  $nrpe_enable_debug                         = $::icinga::params::nrpe_enable_debug,
  $pidfile_client                            = $::icinga::params::pidfile_client,
  $pidfile_server                            = $::icinga::params::pidfile_server,
  $package_client                            = $::icinga::params::package_client,
  $package_client_ensure                     = $::icinga::params::package_client_ensure,
  $package_server                            = $::icinga::params::package_server,
  $package_server_ensure                     = $::icinga::params::package_server_ensure,
  $plugindir                                 = $::icinga::params::plugindir,
  $plugins                                   = $::icinga::params::plugins,
  $use_ido                                   = $::icinga::params::use_ido,
  $use_flapjackfeeder                        = $::icinga::params::use_flapjackfeeder,
  $server                                    = $::icinga::params::server,
  $server_cmd_group                          = $::icinga::params::server_cmd_group,
  $server_group                              = $::icinga::params::server_group,
  $server_user                               = $::icinga::params::server_user,
  $service_client                            = $::icinga::params::service_client,
  $service_client_enable                     = $::icinga::params::service_client_enable,
  $service_client_hasrestart                 = $::icinga::params::service_client_hasrestart,
  $service_client_hasstatus                  = $::icinga::params::service_client_hasstatus,
  $service_client_pattern                    = $::icinga::params::service_client_pattern,
  $service_server                            = $::icinga::params::service_server,
  $service_server_enable                     = $::icinga::params::service_server_enable,
  $service_server_hasrestart                 = $::icinga::params::service_server_hasrestart,
  $service_server_hasstatus                  = $::icinga::params::service_server_hasstatus,
  $service_webserver                         = $::icinga::params::service_webserver,
  $sharedir_server                           = $::icinga::params::sharedir_server,
  $targetdir                                 = $::icinga::params::targetdir,
  $usrlib                                    = $::icinga::params::usrlib,
  $vardir_client                             = $::icinga::params::vardir_client,
  $vardir_server                             = $::icinga::params::vardir_server,
  $webserver_group                           = $::icinga::params::webserver_group,
  $webserver_user                            = $::icinga::params::webserver_user,
  $collect_resources                         = $::icinga::params::collect_resources,
  $collect_hostname                          = $::icinga::params::collect_hostname,
  $collect_ipaddress                         = $::icinga::params::collect_ipaddress,
  $parents                                   = $::icinga::params::parents,
  $hostgroups                                = $::icinga::params::hostgroups,
  $notifications_enabled                     = $::icinga::params::notifications_enabled,
  $export_resources                          = $::icinga::params::export_resources,
  $set_expire_ack_by_default                 = $::icinga::params::set_expire_ack_by_default,
  $service_perfdata_file                     = $::icinga::params::service_perfdata_file,
  $process_service_perfdata_file             = $::icinga::params::process_service_perfdata_file,
  $service_perfdata_file_template            = $::icinga::params::service_perfdata_file_template,
  $service_perfdata_file_processing_interval = $::icinga::params::service_perfdata_file_processing_interval,
) inherits icinga::params {

  # motd::register { 'icinga-refactor': }

  #include icinga::preinstall
  include '::icinga::server::install'
  include '::icinga::server::config'
  include '::icinga::server::collect'
  include '::icinga::server::service'

  #Class['icinga::preinstall'] ->
  Class['icinga::server::install'] ->
  Class['icinga::server::config'] ->
  Class['icinga::server::collect'] ->
  Class['icinga::server::service']

  # Live fast, die young.
  case $::operatingsystem {
    'Debian', 'Ubuntu': {}
    'RedHat', 'CentOS', 'Scientific', 'OEL', 'Amazon': {}
    default: {
      fail "Operatingsystem ${::operatingsystem} is not supported."
    }
  }
}

