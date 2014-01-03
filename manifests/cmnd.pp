define sudo::cmnd (
  $what,
  $cmnd,
  $ensure = present,
  $comment = undef,
) {

  sudo::register{"cmnd_${name}":
    ensure  => $ensure,
    content => template('sudo/cmnd.erb'),
    order   => '30',
  }
}
