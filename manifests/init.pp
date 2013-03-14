
class sudo {
  include sudo::params
  include sudo::install
  include sudo::config
  Class[sudo::params] -> Class[sudo::install] -> Class[sudo::config]
}

