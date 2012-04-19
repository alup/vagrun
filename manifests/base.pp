group { "puppet":
  ensure => "present",
}

# Message Of The Day
file { '/etc/motd':
  content => "Welcome to your Vagrant-built virtual machine! Managed by Puppet.\n",
  group => 0,
  owner   => 0,
  mode => 644,
}

# Issue an apt-get udpate
Package {
  require => Exec["apt-get update"]
}
if ! defined(Exec["apt-get update"]) {
  exec { "apt-get update":
    path => "/usr/bin:/bin/:/sbin/:/usr/sbin"
  }
}

# Use rbenv for user vagrant
class { "rbenv":
  user    => "vagrant",
  compile => true,
  version => "1.9.3-p125",
}

$mysql_password = 'fatality'
$user = 'vagrant'

# Include all the necessary modules here
include nginx, mysql, htop
