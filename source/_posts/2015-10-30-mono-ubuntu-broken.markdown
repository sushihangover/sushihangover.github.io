---
layout: post
title: "Mono | Ubuntu Broken Packages"
date: 2015-10-30 21:55:07 -0700
comments: true
categories: 
- mono
- ubunutu
- monodevelop
---
[{% img left http://sushihangover.github.io/images/mono-logo.png %}](http://www.mono-project.com)

I do not normally use a Linux Desktop, more of a CLI kind-of guy, but in trying to support some C# projects that are using MonoDevelop, I needed to get the beta/alpha Mono builds installed... It turns out to be a [P.I.T.A.](http://www.urbandictionary.com/define.php?term=pita&page=1) to do it from packages and not source.

Broken packages always seem to be a problem when dealing with pre-built Linux software and I usually build from source so I do not see them, but installing the `mono-devel` package fails due to `libjpeg62-turbo` and `libjpeg62` not being avialable in the normal Ubuntu repos. They have been replaced by bundle `8` of libraries but `libgdiplus` that Mono references is pinned to `libjpeg6*` packages...

###So the errors:

	sudo apt-get install momo-devel

```
Reading package lists... Done
Building dependency tree       
Reading state information... Done
E: Unable to locate package momo-devel
parallels@ubuntu:~$ sudo apt-get install mono-devel
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Some packages could not be installed. This may mean that you have
requested an impossible situation or if you are using the unstable
distribution that some required packages have not yet been created
or been moved out of Incoming.
The following information may help to resolve the situation:

The following packages have unmet dependencies:
 mono-devel : Depends: libgdiplus (>= 2.6.7) but it is not going to be installed
              Depends: libmono-system-design4.0-cil (>= 1.0) but it is not going to be installed
              Depends: libmono-system-drawing4.0-cil (>= 3.0.6) but it is not going to be installed
              Depends: libmono-system-messaging4.0-cil (>= 2.10.1) but it is not going to be installed
              Depends: libmono-system-runtime4.0-cil (>= 2.10.1) but it is not going to be installed
              Depends: libmono-system-servicemodel-activation4.0-cil (>= 1.0) but it is not going to be installed
              Depends: libmono-system-servicemodel-web4.0-cil (>= 3.2.1) but it is not going to be installed
              Depends: libmono-system-servicemodel4.0a-cil (>= 3.2.3) but it is not going to be installed
              Depends: libmono-system-web-extensions4.0-cil (>= 2.10.3) but it is not going to be installed
              Depends: libmono-system-web-services4.0-cil (>= 1.0) but it is not going to be installed
              Depends: libmono-system-web4.0-cil (>= 2.10.3) but it is not going to be installed
              Depends: libmono-system-windows-forms4.0-cil (>= 1.0) but it is not going to be installed
              Depends: libmono-cil-dev (= 4.2.1.91-0xamarin1) but it is not going to be installed
E: Unable to correct problems, you have held broken packages.
```

	sudo apt-get install libgdiplus

```
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Some packages could not be installed. This may mean that you have requested an impossible situation or if you are using the unstable
distribution that some required packages have not yet been created
or been moved out of Incoming.
The following information may help to resolve the situation:
The following packages have unmet dependencies:
libgdiplus : Depends: libjpeg62-turbo (>= 1.3.1) but it is not installable
E: Unable to correct problems, you have held broken packages.
```

	sudo apt-get install libjpeg62-turbo

```
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Package libjpeg62-turbo is not available, but is referred to by another package.
This may mean that the package is missing, has been obsoleted, or is only available from another source E: 
Package 'libjpeg62-turbo' has no installation candidate
```

###The Fix:

####Get the older `libjpeg62-turbo` package:

[libjpeg62-turbo - libjpeg-turbo JPEG runtime library](http://pkgs.org/debian-sid/debian-main-amd64/libjpeg62-turbo_1.4.1-2_amd64.deb.html
)

	 wget http://ftp.br.debian.org/debian/pool/main/libj/libjpeg-turbo/libjpeg62-turbo_1.4.1-2_amd64.deb


#### Get the older `libjpeg62` package:


[libjpeg62 - Independent JPEG Group's JPEG runtime library (version 6.2)](http://pkgs.org/debian-sid/debian-main-amd64/libjpeg62_6b2-2_amd64.deb.html
)

	 wget http://ftp.br.debian.org/debian/pool/main/libj/libjpeg6b/libjpeg62_6b2-2_amd64.deb

#### [Install](http://www.cyberciti.biz/faq/ubuntu-linux-how-do-i-install-deb-packages/) the deb packages: 

	sudo dpkg --install --recursive --auto-deconfigure libjpeg62-turbo_1.4.1-2_amd64.deb 

#### Update and fix the 'now broken' dependencies:

	apt-get update
	sudo apt-get -f install

#### Finally, install `mono` from package:

	sudo apt-get install mono-devel
	sudo apt-get isntall monodevelop

#### Ahhh, `mono 4.2.1` is now installed:

```
mono --version
Mono JIT compiler version 4.2.1 (Stable 4.2.1.91/8862921 Fri Oct 30 17:04:13 UTC 2015)
Copyright (C) 2002-2014 Novell, Inc, Xamarin Inc and Contributors. www.mono-project.com
	TLS:           __thread
	SIGSEGV:       altstack
	Notifications: epoll
	Architecture:  amd64
	Disabled:      none
	Misc:          softdebug 
	LLVM:          supported, not enabled.
	GC:            sgen
```

Almost would be easier to install from source ;-)

Have fun.

[{% img http://sushihangover.github.io/images/monodevelop.png %}](http://www.monodevelop.com)


[{% img left http://sushihangover.github.io/images/PlayscriptLogo_small.png %}](https://github.com/PlayScriptRedux/playscript)
