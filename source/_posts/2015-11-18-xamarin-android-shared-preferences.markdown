---
layout: post
title: "Xamarin Android Shared Preferences"
date: 2015-11-18 13:56:58 -0800
comments: true
categories: 
- xamarin
- sharedperferences
- android
---
While I do not directly recommend this technique, it seems using the `PreferenceManager.GetDefaultSharedPreferences` is really popular in saving values between different activities. While you can create multiple names that do not conflict between different activities, it can get messy real fast.

Instead of using `GetDefaultSharedPreferences`, create multiple `GetSharedPreferences` with different names and thus you can store values with the same names without overwriting your values from a different activity. (Again, I am not a big fan of this technique either for anything more than some simple UI preference settings, see notes at bootom of post)

i.e.

			var title = "stack"; float price = 123.34f; long weight = 23; 
			var editor = GetSharedPreferences ("MyFirstActivity", Android.Content.FileCreationMode.Private);
			var edit = editor.Edit ();
			edit.PutString ("title", title);
			edit.PutFloat ("price", price);
			edit.PutLong ("weight", weight);
			edit.Apply ();

			title = "overflow"; price = 99.99f; weight = 99;
			editor = GetSharedPreferences ("MySecondActivity", Android.Content.FileCreationMode.Private);
			edit = editor.Edit ();
			edit.PutString ("title", title);
			edit.PutFloat ("price", price);
			edit.PutLong ("weight", weight);
			edit.Apply ();

			editor = GetSharedPreferences("MyFirstActivity", Android.Content.FileCreationMode.Private);
			title = editor.GetString("title", "empty");
			price = editor.GetFloat("price", 0);
			weight = editor.GetLong("weight", 0);
			Log.Info("activity1", string.Format("{0}:{1}:{2}", title, price, weight));

			editor = GetSharedPreferences("MySecondActivity", Android.Content.FileCreationMode.Private);
			title = editor.GetString("title", "empty");
			price = editor.GetFloat("price", 0);
			weight = editor.GetLong("weight", 0);
			Log.Info("activity2", string.Format("{0}:{1}:{2}", title, price, weight));

**adb logcat output:**

	[activity1] stack:123.34:23
	[activity2] overflow:99.99:99

**Notes:**

Personally when I see someone saving shopping cart data, using JSON to serialize objects in and out of SharedPerferences string values, etc..., my head starts to pound in a *bad way*. At that time you should really start looking for an **asynchronous**, persistent key-value store, like [Akavache](https://github.com/akavache/Akavache).
