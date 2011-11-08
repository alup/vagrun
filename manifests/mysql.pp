class mysql {
  package { "mysql-server":
    ensure => installed,
  }
  package { "mysql-client":
    ensure  => installed,
    require => Package["mysql-server"],
  }

  service { "mysql":
    enable     => true,
    ensure     => running,
    hasrestart => true,
    require    => Package["mysql-server"],
  }

  exec { "set-mysql-password":
    unless  => "mysqladmin -uroot -p$mysql_password status",
    path    => ["/bin", "/usr/bin"],
    command => "mysqladmin -uroot password $mysql_password",
    require => Service["mysql"],
  }
}
