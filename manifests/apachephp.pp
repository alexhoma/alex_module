
class apachephp {
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

  # Create files
  include alex_module::createfiles
}
