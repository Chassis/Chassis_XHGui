# XHGui
A Chassis extension to install and configure [XHGui](https://github.com/perftools/xhgui) on your Chassis server. This extension also has [XHProf](https://github.com/Chassis/XHProf) as a dependency so it will be installed and configured automatically as well.

## Installation
1. Add this extension to your extensions directory `git clone --recursive git@github.com:Chassis/Chassis-XHGui.git extensions/chassis-xhgui`
2. Note: **The folder that you clone into must be called** `chassis-xhgui`.
3. Run `vagrant provision`.
4. Browse to [http://vagrant.local/xhgui](http://vagrant.local/xhgui) in a browser or if you have a custom host hame it will be [http://<yourhost>.local/xghui](http://<yourhost>.local/xghui)


## Alternative Installation
1. Add `- chassis/chassis-xhgui` to your `extensions` in [yaml](http://docs.chassis.io/en/latest/config/) files. e.g.
	```
	extensions:
	- chassis/chassis-xhgui
	```
2. Run `vagrant provision`.
3. Browse to [http://vagrant.local/xhgui](http://vagrant.local/xhgui) in a browser or if you have a custom host hame it will be [http://yourhostname.local/xghui](http://yourhostname.local/xghui). If you're using [custom paths](http://docs.chassis.io/en/latest/config/#paths) you'll need to change the URL to add your custom base. For example: If you've Chassis located in a `chassis` folder then the URL will be [http://vagrant.local/chassis/xhgui](http://vagrant.local/chassis/xhgui) or [http://yourhostname.local/chassis/xghui](http://yourhostname.local/chassis/xghui).
4. **Please note:** `vagrant provision` can take quite a few minutes due to the amount of [Composer](https://getcomposer.org/) dependencies in Xhgui.  So when you see the provisioning process taking a long time on `Service[php7.0-fpm]` please be patient as this is the stage where Composer dependencies are being installed. 
5. Browse to [http://vagrant.local/xhgui](http://vagrant.local/xhgui) in a browser or if you have a custom host hame it will be [http://<yourhost>.local/xghui](http://<yourhost>.local/xghui)

## Uninstallation
1. Add `- chassis/chassis-xhgui` to your `disabled_extensions` in [yaml](http://docs.chassis.io/en/latest/config/) files. e.g.
	```
	disabled_extensions:
	- chassis/chassis-xhgui
	```
2. Run `vagrant provision`.
3. Browse to [http://vagrant.local/xhgui](http://vagrant.local/xhgui) in a browser or if you have a custom host hame it will be [http://yourhost.local/xghui](http://yourhost.local/xghui)

## Screenshots

![Recent Runs](https://bronsons-captured.s3.amazonaws.com/Xhgui_-_Run_list_2018-08-03_16-04-54.png "Recent Runs")

![Profile Data](https://bronsons-captured.s3.amazonaws.com/Xhgui_-_Profile_-_cat1_2018-08-03_16-05-32.png "Profile Data")

![Call Graph](https://bronsons-captured.s3.amazonaws.com/Xhgui_-_Callgraph_-_cat1_-_Aug_3rd_060412_2018-08-03_16-06-06.png "Call Graph")

![Flame Graph](https://bronsons-captured.s3.amazonaws.com/Xhgui_-_Flamegraph_-_cat1_-_Aug_3rd_060412_2018-08-03_16-06-42.png "Flame Graph")

![Function Calls](https://bronsons-captured.s3.amazonaws.com/Xhgui_-_Profile_-_cat1_2018-08-03_16-08-27.png "Function Calls")
