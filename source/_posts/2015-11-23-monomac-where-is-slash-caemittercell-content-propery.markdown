---
layout: post
title: "MonoMac - Where is the CAEmitterCell Content propery?"
date: 2015-11-23 06:01:10 -0800
comments: true
categories: 
- mono
- monomac
- playscript
- actionscript
- away3d
---
{% img left /images/MonoMac-Fire.gif Fire %}
I was trying to integrate ActionScript and Away3d with the CAEmitterCell particles using MonoMac for users that do not have access (a license) to Xamarin.Mac, but...

The MonoMac project is missing the maccore `CoreAnimation/CAEmitterCell.cs` in the Make.shared and thus the `MonoMac.dll` that is distributed via Xamarin Studio is broken in this regard as it is missing the ability to assign an Image to the emitter.

Example:

				// Create the fire emitter cell
				CAEmitterCell fire = CAEmitterCell.EmitterCell ();
				fire.EmissionLongitude = (float)Math.PI;
				fire.BirthRate = 0;
				fire.Velocity = 80;
				fire.VelocityRange = 30;
				fire.EmissionRange = 1.1f;
				fire.AccelerationY = 200;
				fire.ScaleSpeed = 0.3f;
	
				RectangleF rect = RectangleF.Empty;
				CGColor color = new CGColor (0.8f,0.4f,0.2f,0.10f);
				fire.Color = color;
				fire.Contents = NSImage.ImageNamed ("fire.png").AsCGImage (ref rect, null, null);


I have updated PlayScript's [MonoMac](https://github.com/PlayScriptRedux/monomac) (forked from [Mono/MonoMac](https://github.com/mono/monomac)) to fix this. 



**git diff src/Make.shared**

	diff --git a/src/Make.shared b/src/Make.shared
	index 986ff28..a84aeae 100644
	--- a/src/Make.shared
	+++ b/src/Make.shared
	@@ -44,6 +44,7 @@ SHARED_SOURCE = \
	        ./CoreAnimation/CALayer.cs                      \
	        ./CoreAnimation/CATextLayer.cs                  \
	        ./CoreAnimation/CAMediaTimingFunction.cs        \
	+       ./CoreAnimation/CAEmitterCell.cs                \
	        ./CoreFoundation/CFArray.cs                     \
	        ./CoreFoundation/CFBoolean.cs                   \
	        ./CoreFoundation/CFDictionary.cs                \
