---
layout: post
title: "MonoMac: Detect when Mac sleeps or wakes"
date: 2014-01-12 20:44:00 -0800
comments: true
categories: 
- OS-X
- Mono
- MonoMac
- Xamarin
- C#
---
Saw a question on the Xwt.Mac group concerning getting Sleep and Wake events from MonoMac/C# on OS-X. Normally I would look for those event on the NSApplication default notification center, but a quick look at the Apple developer site quickly directed me to the those events being on the NSWorkspace's notification center, so another quick look in MonoMac and lucky those are already exposed so you do not have to do the AddObserver work yourself, but finding them in the 'online MonoMac API' did not return any direct results(?)... So here is my answer from that group in case anyone else google/bing this in the future:

Sleep and Wake are available on the NSWorkspace's notification center and MonoMac exposes those so so you do not have to write the AddObserver code yourself:

Apple Dev info on [NSWorkspaceWillSleepNotification &NSWorkspaceDidWakeNotification](https://developer.apple.com/library/mac/qa/qa1340/_index.html)

{% codeblock C# "Wake and Sleep Events" %}
Console.WriteLine ("Add the sleep/wake observers");
NSWorkspace.Notifications.ObserveWillSleep ((object sender, NSNotificationEventArgs e) => {
    Console.Write ("Your Mac is getting sleepy\n");
);
NSWorkspace.Notifications.ObserveDidWake ((object sender, NSNotificationEventArgs e) => {
    Console.Write ("Time to go to work again\n");
};
{% endcodeblock %}