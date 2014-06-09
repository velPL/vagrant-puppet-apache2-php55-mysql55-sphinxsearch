class memcached {
  package { ['memcached']:
    ensure => present;
  }

  file { '/etc/memcached.conf':
    source  => 'puppet:///modules/memcached/memcached.conf',
    require => Package['memcached'],
    notify  => Service['memcached'];
  }  

  service { 'memcached':
    ensure     => running,
    require => Package['memcached'],
    enable     => true,
    hasrestart => true,
    hasstatus  => false,
    subscribe  => File['/etc/memcached.conf'];
  }
}
