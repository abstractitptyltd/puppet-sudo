define sudo::runas (
  $who,
  $ensure = present,
  $comment = undef,
) {

  sudo::register{"runas_${name}":
    ensure  => $ensure,
    content => template('sudo/runas.erb'),
    order   => 30,
  }
}
