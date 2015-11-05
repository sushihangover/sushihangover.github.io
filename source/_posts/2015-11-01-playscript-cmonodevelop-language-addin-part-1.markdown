---
layout: post
title: "Playscript | Xamarin / Monodevelop Language Addin (Part 1)"
date: 2015-11-01 01:22:10 -0800
comments: true
published: false
categories: 
- mono
- playscript
- monodevelop
- Xamarin
- Xamarin Studio
---

##Goal:

In this first part we are going to create an Addin that does the most basic language syntax highlighing using a SyntaxMode xml file.

##Prerequisites

You have the [MonoDevelop.AddinMaker](https://github.com/mono/mono-addins) installed and enabled within Xamarin Studio/MonoDevelop (XS/MD).

##Create the Solution/Project

With XS/MD, create a new solution/project. In this example we are using version 1.21 of the Addin Maker.

![](images/XamarinStudioAddin.png)

##Add the Syntax files

Language syntax files are XML documents that describe how the visual representation of language will appear within the editor. 

i.e.

	<Keywords color = "Keyword(Jump)">
		<Word>break</Word>
		<Word>continue</Word>
		<Word>return</Word>
	</Keywords>

Note: A definition of the contents of these XML files is out of scope for this posting. The best reference is the files themself. There are quite a number of them in the MonoDevelop `./main/src/core/Mono.Texteditor/SyntaxModes` directory, you should start the C# [one](https://github.com/mono/monodevelop/blob/bc908c9e791b0ee6f4951fb65495f82735bc95b7/main/src/core/Mono.Texteditor/SyntaxModes/CSharpSyntaxMode.xml).

In our case we are adding two syntax mode files, one for ActionScript and one for PlayScript.

Each file contains also has an mime-type attribute that will be used within our addin to provide a reference of the sourcefile extension to its mime type.

i.e.

	<SyntaxMode name = "ActionScript" mimeTypes="text/x-actionscript">

	<SyntaxMode name = "PlayScript" mimeTypes="text/x-playscript">

**Note**: Make sure you flag these files as `EmbeddedResources` so that they are included in the addin assembly.

##Mime-type to file ext. linkage

	<Extension path = "/MonoDevelop/Core/MimeTypes">
		<MimeType id="text/x-actionscript" _description="ActionScript source code" icon="md-actionscript-file" isText="true">
			<File pattern="*.as" />
		</MimeType>		
		<MimeType id="text/x-playscript" _description="PlayScript source code" icon="md-playscript-file" isText="true">
			<File pattern="*.play" />
		</MimeType>		
	</Extension>


##Add the File Filter Extension

This will allow the IDE to provide filter options to the various file dialogs.

	<Extension path = "/MonoDevelop/Ide/FileFilters">
		<FileFilter id = "ActionScript"
		            insertbefore = "Assemblies"
		            _label = "ActionScript Files"
		            extensions = "*.as"/>
		<FileFilter id = "PlayScript"
		            insertbefore = "Assemblies"
		            _label = "PlayScript Files"
		            extensions = "*.play"/>			            	            
	</Extension>

If you debug the project you will now find the ActionScript and PlayScript file filters are available:

![](images/MD-Addin-FileFilter.png)

##Add the Syntaxmode Extension

Add the extension templates to the `Manifest.addin.xml` file.

	<Extension path = "/MonoDevelop/SourceEditor2/SyntaxModes">
		<Templates resource="ActionScriptSyntaxMode.xml" />
		<Templates resource="PlayScriptSyntaxMode.xml" />
	</Extension>

##Add the mime-type resolver extension

Add the resolver extension class to the  `Manifest.addin.xml` file.

	<Extension path = "/MonoDevelop/Ide/TextEditorResolver">
		<Resolver class = "MonoDevelop.PlayScript.Resolver.TextEditorResolverProvider" mimeType="text/x-actionscript" />
		<Resolver class = "MonoDevelop.PlayScript.Resolver.TextEditorResolverProvider" mimeType="text/x-playscript" />
	</Extension>
	

## ProjectParameters Class

Add a new class called `PlayScriptProjectParameters`, this class will inherit from `MonoDevelop.Projects.ProjectParameters` and for now will be completely empty. We will be adding code to it in a future posting, but right now we just need to be able to create the class object.

## ActionScriptLanguageBinding Class

This class inherits from IDotNetLanguageBinding and other then stubbing out some methods and assigning the file extension that this class is related to (`.as`), the other thing that we need to do it call the static method `SyntaxModeService.LoadStylesAndModes` in the constructor in other for the Editor to load and parse the embedded xml file that contains our language's syntax:

		public ActionScriptLanguageBinding() {
			SyntaxModeService.LoadStylesAndModes (Assembly.GetExecutingAssembly ());
		}

		public string Language {
			get {
				return "ActionScript";
			}
		}

		public string ProjectStockIcon {
			get { 
				return "md-project";
			}
		}

		public FilePath GetFileName (FilePath baseName)
		{
			return baseName + ".as";
		}
			
		public bool IsSourceCodeFile (FilePath fileName)
		{
			return StringComparer.OrdinalIgnoreCase.Equals (Path.GetExtension (fileName), ".as");
		}

## PlayScriptScriptLanguageBinding Class

This is a repeat of the ActionScriptLanguageBinding class, but updated for the PlayScript `.play` extension.

		public string Language {
			get {
				return "PlayScript";
			}
		}

		public string ProjectStockIcon {
			get { 
				return "md-project";
			}
		}

		public FilePath GetFileName (FilePath baseName)
		{
			return baseName + ".play";
		}
			
		public bool IsSourceCodeFile (FilePath fileName)
		{
			return StringComparer.OrdinalIgnoreCase.Equals (Path.GetExtension (fileName), ".play");
		}


Running this and you will have very basic language highlighting in any `.as` and `.play` that you add to Xamarin Studio or MonoDevelop.

![](images/ActionScript-highlighting.png)

###Addition Required Reading:

####Michael Hutchinson's MonoDevelop.AddinMaker References:

[Creating a Simple Add-in](http://www.monodevelop.com/developers/articles/creating-a-simple-add-in/)

[MonoDevelop.AddinMaker 1.2](https://mhut.ch/addinmaker/1.2)

[MonoDevelop.AddinMaker 1.2.1](https://mhut.ch/addinmaker/1.2.1)

[MonoDevelop.AddinMaker 1.2](https://mhut.ch/journal/2015/03/12/monodevelopaddinmaker_12)

Source : [mhutch/MonoDevelop.AddinMaker](https://github.com/mhutch/MonoDevelop.AddinMaker)

####Mono.Addin References:

Documentation : [Mono.Addins](http://monoaddins.codeplex.com/)

Source : [mono/mono-addins](https://github.com/mono/mono-addins)