# XHGui
A Chassis extension to install and configure [XHGui](https://github.com/perftools/xhgui) on your Chassis server. This extension also has [XHProf](https://github.com/Chassis/XHProf) as a dependency so it will be installed and configured automatically as well.

## Installation
1. Add this extension to your extensions directory `git clone --recursive git@github.com:Chassis/Chassis-XHGui.git extensions/chassis-xhgui`
2. Note: **The folder that you clone into must be called** `chassis-xhgui`.
3. Run `vagrant provision`.

## Alternative Installation
1. Add `- chassis/chassis-xhgui` to your `extensions` in [yaml](http://docs.chassis.io/en/latest/config/) files. e.g.
	```
	extensions:
	- chassis/chassis-xhgui
	```
2. Run `vagrant provision`.

> **Please note:** `vagrant provision` can take quite a few minutes due to the amount of [Composer](https://getcomposer.org/) dependencies in XHGui.  So when you see the provisioning process taking a long time on `Service[php7.0-fpm]` please be patient as this is the stage where Composer dependencies are being installed. 

## Usage

Browse to [http://vagrant.local/xhgui](http://vagrant.local/xhgui) in a browser. If you have a custom host hame it will be `http://<yourhostname>.local/xghui`.

If you're using [custom paths](http://docs.chassis.io/en/latest/config/#paths) you'll need to change the URL to add your custom base. For example: If you've Chassis located in a `chassis` folder then the URL will be [http://vagrant.local/chassis/xhgui](http://vagrant.local/chassis/xhgui) or `http://<yourhostname>.local/chassis/xghui`.

## Controlling When the Profiler Runs

This extension enables the XHProf profiler for every request. You can control whether or not the profiler runs from the `profiler.enable` callback function that is contained within the `extensions/chassis-xhgui/xhgui/config/config.php` file.

From this callback function you can perform logic based on `$_SERVER` values, `php_sapi_name()`, etc, but remember that WordPress has not loaded at this point so you can't use any function that WordPress provides.

```php
'profiler.enable' => function() {
	if ( false !== strpos( $_SERVER['REQUEST_URI'], 'wp-admin/' ) ) {
		// Disable the profiler for requests to wp-admin:
		return false;
	}

	// Enable the profiler for all other requests:
	return true;
},

```

Further information about configuring the profiler and other XHGUI options can be found [in the XHGUI repo documentation](https://github.com/Chassis/xhgui).

## Uninstallation
1. Add `- chassis/chassis-xhgui` to your `disabled_extensions` in [yaml](http://docs.chassis.io/en/latest/config/) files. e.g.
	```
	disabled_extensions:
	- chassis/chassis-xhgui
	```
2. Run `vagrant provision`.

## Screenshots

![Recent Runs](https://bronsons-captured.s3.amazonaws.com/Xhgui_-_Run_list_2018-08-03_16-04-54.png "Recent Runs")

![Profile Data](https://bronsons-captured.s3.amazonaws.com/Xhgui_-_Profile_-_cat1_2018-08-03_16-05-32.png "Profile Data")

![Call Graph](https://bronsons-captured.s3.amazonaws.com/Xhgui_-_Callgraph_-_cat1_-_Aug_3rd_060412_2018-08-03_16-06-06.png "Call Graph")

![Flame Graph](https://bronsons-captured.s3.amazonaws.com/Xhgui_-_Flamegraph_-_cat1_-_Aug_3rd_060412_2018-08-03_16-06-42.png "Flame Graph")

![Function Calls](https://bronsons-captured.s3.amazonaws.com/Xhgui_-_Profile_-_cat1_2018-08-03_16-08-27.png "Function Calls")
