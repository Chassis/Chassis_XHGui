# A Chassis extension that installs XHProf and XHGui
class chassis_xhgui (
	$config,
	$path = '/vagrant/extensions/chassis_xhgui',
	$php_version = $config[php],
	$host_name = $config['hosts'][0],
	$location  = $config[mapped_paths][base]
) {

	$server_lsbdistcodename = downcase($::lsbdistcodename)

	apt::source { 'mongodb-org-4.0':
		location => 'http://repo.mongodb.org/apt/ubuntu',
		release  => "${server_lsbdistcodename}/mongodb-org/4.0",
		repos    => 'multiverse',
		key      => {
			'id'     => '9DA31620334BD75D9DCB49F368818C72E52529D4',
			'server' => 'keyserver.ubuntu.com',
		}
	}

	# Setup the base paths for custom Chassis paths.
	if ( $location != '/vagrant' ) {
		$base_location = "${location}/chassis"
	} else {
		$base_location = $location
	}

	if ( ! empty( $config[disabled_extensions] ) and 'chassis/chassis_xhgui' in $config[disabled_extensions] ) {
		$package = absent
		$file = absent
		$link = absent
	} else {
		$package = latest
		$file = file
		$link = link
	}

	if ! defined( Package["php${config[php]}-dev"] ) {
		package { "php${config[php]}-dev":
		  ensure  => $package,
		  require => Package["php${config[php]}-fpm"]
		}
	}

	file { [
		"${base_location}/extensions/chassis_xhgui/xhgui/config/config.php",
	]:
	  ensure  => $file,
	  content => template('chassis_xhgui/config.php.erb'),
	  owner   => 'root',
	  group   => 'root',
	  mode    => '0644',
	  require => [ Package["php${config[php]}-fpm"] ],
	  notify  => Service["php${config[php]}-fpm"]
	}

	exec { 'enable mongod on boot':
		path    => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
		command => 'systemctl enable mongod.service',
		unless  => 'systemctl is-enabled mongod',
		require => Package['mongodb-org']
	}

	package { "php${php_version}-mongodb":
		ensure  => $package,
		notify  => Service["php${php_version}-fpm"],
		require => Package["php${php_version}-fpm"],
	}

	package { 'mongodb-org':
		ensure  => $package,
		require => [ Apt::Source['mongodb-org-4.0'], Class['apt::update'] ]
	}

	service { 'mongod':
		ensure  => running,
		require => Package['mongodb-org']
	}

	if ( ! defined( File["/etc/nginx/sites-available/${host_name}.d"] ) ) {
		file { "/etc/nginx/sites-available/${host_name}.d":
		  ensure  => directory,
		  require => File[ "/etc/nginx/sites-available/${host_name}" ],
		}
	}

	file { "/etc/nginx/sites-available/${host_name}.d/${host_name}":
		content => template('chassis_xhgui/xhgui.nginx.conf.erb'),
		notify  => Service['nginx'],
	}

	file { "${base_location}/xhgui":
		ensure => $link,
		target => "${base_location}/extensions/chassis_xhgui/xhgui/webroot",
		notify => Service['nginx'],
	}

}
