class sudo::params (
  $extra_full_sudo_users = [],
  $requiretty = false,
  $extra_path = undef,
  $extra_shells = undef,
  $sudo_fullaccess_group = $::operatingsystem ? { default => 'wheel', Debian => 'adm', Ubuntu => 'admin' },
  $env_reset = true,
  $secure_path = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
)
{
  $rulesfile = '/etc/sudoers'
}
