---
layout: post
title: "Xamarin.iOS binding project for SVGKit"
date: 2016-11-13 15:38:34 -0800
comments: true
categories: 
- xamarin
- xamarin.ios
- svgkit
- ios
---

#SushiHangover.SVGKit

This is a `Xamarin.iOS` binding project for `SVGKit`

* SVGKit v2.x - live development, latest fixes/features
* Xamarin.iOS Version: 10.4.0.4
* Xcode 8.1 (11544) Build 8B62

##SVGKit

>SVGKit is a Cocoa framework for rendering SVG files natively: it's fast and powerful. Some additional info and links are on the wiki

Ref: [https://github.com/SVGKit/SVGKit](https://github.com/SVGKit/SVGKit)

##Nuget:

`PM> Install-Package SushiHangover.SVGKit.Binding`

Ref: [https://www.nuget.org/packages/SushiHangover.SVGKit.Binding](https://www.nuget.org/packages/SushiHangover.SVGKit.Binding)

##Usage:

###Namespace: `SVGKit` 

	using SVGKit;

###Load SVG from a Bundle Resource

####Build action: `BundleResource`
	
	var image = new SVGKImage("Media/Sushi.svg");
	var imageView = new SVGKFastImageView(image);
	imageView.Frame = View.Frame;
	View.Add(imageView);

![](https://github.com/sushihangover/SVGKit.Binding/raw/master/Media/SimulatorScreen.png)

###Load SVG from a Bundle Path

####Build action: `Content`
	
	var image = new SVGKImage(Path.Combine(NSBundle.MainBundle.BundlePath, "Media/Joker.svg"));
	var imageView = new SVGKFastImageView(image);
	imageView.Frame = View.Frame;
	View.Add(imageView);

![](https://github.com/sushihangover/SVGKit.Binding/raw/master/Media/SimulatorScreen2.png)


