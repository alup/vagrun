class nginx::install {
  package { "nginx":
      ensure => 'present',
  }
}

# TODO: add configuration files
class nginx::service {
  service { "nginx":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    require    => Package["nginx"],
  }
}

class nginx {
  include nginx::install, nginx::service
}
