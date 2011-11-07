class rbenv::install {
  # STEP 1
  exec { "checkout rbenv":
    command => "git clone git://github.com/sstephenson/rbenv.git .rbenv",
    user    => "vagrant",
    group   => "vagrant",
    cwd     => "/home/vagrant",
    creates => "/home/vagrant/.rbenv",
    path    => ["/usr/bin", "/usr/sbin"],
    timeout => 100,
    require => Class['git'],
  }

  # STEP 2
  exec { "configure rbenv path":
    command => 'echo "export PATH=/home/vagrant/.rbenv/bin:\$PATH" >> .bashrc',
    user    => "vagrant",
    group   => "vagrant",
    cwd     => "/home/vagrant",
    onlyif  => "[ -f /home/vagrant/.bashrc ]", 
    unless  => "grep .rbenv /home/vagrant/.bashrc 2>/dev/null",
    path    => ["/bin", "/usr/bin", "/usr/sbin"],
  }

  # STEP 3
  exec { "configure rbenv init":
    command => 'echo "eval \"\$(rbenv init -)\"" >> .bashrc',
    user    => "vagrant",
    group   => "vagrant",
    cwd     => "/home/vagrant",
    onlyif  => "[ -f /home/vagrant/.bashrc ]", 
    unless  => 'grep ".rbenv init -" /home/vagrant/.bashrc 2>/dev/null',
    path    => ["/bin", "/usr/bin", "/usr/sbin"],
  }

  # STEP 4
  exec { "checkout ruby-build":
    command => "git clone git://github.com/sstephenson/ruby-build.git",
    user    => "vagrant",
    group   => "vagrant",
    cwd     => "/home/vagrant",
    creates => "/home/vagrant/ruby-build",
    path    => ["/usr/bin", "/usr/sbin"],
    timeout => 100,
    require => Class['git'],
  }

  # STEP 5
  exec { "install ruby-build":
    command => "sh install.sh",
    user    => "root",
    group   => "root",
    cwd     => "/home/vagrant/ruby-build",
    onlyif  => '[ -z "$(which ruby-build)" ]', 
    path    => ["/bin", "/usr/local/bin", "/usr/bin", "/usr/sbin"],
    require => Exec['checkout ruby-build'],
  }

  # STEP 6
  #
  # Set Timeout to disabled cause we need a lot of time to compile.
  # Use HOME variable and define PATH correctly.
  exec { "install ruby 1.9.2-p290":
    command     => "rbenv-install 1.9.2-p290",
    timeout     => 0,
    user        => "vagrant",
    group       => "vagrant",
    cwd         => "/home/vagrant",
    environment => [ "HOME=/home/vagrant" ],
    onlyif      => '[ -n "$(which rbenv-install)" ] && ! [ -e /home/vagrant/.rbenv/versions/1.9.2-p290 ]', 
    path        => ["home/vagrant/.rbenv/shims", "/home/vagrant/.rbenv/bin", "/bin", "/usr/local/bin", "/usr/bin", "/usr/sbin"],
    require     => [Class['curl'], Exec['install ruby-build']],
  }

  # STEP 7
  exec { "rehash rbenv":
    command     => "rbenv rehash",
    user        => "vagrant",
    group       => "vagrant",
    cwd         => "/home/vagrant",
    environment => [ "HOME=/home/vagrant" ],
    onlyif      => '[ -n "$(which rbenv)" ]', 
    path        => ["home/vagrant/.rbenv/shims", "/home/vagrant/.rbenv/bin", "/bin", "/usr/local/bin", "/usr/bin", "/usr/sbin"],
    require     => Exec['install ruby 1.9.2-p290'],
  }
}

class rbenv {
  include rbenv::install
}
