define sudo::runas (
  $ensure = present,
  $who,
  $comment = undef,
) {

  sudo::register{"runas_${name}":
    ensure => $ensure,
    content => template('sudo/runas.erb'),
    order => 30,
  }
}
