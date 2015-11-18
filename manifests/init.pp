# Class: alex_module
# ===========================

class alex_module
{
  ## Misc.
  $misc_packages = [
    'sendmail','vim-enhanced','telnet','zip','unzip','screen',
    'libssh2','libssh2-devel','gcc','gcc-c++','autoconf','automake','postgresql-libs'
  ]
  package { $misc_packages: ensure => latest }

  #SEPARACION DE CLASES POR NODOS
  #apache+php+files
  include alex_module::apachephp
  #mysql
  include alex_module::mysql
  #mongodb
  include alex_module::mongodb

  ## NTP
  class { '::ntp':
    server => [ '1.es.pool.ntp.org', '2.europe.pool.ntp.org', '3.europe.pool.ntp.org' ],
  }
}
