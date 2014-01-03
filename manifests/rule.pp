define sudo::rule (
  $who,
  $ensure = present,
  $commands = 'ALL',
  $servers = 'ALL',
  $comment = undef,
  $runas = 'root',
  $nopass = false,
) {

  sudo::register{"rule_${name}":
    ensure  => $ensure,
    content => template('sudo/rule.erb'),
    order   => 30,
  }
}
