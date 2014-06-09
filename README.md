#Vagrant + Puppet - Debian Wheezy with Apache 2.2.x , Php 5.5.x (xdebug, phpunit) , Mysql 5.5 , Sphinx Search 2.1.x , Memcached

## version 0.1.0.

=================================================

##This is a Debian Wheezy Vagrant machine with all above services configured

###General settings
* using Debian Wheezy 7.3 vagrant box with puppet (512M ram VM)
* configured apache vhost under domain 'dev' attached IP 192.168.56.101 (configure your hosts file for this to work)
* mysql has a root user configured with password 'root'
* sphinxsearch is first installed from repositories but later upgraded from *.deb as version 2.1.8 has some major sphinxsql bugs resolved (you can download manually upgrade from http://sphinxsearch.com/downloads/release/ if you wish - just remember to overwrite package included in the repo)
* php has xdebug enabled and phpunit installed

###Each service has it's configuration files in appropriate files directory in puppet/modules/.

#### Apache
There is only one vhost added and attached to domain 'dev' and pointing to /var/www (if you need another directory, like for instance public edit puppet/modules/apache_vhosts/files/dev).

#### Php 5.5 with xdebug and phpunit
Php 5.5 is installed with following modules:
* curl
* dev
* gd
* imagick
* mcrypt
* memcache
* memcached
* mysql
* pspell
* sqlite
* tidy
* xdebug
* xmlrpc
* xsl

Should you require any other ones, simply edit puppet/modules/php/manifests/init.pp file.

#### Mysql 5.5
Mysql is installed and database is added using puppet/modules/mysql/files/dbschema.sql - put your schema to that file and you are clear to go.

#### Memcached
Memcached is setup with defaults. Should you require any changes (like memory limit possibly) - edit puppet/modules/memcached/files/memcached.conf

#### Sphinx search
Sphinx has its indexes configuration in puppet/modules/sphinxsearch/files/project.shpinx.conf . You need at least one properly configured index to make sphinx start properly.
Also a cron job is added which runs re-indexing every minute. Comment it out or adjust schedule in puppet/modules/sphinxsearch/files/cron

### Enjoy and please provide feedback as it is an early deployment
