class unicorn::install {
  package { "unicorn":
      ensure   => 'present',
      provider => 'gem',
  }
}

class unicorn {
  include unicorn::install
}
