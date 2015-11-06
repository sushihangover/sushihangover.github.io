---
layout: post
title: "PlayScript Addin - Adding code templates"
date: 2015-11-06 07:44:44 -0800
comments: true
published: false
categories: 
- mono
- playscript
- actionscript
- monodevelop
- xamarin studio
- addin
---
{% img left http://sushihangover.github.io/images/PlayscriptLogo_small.png %}
In [Addin part 1](/playscript-cmonodevelop-language-addin-part-1/) we created the most basic language [Addin](https://github.com/PlayScriptRedux/PlayScript.Addin) using static xml syntax mode files. In this outing we will be adding code templates so the user can create PlayScript and ActionScript projects and files as a way to jump-start their coding.

#Images

If we look at MonoDevelop source, we can see that core templates provide two **png** images per project type with the following resolution and naming convention. 

* 240 x 140 - imagename.png
* 480 x 280 - imagename@2x.png

Ref: [main/src/core/MonoDevelop.Ide/templates/images](https://github.com/mono/monodevelop/tree/master/main/src/core/MonoDevelop.Ide/templates/images)

#Icons

Project:

* 16 x 16 - project-16.png
* 32 x 32 - project-16@2x.png **&** project-32.png
* 64 * 64 - project-32@2x.png **&** project-64.png
* 128 x 128 - project-64@2x.png **&** project-128.png
* 256 x 256 - project-256.png

**Note**: I have not looked at the code to determine why icons of the same resolution exist as two different files. I just replicted the MD structure and it works, so I leave this to the reader to `grep` for ;-) 

OverLay:

The project icons are overlayed with smaller images typically in the lower right or left. This is a really slick way of creating dynimic icons and reducing the physical number of icons that have to be created. In a resolution matrix that would have needed 128 icons, this way only requires 24 images/icons.

Two resolutions:

* 32 x 32 - project-{type}-overlay-32.png
* 64 x 64 - project-{type}-overlay-32@2x.png

There are 8 **types** (that I could find):

* console
* gui
* library
* nuint
* package
* reference
* shared
* web



#StockIcons Extension

#MimeTypes Extension



Also visit the "[NRefactory | PlayScript & ActionScript](/nrefactory-playscript-and-actionscript/)" posting as we will be using it in the future as we add more features to the addin.


