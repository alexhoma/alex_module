# Class alex_module
class alex_module
{

  ## Misc.
  $misc_packages = [
    'sendmail','vim-enhanced','telnet','zip','unzip','screen',
    'libssh2','libssh2-devel','gcc','gcc-c++','autoconf','automake','postgresql-libs'
  ]
  package { $misc_packages: ensure => latest }


  # APACHE+PHP+FILES
  #Apache
  include apachephp
  #mysql
  include mysql
  #mongodb
  include mongodb

  ## NTP
  class { '::ntp':
    server => [ '1.es.pool.ntp.org', '2.europe.pool.ntp.org', '3.europe.pool.ntp.org' ],
  }
}
