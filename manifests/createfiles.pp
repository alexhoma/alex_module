class alex_module::createfiles
{
  file { '/var/www/myproject/index.php':
    ensure  => 'present',
    source  => "puppet:///modules/alex_module/index.php",
    mode    => '0644',
  }

  file { '/var/www/myproject/info.php':
    ensure  => 'present',
    source => "puppet:///modules/alex_module/info.php",
    mode    => '0644',
  }
}
