class mysql {
  ## MYSQL
  class { '::mysql::server':
    root_password    => 'vagrantpass',
  }
  mysql::db { 'mympwar': }
  mysql::db { 'mpwar_test': }

  # Ensure Time Zone and Region.
  class { 'timezone':
    timezone => 'Europe/Madrid',
  }
}
