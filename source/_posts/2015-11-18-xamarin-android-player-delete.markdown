---
layout: post
title: "Xamarin Android Player / Genymotion - Foobar 101"
date: 2015-11-18 15:16:42 -0800
comments: true
categories: 
- xamarin
- android
- player
- genymotion
---
I was really happy with Xamarin's Android Player (XAP) on OS-X 10.11 (and 10.10.x before I upgraded). It is much better the Google's plain-jane Android emulator, way way faster, easier setup as the images are pre-packaged Nexus images, etc... But you can not create custom images and that ends up being a problem as you need to test different configurations.

Someone recommended Genymotion and everything seemed fine, I could create custom Genymotion images and still use XAP for the basic testing... 

BUT after a reboot of OS-X, **everything went to @#$@#$@#**. Android sessions in either player would take 10 minutes or more to start up and get to the lock screen and when I say 'more', I mean up to 20 minutes...or MORE. Even then, services would die, the VirtualBox instance would hang, Xamarin Studio would not connect, XAP would report that the OpenGL server is not available, Genymotion would report no IP address could be retrieved... 

Removing Genymotion did not help. Deleting and re-install XAP did not help. Installing the latest VirtualBox did not help. Uninstall VirtualBox via their installer, deleting the XAP app and restarting from stratch did not help.... Removing all the original XAP Andriod images and re-downloading them did not help (I thought maybe the new VirtualBox updated them and caused a XAP issue, but no to that idea)...

Seems that I am not alone, if you started with Genymotion and later installed XAP, you could be in the same boot... after you reboot the first time. Seems Geny users call it **"surviving the reboot"**, if you make it past a reboot and everything is still working you should be golden, if not, your system is @#$#@$#.

I'm still looking for a solution other then **re-installing the OS as some people have resorted to**... I just do not have time do a fresh OS-X install so right now I can only test via actual physical devices :-(

**AHHHHHHHHHHHHHH!!!!!!!!!!!!!!!!!!!!!!!!!!**

