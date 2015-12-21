define sudo::line (
  $line,
  $ensure = present,
  $comment = undef,
) {

  sudo::register{"line_${name}":
    ensure  => $ensure,
    content => template('sudo/line.erb'),
  }
}
