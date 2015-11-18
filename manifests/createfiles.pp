class alex_module::createfiles
{
  file {'/var/www/myproject/index.php':
    ensure => 'present',
    mode => '0644',
    content => 'Hello World. Sistema operativo: ${operatingsystem} ${operatingsystemrelease}'
    owner => 'root',
    group => 'root',
  }
  file { '/var/www/myproject/info.php':
    ensure  => 'present',
    source => "puppet:///modules/alex_module/info.php",
    mode    => '0644',
  }

}
