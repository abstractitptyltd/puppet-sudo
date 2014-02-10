
class sudo::config {

  include sudo::params
  $extra_path = $sudo::params::extra_path
  $extra_shells = $sudo::params::extra_shells
  $sudo_fullaccess_group = $sudo::params::sudo_fullaccess_group
  $extra_full_sudo_users = $sudo::params::extra_full_sudo_users
  $requiretty = $sudo::params::requiretty

  concat{$sudo::params::rulesfile:
    owner => root,
    group => root,
    mode  => '0440',
  }
  sudo::register{ 'sudo_header':
    ensure  => present,
    content => template('sudo/sudoers.erb'),
    order   => 10,
  }

}

