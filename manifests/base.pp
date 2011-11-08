group { "puppet":
  ensure => "present",
}

# Message Of The Day
file { '/etc/motd':
  content => "Welcome to your Vagrant-built virtual machine! Managed by Puppet.\n",
  owner   => 0644,
  mode => 0,
  group => 0,
}

$mysql_password = 'fatality'
$user = 'vagrant'
$global_ruby = '1.9.2-p290'

# Include all the module here
include curl, nginx, git, rbenv, unicorn, mysql, htop
