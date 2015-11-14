---
layout: post
title: "Android FileObserver example in Xamarin/C#"
date: 2015-11-14 03:08:38 -0800
comments: true
categories: 
- xamarin
- android
- csharp
- c#
---
This is from my answer on StackOverflow from a question that got closed. As not to lose it to the SO 'on-hold/close' flush, I am re-posting it.

#Question

How can you write an Android FileObserver in C#?

i.e. Native Java example:

	FileObserver observer = new FileObserver(imageUri.getPath()) {
	    public String basePath;
	
	    @Override
	    public void onEvent(int event, String path) {
	        String fullPath = basePath;
	        if(path != null) {
	            fullPath += path;
	        }
	        Log.d(TAG, "FILE: "+fullPath);
	    }
	};
	observer.basePath = imageUri.getPath();
	observer.startWatching();


#Answer

Create a class that inherits from [`Android.OS.FileObserver`][1], you only need to implement the [`OnEvent()`][2] and one(+) Constructors. Its a really simple pattern after you see it once... ;-)

**Quick Notes:**

* Watch on a **path**, if you need to filter by file, do it in the OnEvent
* Do not let your FileObserver object get GC'd or your OnEvents will magically stop :-/
* Remember to call StartWatching() in order to receive OnEvent calls

**C# FileObserver Class:**

    using System;
    using Android.OS;
    using Android.Util;
    
    namespace MyFileObserver
    {
    	public class MyPathObserver : Android.OS.FileObserver
    	{
    		static FileObserverEvents _Events = (FileObserverEvents.AllEvents);
    		const string tag = "StackoverFlow";
    
    		public MyPathObserver (String rootPath) : base(rootPath, _Events)
    		{
    			Log.Info(tag, String.Format("Watching : {0}", rootPath)); 
    		}
    
    		public MyPathObserver (String rootPath, FileObserverEvents events) : base(rootPath, events)
    		{
    			Log.Info(tag, String.Format("Watching : {0} : {1}", rootPath, events)); 
    		}
    
    		public override void OnEvent(FileObserverEvents e, String path)
    		{
    			Log.Info(tag, String.Format("{0}:{1}",path, e)); 
    		}
    	}
    }

**Example Usage:** 

    var pathToWatch = System.Environment.GetFolderPath (System.Environment.SpecialFolder.Personal);
    // Do not let myFileObserver get GC'd, stash it's ref in an activty, or ...
    myFileObserver = new MyPathObserver (pathToWatch);
    myFileObserver.StartWatching (); // and StopWatching () when you are done...
    var document = Path.Combine(pathToWatch, "StackOverFlow.txt");
    button.Click += delegate {
    	if (File.Exists (document)) {
    		button.Text = "Delete File";
    		File.Delete (document);
    	} else {
    		button.Text = "Create File";
    		File.WriteAllText (document, "Foobar");
    	}
    };

**adb logcat Output (when clicking on the test button):**

    I/StackoverFlow( 3596): StackOverFlow.txt:Create
    I/StackoverFlow( 3596): StackOverFlow.txt:Open
    I/StackoverFlow( 3596): StackOverFlow.txt:Modify
    I/StackoverFlow( 3596): StackOverFlow.txt:CloseWrite
    I/StackoverFlow( 3596): StackOverFlow.txt:Delete
    I/StackoverFlow( 3596): StackOverFlow.txt:Create
    I/StackoverFlow( 3596): StackOverFlow.txt:Open
    I/StackoverFlow( 3596): StackOverFlow.txt:Modify
    I/StackoverFlow( 3596): StackOverFlow.txt:CloseWrite
    I/StackoverFlow( 3596): StackOverFlow.txt:Delete
    I/StackoverFlow( 3596): StackOverFlow.txt:Create
    I/StackoverFlow( 3596): StackOverFlow.txt:Open
    I/StackoverFlow( 3596): StackOverFlow.txt:Modify
    I/StackoverFlow( 3596): StackOverFlow.txt:CloseWrite


  [1]: http://developer.xamarin.com/api/type/Android.OS.FileObserver/
  [2]: http://developer.xamarin.com/api/member/Android.OS.FileObserver.OnEvent/p/Android.OS.FileObserverEvents/System.String/
  
  
