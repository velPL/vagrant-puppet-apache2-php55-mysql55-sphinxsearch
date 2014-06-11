# == Class: baseconfig
#
# Performs initial configuration tasks for all Vagrant boxes.
#
class baseconfig {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update';
  }

  host { 'hostmachine':
    ip => '192.168.56.101';
  }

  file {
    '/home/vagrant/.bashrc':
      owner => 'vagrant',
      group => 'vagrant',
      mode  => '0644',
      source => 'puppet:///modules/baseconfig/bashrc';
  }
  file { "/etc/apt/sources.list.d/dotdeb.list":
    ensure => file,
    owner => root,
    group => root,
    mode => 0644,
    source => "puppet:///modules/baseconfig/dotdeb.list",
  }
  exec { "import-gpg":
    command => "/usr/bin/wget -q http://www.dotdeb.org/dotdeb.gpg -O -| /usr/bin/apt-key add -"
  }  
  
  exec { 'apt-update':
    command => '/usr/bin/apt-get update',
    require => [File["/etc/apt/sources.list.d/dotdeb.list"], Exec["import-gpg"]]
  }

  package { ['mc',
             'phpunit',
			 'ntp',
			 'imagemagick']:
    ensure => present,
	require => Exec['apt-update'];
  }  
}
