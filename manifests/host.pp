define sudo::host (
  $ensure = present,
  $where,
  $comment = undef,
) {

  sudo::register{"host_${name}":
    ensure => $ensure,
    content => template('sudo/host.erb'),
    order => 30,
  }
}
