define sudo::cmnd (
  $ensure = present,
  $what,
  $cmnd,
  $comment = undef,
) {

  sudo::register{"cmnd_${name}":
    ensure => $ensure,
    content => template('sudo/cmnd.erb'),
    order => 30,
  }
}
