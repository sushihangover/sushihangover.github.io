---
layout: post
title: "Xamarin C# UIPickerView"
date: 2015-11-25 13:23:13 -0800
comments: true
categories: 
- C#
- Xamarin
- UIPickerView
- iPhone
- UIPickerViewModel
---
A real quickie example of a [UIPickerView][1]: ([iOS SDK][2])

![](/images/Xamarin-iPhone-Picker.gif)

Add a `UIPickerView` to your xib or Storyboard called `slotMachineView` and a label (named `selectedLbl`) to show the currently selected items.


    using System;
    using UIKit;
    
    namespace Slots
    {
    	public partial class ViewController : UIViewController
    	{
    		public ViewController (IntPtr handle) : base (handle)
    		{
    		}
    
    		public override void ViewDidLoad ()
    		{
    			base.ViewDidLoad ();
    				slotMachineView.Model = new StackOverflowModel (selectedLbl);
    		}
    
    		public override void DidReceiveMemoryWarning ()
    		{
    			base.DidReceiveMemoryWarning ();
    		}
    	}
    
    	public class StackOverflowModel : UIPickerViewModel
    	{
    		static string[] names = new string [] {
    			"pscorlib.dll",
    			"pscorlib_aot.dll",
    			"Mono.PlayScript.dll",
    			"PlayScript.Dynamic.dll",
    			"PlayScript.Dynamic_aot.dll",
    			"PlayScript.Optimization.dll",
    			"playshell.exe",
    			"psc.exe"
    		};
    
    		UILabel lbl;
    
    		public StackOverflowModel (UILabel lbl)
    		{
    			this.lbl = lbl;
    		}
    
    		public override nint GetComponentCount (UIPickerView v)
    		{
    			return 3;
    		}
    
    		public override nint GetRowsInComponent (UIPickerView pickerView, nint component)
    		{
    			return names.Length;
    		}
    
    		public override string GetTitle (UIPickerView picker, nint row, nint component)
    		{
    			switch (component) {
    			case 0:
    				return names [row];
    			case 1:
    				return row.ToString ();
    			case 2:
    				return new string ((char)('A' + row), 1);
    			default:
    				throw new NotImplementedException ();
    			}
    		}
    
    		public override void Selected (UIPickerView picker, nint row, nint component)
    		{
    			lbl.Text = String.Format ("{0} : {1} : {2}",
    				names [picker.SelectedRowInComponent (0)],
    				picker.SelectedRowInComponent (1),
    				picker.SelectedRowInComponent (2));
    		}
    
    		public override nfloat GetComponentWidth (UIPickerView picker, nint component)
    		{
    			if (component == 0)
    				return 220f;
    			else
    				return 30f;
    		}
    	}
    }

From my [answer](http://stackoverflow.com/a/33902474/4984832) on StackOverflow.

  [1]: https://developer.xamarin.com/api/type/MonoTouch.UIKit.UIPickerView/
  [2]: http://developer.apple.com/library/ios/documentation/UIKit/Reference/UIPickerView_Class/index.html
 