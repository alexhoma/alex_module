
class apachephp
{
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

  ## APACHE
  class { 'apache': }
  apache::vhost { 'myMpwar.prod':
    port => '80',
    docroot => '/var/www/myproject',
  }
  apache::vhost { 'myMpwar.dev':
      port => '80',
      docroot => 'var/www/myproject',
  }

  file {'/var/www/myproject/index.php':
    ensure => 'present',
    mode => '0644',
    content => 'Hello World. Sistema operativo: ${operatingsystem} ${operatingsystemrelease}',
    owner => 'root',
    group => 'root',
  }
  file { '/var/www/myproject/info.php':
    ensure  => 'present',
    source => "puppet:///modules/alex_module/info.php",
    mode    => '0644',
  }
}
