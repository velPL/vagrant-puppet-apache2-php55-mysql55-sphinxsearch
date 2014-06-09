# == Class: sphinxsearch
#
# Installs Sphinx Search, sets config file
#
class sphinxsearch {
  package { ['sphinxsearch']:
    ensure => present;
  }
  
  Package['sphinxsearch'] -> Exec['indexer'] -> Service['sphinxsearch'] -> File[tmp-passenger] -> Package['sphinxsearch-update']
  
  exec { 'indexer':
	command		=> '/usr/bin/indexer --all --rotate --quiet',
	path		=> '/usr/local/bin::/usr/bin:/bin',
	user		=> 'root';
  }
  file { '/etc/cron.d/sphinxsearch':
    source  => 'puppet:///modules/sphinxsearch/cron',
    require => Package['sphinxsearch'],
    notify  => Service['sphinxsearch'];
  }
  file { '/etc/default/sphinxsearch':
    source  => 'puppet:///modules/sphinxsearch/sphinxsearch',
    require => Package['sphinxsearch'],
    notify  => Service['sphinxsearch'];
  }
  file { '/etc/sphinxsearch/sphinx.conf':
    source  => 'puppet:///modules/sphinxsearch/project.sphinx.conf',
    require => Package['sphinxsearch'],
    notify  => Service['sphinxsearch'];
  }
  service { 'sphinxsearch':
    ensure  => running,
    require => Package['sphinxsearch'],
    enable     => true,
    hasrestart => true,
    hasstatus  => true;
  }
  file {'tmp-passenger':
	name => "/tmp/mod-passenger.deb",
	owner => root,
	group => root,
	source => "puppet:///modules/sphinxsearch/sphinxsearch_2.1.8.deb"
  }  

  package { ['sphinxsearch-update']:
    provider => dpkg,
    ensure => installed,
	require => [File[tmp-passenger], Package[sphinxsearch]],
    source => "/tmp/mod-passenger.deb";
  }  
}
