define sudo::register(
  $ensure = present,
  $content = '',
  $order = 20
) {

  include ::sudo

  concat::fragment{"sudo_fragment_${name}":
    ensure  => $ensure,
    target  => $sudo::rulesfile,
    content => $content,
    order   => $order,
  }
}
