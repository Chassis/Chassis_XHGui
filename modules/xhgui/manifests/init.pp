# A Chassis extension that installs XHProf and XHGui
class xhgui (
	$config,
	$path = '/vagrant/extensions/xhgui',
	$php_version = $config[php],
	$host_name =$config['hosts'][0]
) {

	$server_lsbdistcodename = downcase($::lsbdistcodename)

	apt::source { 'mongodb-org-4.0':
	  location    => 'http://repo.mongodb.org/apt/ubuntu',
	  release     => "${server_lsbdistcodename}/mongodb-org/4.0",
	  repos       => 'multiverse',
	  key         => '9DA31620334BD75D9DCB49F368818C72E52529D4',
	  key_server  => 'keyserver.ubuntu.com',
	  include_src => false
	}

	if ( ! empty( $config[disabled_extensions] ) and 'chassis/xhgui' in $config[disabled_extensions] ) {
		$package = absent
		$file = absent
	} else {
		$package = latest
		$file = file
	}

	if ! defined( Package["php${config[php]}-dev"] ) {
		package { "php${config[php]}-dev":
		  ensure  => $package,
		  require => Package["php${config[php]}-fpm"]
		}
	}

	file { [
		"/vagrant/extensions/xhgui/xhgui/config/config.php",
	]:
	  ensure  => $file,
	  content => template('xhgui/config.php.erb'),
	  owner   => 'root',
	  group   => 'root',
	  mode    => '0644',
	  require => [ Package["php${config[php]}-fpm"] ],
	  notify  => Service["php${config[php]}-fpm"]
	}

	exec { 'install xhgui':
		path => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
		cwd => '/vagrant/extensions/xhgui/xhgui/',
		command => 'php install.php',
		require => [
			Package["php$php_version-cli"],
			Package["php$php_version-fpm"],
			Package["php$php_version-mongodb"],
			File["/etc/php/${config[php]}/fpm/conf.d/xhprof.ini"],
			Exec['download xhprof and build it']
		],
		environment => ['HOME=/home/vagrant'],
		logoutput   => true,
		unless      => 'test -d /vagrant/extensions/xhgui/xhgui/vendor'
	}

	package { "php$php_version-mongodb":
	  ensure  => $package,
	  notify  => Service["php$php_version-fpm"]
	}

	package { 'mongodb-org':
	  ensure  => $package,
	  require => Apt::Source['mongodb-org-4.0']
	}

	service { 'mongod':
	  ensure  => running,
	  require => Package['mongodb-org']
	}

	file { '/vagrant/xhgui':
		ensure => $link,
		target => '/vagrant/extensions/xhgui/xhgui/webroot',
		notify => Service['nginx'],
	}
}
