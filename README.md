# XHGui
A Chassis extension to install and configure [XHGui](https://github.com/perftools/xhgui) on your Chassis server. This extension also has [XHProf](https://github.com/Chassis/XHProf) as a dependency so it will be installed and configured automatically as well.

## Installation
1. Add this extension to your extensions directory `git clone git@github.com:Chassis/Chassis-XHGui.git extensions/chassis-xhgui`
2. Run `vagrant provision`.
3. Browse to [http://vagrant.local/xhgui](http://vagrant.local/xhgui) in a browser or if you have a custom host hame it will be [http://<yourhost>.local/xghui](http://<yourhost>.local/xghui)


## Alternative Installation
1. Add `- chassis/chassis-xhgui` to your `extensions` in [yaml](http://docs.chassis.io/en/latest/config/) files. e.g.
	```
	extensions:
	- chassis/chassis-xhgui
	```
2. Run `vagrant provision`.
3. Browse to [http://vagrant.local/xhgui](http://vagrant.local/xhgui) in a browser or if you have a custom host hame it will be [http://<yourhost>.local/xghui](http://<yourhost>.local/xghui)

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
