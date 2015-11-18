class alex_module::mysql
{
  ## MYSQL
  class { '::mysql::server':
    root_password    => 'vagrantpass',
  }
  mysql::db { 'mympwar':
    user     => 'myuser',
    password => 'mypass',
    host     => 'localhost',
    grant    => ['SELECT', 'UPDATE'],
  }
  mysql::db { 'mpwar_test':
    user     => 'myuser',
    password => 'mypass',
    host     => 'localhost',
    grant    => ['SELECT', 'UPDATE'],
  }

  # Ensure Time Zone and Region.
  class { 'timezone':
    timezone => 'Europe/Madrid',
  }
}
