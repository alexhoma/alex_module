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
  $php_version = '56';

  include ::yum::repo::remi

  if $php_version == '55' {
      include ::yum::repo::remi_php55
  }
  elsif $php_version == '56'{
      ::yum::managed_yumrepo { 'remi-php56':
        descr          => 'Les RPM de remi pour Enterpise Linux $releasever - $basearch - PHP 5.6',
        mirrorlist     => 'http://rpms.famillecollet.com/enterprise/$releasever/php56/mirror',
        enabled        => 1,
        gpgcheck       => 1,
        gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi',
        gpgkey_source  => 'puppet:///modules/yum/rpm-gpg/RPM-GPG-KEY-remi',
        priority       => 1,
      }
  }
  class { 'php':
      version => 'latest',
      require => Yumrepo['remi-php56']
  }

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
