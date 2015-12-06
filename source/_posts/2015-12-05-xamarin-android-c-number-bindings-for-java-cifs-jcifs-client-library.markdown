---
layout: post
title: "Xamarin Android C# bindings for Java CIFS (jCIFS) Client Library (Samba)"
date: 2015-12-05 20:19:59 -0800
comments: true
categories: 
- xamarin
- android
- samba
- C#
- java
---
I posted a Samba/JCIFS binding library to my [Github](https://github.com/sushihangover/Xamarin.Android.jCIFS) account...


#Xamarin.Android.jCIFS

This is a [C# binding library](https://github.com/sushihangover/Xamarin.Android.jCIFS) for the The Java CIFS (jCIFS) Client Library (version 1.3.18).

[JCIFS](http://jcifs.samba.org) is an Open Source client library that implements the CIFS/SMB networking protocol in 100% Java.

>You can read/write, delete, make directories, rename, list contents of a directory, list the workgroups/ntdomains and servers on the network, list the shares of a server, open named pipes, authenticate web clients ...etc.

###License: 

As [JCIFS](http://www.gnu.org/licenses/lgpl-2.1.txt) is Licensed Under the LGPL, so is this project's [license](http://opensource.org/licenses/LGPL-3.0).

###API Documentation: 

Consult the jCIFS site for [API](http://jcifs.samba.org/src/docs/api/) documention and usage, this is a C# binding library and does not implement/change anything within the `jcifs-1.3.18.jar`.


###Example:

####Usage of `Jcifs.Smb.SmbFileInputStream`:
	
	// This is NOT best-practice code, just showing a demo Jcifs api call
	public async Task getFileContents ()
	{
		await Task.Run (() => {
			var smbStream = new SmbFileInputStream ("smb://guest@10.10.10.5/code/test.txt");
			byte[] b = new byte[8192];
			int n;
			while ((n = smbStream.Read (b)) > 0) {
				Console.Write (Encoding.UTF8.GetString (b).ToCharArray (), 0, n);
			}
			Button button = FindViewById<Button> (Resource.Id.myButton);
			RunOnUiThread(() => {
				button.Text = Encoding.UTF8.GetString (b);
			});
		}
		).ContinueWith ((Task arg) => {
			Console.WriteLine (arg.Status);
			if (arg.Status == TaskStatus.Faulted)
				Console.WriteLine (arg.Exception);
		}
		);
	}


###Note: 

**The entire jCIFS library is not bound by this project, consult the "Metadata.xml" file in the binding project for method renames and class exclusions.
**