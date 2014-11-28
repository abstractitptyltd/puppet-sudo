
class sudo::config {

  include ::sudo

  $sudoers_dot_d = $sudo::sudoers_dot_d
  $extra_path = $sudo::extra_path
  $extra_shells = $sudo::extra_shells
  $sudo_fullaccess_group = $sudo::sudo_fullaccess_group
  $extra_full_sudo_users = $sudo::extra_full_sudo_users
  $requiretty = $sudo::requiretty
  $rulesfile = $sudo::rulesfile

  concat{$rulesfile:
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
