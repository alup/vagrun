class unicorn::install {
  rbenv::gem {"rbenv::unicorn vagrant 1.9.3-p194":
    user   => 'vagrant',
    ruby   => '1.9.3-p194',
    gem    => 'unicorn',
  }
}

class unicorn {
  include unicorn::install
}
