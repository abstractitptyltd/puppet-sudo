define sudo::register( $ensure = present, $content = "", $order = 20 ) {

  include sudo
  include sudo::params
#  include concat::setup

  concat::fragment{"sudo_fragment_${name}":
    ensure  => $ensure,
    target  => $sudo::params::rulesfile,
    content => $content,
    order   => $order,
  }
}
