---
layout: post
title: "JSON APIs to a Xamarin Realm Instance"
date: 2016-11-06 06:40:42 -0800
comments: true
categories: 
- xamarin
- realm
- json
---

![RealmJson.Extensions](https://github.com/sushihangover/Realm.Json.Extensions/raw/master/media/SushiHangover.RealmJson.png)

#SushiHangover.RealmJson.Extensions

####Extension Methods for adding JSON APIs to a Xamarin-based Realm Instance 

Supported:

* Xamarin.Forms
* Xamarin.iOs
* Xamarin.Android

##Usage / Examples:
	
###Single RealmObject from Json-based Strings:
	
	using (var theRealm = Realm.GetInstance(RealmDBTempPath()))
	{
		var realmObject = theRealm.CreateObjectFromJson<StateUnique>(jsonString);
	}

###Single RealmObject from a Stream:

	using (var stream = new MemoryStream(byteArray))
	using (var theRealm = Realm.GetInstance(RealmDBTempPath()))
	{
		var testObject = theRealm.CreateObjectFromJson<StateUnique>(stream);
	}


###Using Json Arrays from a `Xamarin.Android` Asset Stream:

	using (var theRealm = Realm.GetInstance(RealmDBTempPath()))
	using (var assetStream = Application.Context.Assets.Open("States.json"))
	{
		theRealm.CreateAllFromJson<State>(assetStream);
	}

###Using Json Arrays from a `Xamarin.iOS` Bundled Resource Stream:

	using (var theRealm = Realm.GetInstance(RealmDBTempPath()))
	using (var fileStream = new FileStream("./Data/States.json", FileMode.Open, FileAccess.Read))
	{
		theRealm.CreateAllFromJson<State>(fileStream);
	}


