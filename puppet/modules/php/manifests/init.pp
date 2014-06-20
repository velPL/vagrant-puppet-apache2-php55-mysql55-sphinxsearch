# == Class: php
#
# Installs PHP5 and necessary modules. Sets config files.
#

class php {
  
  package { ['php5',
             'php5-cli',
             'libapache2-mod-php5',
             'php5-curl',
             'php5-dev',
             'php5-gd',
             'php5-imagick',
             'php5-mcrypt',
             'php5-memcache',
             'php5-memcached',
             'php5-mysql',
             'php5-pspell',
             'php5-sqlite',
             'php5-tidy',
             'php5-xdebug',
             'php5-xmlrpc',
             'php5-xsl']:
    ensure => present;
  }

  file {
    '/etc/php5/apache2':
      ensure => directory,
      before => File ['/etc/php5/apache2/php.ini'];

    '/etc/php5/apache2/php.ini':
      source  => 'puppet:///modules/php/apache2-php.ini',
      require => Package['php5'];

    '/etc/php5/cli':
      ensure => directory,
      before => File ['/etc/php5/cli/php.ini'];

    '/etc/php5/cli/php.ini':
      source  => 'puppet:///modules/php/cli-php.ini',
      require => Package['php5-cli'];
	  
    '/etc/php5/mods-available/xdebug.ini':
      source  => 'puppet:///modules/php/mods/xdebug.ini',
      require => Package['php5-xdebug'];
	  
  }
  exec { 'apache install php module':
	command		=> 'a2enmod php5 && /etc/init.d/apache2 restart',
	path		=> '/usr/local/bin::/usr/bin:/bin:/usr/sbin/',
	user		=> 'root';
  }
  
}
