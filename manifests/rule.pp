define sudo::rule (
  $who,
  $ensure = present,
  $commands = 'ALL',
  $servers = 'ALL',
  $comment = '',
  $requiretty = true,
  $runas = 'root',
  $nopass = false,
  $setenv = false,
) {

  sudo::register{"rule_${name}":
    ensure  => $ensure,
    content => template('sudo/rule.erb'),
    order   => 30,
  }
}
