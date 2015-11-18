# Class: alex_module
# ===========================

class alex_module {

  ## Misc.
  $misc_packages = [
    'sendmail','vim-enhanced','telnet','zip','unzip','screen',
    'libssh2','libssh2-devel','gcc','gcc-c++','autoconf','automake','postgresql-libs'
  ]

  package { $misc_packages: ensure => latest }

  ## APACHE
  class { 'apache': }
  apache::vhost { 'myMpwar.prod':
    port => '80',
    docroot => '/var/www/myproject',
  }
  apache::vhost { 'myMpwar.dev':
      port => '80',
      docroot => 'var/www/myproject,
  }

  ## PHP
  include ::yum::repo::remi
  package { 'libzip-last':
    require => Yumrepo['remi']
  }

  class{ '::yum::repo::remi_php56':
    require => Package['libzip-last']
  }

  class { 'php':
    version => 'latest',
    require => Yumrepo['remi-php56'],
  }

  php::module { [ 'devel', 'pear', 'xml', 'mbstring', 'pecl-memcache', 'soap' ]: }

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

  ## NTP
  class { '::ntp':
    server => [ '1.es.pool.ntp.org', '2.europe.pool.ntp.org', '3.europe.pool.ntp.org' ],
  }

  ## MongoDB Server
  include '::mongodb::server'

  # Create files
  include alex_module::createfiles
}
