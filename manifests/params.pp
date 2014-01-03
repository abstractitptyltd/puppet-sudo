class sudo::params (
  $extra_full_sudo_users = [],
  $requiretty = false,
  $extra_path = undef,
  $extra_shells = undef,
)
{
  $rulesfile = '/etc/sudoers'
  $sudo_fullaccess_group = $::operatingsystem ? { default => 'wheel', Debian => 'adm', Ubuntu => 'admin' }
}
