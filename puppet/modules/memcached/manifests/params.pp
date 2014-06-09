class memcached::params {
  package { ['memcached']:
    ensure => present;
  }
  $package_name     = 'memcached'
  $service_name     = 'memcached'
  $dev_package_name = 'libmemcached-dev'
  $config_file      = '/etc/memcached.conf'
  $config_tmpl      = "$module_name/memcached.conf.erb"
  $user             = 'nobody
  
  service { 'memcached':
    ensure  => running,
    require => Package['memcached'];
  }

  file { '/etc/memcached.conf':
    source  => 'puppet:///modules/memcached/memcached.conf',
    require => Package['memcached'],
    notify  => Service['memcached'];
  }
}
