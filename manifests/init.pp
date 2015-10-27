

class sudo (
  $sudoers_dot_d = $sudo::params::sudoers_dot_d,
  $extra_full_sudo_users = $sudo::params::extra_full_sudo_users,
  $requiretty = $sudo::params::requiretty,
  $extra_path = $sudo::params::extra_path,
  $extra_shells = $sudo::params::extra_shells,
  $sudo_fullaccess_group = $sudo::params::sudo_fullaccess_group,
  $env_reset = $sudo::params::env_reset,
  $secure_path = $sudo::params::secure_path,
  $rulesfile = $sudo::params::rulesfile
) inherits ::sudo::params {
  include ::sudo::install
  include ::sudo::config
  Class[sudo::install] -> Class[sudo::config]
}

