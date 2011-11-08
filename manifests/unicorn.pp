class unicorn::install {
  package { "unicorn":
      ensure   => 'present',
      provider => 'gem',
      require  => Class['rbenv'],
  }
}

class unicorn {
  include unicorn::install
}
