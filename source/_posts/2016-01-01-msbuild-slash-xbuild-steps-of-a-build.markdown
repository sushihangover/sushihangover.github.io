---
layout: post
title: "MSBuild / xbuild - Steps of a build"
date: 2016-01-01 10:22:54 -0800
comments: true
categories: 
- playscript
- msbuild
- mono
- xbuild
---
I'm working on adding MSBuild style building to  PlayScript.

The end goal is two fold. 

1st) To support the standard MSBuild process in order to allow VS/MD/XS's IDEs to use this std process via the project file's target import tag. 

2nd) Can I replace the *compile* portion of the process (with the PlayScript compiler) so I directly create Xamarin.Mac, Xamarin.iOS and Xamarin.Android libraries that are written in PlayScript/ActionScript by using Xamarin's custom MSBuild process, but via a different compiler that produces the IL code? 

A compiled PlayScript library (or exe) is **just** a standard CIL assembly and can be referenced by C# projects, Xamarin mobile projects or not, but directly referencing Xamarin iOS, Android or Mac libraries will not work as those project types are *special* (mainly licensing checks and build steps). So the 2nd part of this is really an experient is to see if we are stuck to only linking to PlayScript libraries or can we use PlayScript to directly code against the Xamarin's mobile libraries and still comply with their licensing/build process.

Building via the `psc` CLI compiler is almost identical to using `csc` or `mcs`. There are a few different options are available in order to support *some* of the ActionScript 3 compiler options, but I digress...

The normal MSBuild / xbuild steps to compile a CSharp project (`.csproj`) involved the following high-level Targets:

* PrepareForBuild:
* CopyFilesMarkedCopyLocal:
* GenerateSatelliteAssemblies:
* CoreCompile:
* DeployOutputFiles:

Ignoring the multimedia pipeline processing of assets (images, SWFs, vector transformations, 3D models, etc..) the only step that we need to focus on is the `CoreCompile`:

**Import Project="$(MSBuildBinPath)\Microsoft.CSharp.targets"**

	
	~~~
	<Target
	        Name="CoreCompile"
	        Inputs="$(MSBuildAllProjects);@(Compile);@(ManifestResourceWithNoCulture);@(ManifestNonResxWithNoCultureOnDisk);@(CompiledLicenseFile);
	                $(KeyOriginatorFile);@(ReferencePath);$(Win32Icon);$(Win32Resource)"
	        Outputs="@(DocFileItem);@(IntermediateAssembly)"
	        DependsOnTargets="$(CoreCompileDependsOn)">
	        <Csc
	                AdditionalLibPaths="$(AdditionalLibPaths)"
	                AddModules="@(AddModules)"
	                AllowUnsafeBlocks="$(AllowUnsafeBlocks)"
	                BaseAddress="$(BaseAddress)"
	~~~
                    Win32Icon="$(Win32Icon)"
                    Win32Resource="$(Win32Resource)"
                    Resources="@(ManifestResourceWithNoCulture);@(ManifestNonResxWithNoCultureOnDisk);@(CompiledLicenseFile)"
                    ToolExe="$(CscToolExe)"
                    ToolPath="$(CscToolPath)" />

    </Target>
    ~~~
    
Looking at the `Csc` section, if I can replace `ToolExe` and `CscToolPath` properties then I can have this Target use PlayScript (`psc`) vs. `csc` or `mcs`.

So as a quick test, copying `Microsoft.CSharp.targets` to PlayScript.MSBuild.Targets` and adding this`PropertyGroup` section with hardcoded paths before the `CoreCompile` target section:

        <PropertyGroup>
                <PlayScriptBinPath Condition=" '$(PsBuildBinPath)' == '' ">/Users/sushi/Library/Application Support/XamarinStudio-5.0/LocalInstall/Addins/MonoDevelop.PlayScript.5.10.2/MonoDevelop.PlayScript.SupportPackages</PlayScriptBinPath>
                <CscToolExe Condition=" '$(CscToolExe)' == '' ">psc</CscToolExe>
                <CscToolPath Condition=" '$(CscToolPath)' == '' ">$(PsBuildBinPath)</CscToolPath>
        </PropertyGroup>
        
And replacing:

	<Import Project="$(MSBuildBinPath)\Microsoft.CSharp.targets" />

with:

	<Import Project="packages\PlayScript.MSBuild.5.10.2.2\build\PlayScript.MSBuild.Targets" />

**>xbuild nuget-test.psproj**

	XBuild Engine Version 12.0
	Mono, Version 4.2.2.0
	Copyright (C) 2005-2013 Various Mono authors
	
	Build started 1/1/2016 11:05:25 AM.
	__________________________________________________
	Project "/Users/sushi/code/XamTests/nuget-test/nuget-test.psproj" (default target(s)):
		Target PrepareForBuild:
			Configuration: Debug Platform: x86
		Target BeforeResolveReferences:
			                 AssemblySearchPaths: {CandidateAssemblyFiles};{HintPathFromItem};{TargetFrameworkDirectory};{PkgConfig};{GAC};{RawFileName};bin/Debug/;/Users/sushi/mono/play32/bin
		Target GenerateSatelliteAssemblies:
		No input files were specified for target GenerateSatelliteAssemblies, skipping.
		Target GenerateTargetFrameworkMonikerAttribute:
		Skipping target "GenerateTargetFrameworkMonikerAttribute" because its outputs are up-to-date.
		Target CoreCompile:
			 psc
			 /Users/sushi/mono/play32/bin
	
			Tool /Users/sushi/mono/play32/bin/psc execution started with arguments: /noconfig /debug:full /debug+ /optimize- /out:obj/x86/Debug/nuget-test.exe Main.play /target:exe /define:DEBUG /nostdlib /platform:x86 /reference:/Library/Frameworks/Mono.framework/Versions/4.2.2/lib/mono/4.5/System.dll /reference:packages/PlayScript.AOT.5.10.2.0/lib/net45/PlayScript.Dynamic_aot.dll /reference:packages/PlayScript.AOT.5.10.2.0/lib/net45/pscorlib_aot.dll /reference:/Library/Frameworks/Mono.framework/Versions/4.2.2/lib/mono/4.5/System.Core.dll /reference:/Library/Frameworks/Mono.framework/Versions/4.2.2/lib/mono/4.5/mscorlib.dll /warn:4
		Target DeployOutputFiles:
			Copying file from '/Users/sushi/code/XamTests/nuget-test/obj/x86/Debug/nuget-test.exe.mdb' to '/Users/sushi/code/XamTests/nuget-test/bin/Debug/nuget-test.exe.mdb'
			Copying file from '/Users/sushi/code/XamTests/nuget-test/obj/x86/Debug/nuget-test.exe' to '/Users/sushi/code/XamTests/nuget-test/bin/Debug/nuget-test.exe'
	Done building project "/Users/sushi/code/XamTests/nuget-test/nuget-test.psproj".
	
	Build succeeded.
		 0 Warning(s)
		 0 Error(s)
	
	Time Elapsed 00:00:01.8555370
	
That works, **cool**... 

But that requires mod'ing complete copy of `Microsoft.CSharp.targets`.

So lets strip out everything but our PlayScript changes and import the std CSharp targets.

	<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
	    <Import Project="$(MSBuildBinPath)\Microsoft.CSharp.targets" />
	    
		<PropertyGroup>
			<DefaultLanguageSourceExtension>.cs</DefaultLanguageSourceExtension>
			<Language>PlayScript</Language>
		</PropertyGroup>
	
	<!-- PlayScript -->
		<PropertyGroup>
			<PlayScriptBinPath Condition=" '$(PsBuildBinPath)' == '' ">/Users/sushi/Library/Application Support/XamarinStudio-5.0/LocalInstall/Addins/MonoDevelop.PlayScript.5.10.2/MonoDevelop.PlayScript.SupportPackages</PlayScriptBinPath>
			<CscToolExe Condition=" '$(CscToolExe)' == '' ">psc</CscToolExe>
			<CscToolPath Condition=" '$(CscToolPath)' == '' ">$(PsBuildBinPath)</CscToolPath>
		</PropertyGroup>
	<!-- PlayScript -->
	
	<!--
		Note: Microsoft.CSharp.targets already imports Microsoft.Common.targets
			  so if we need to override/replacement would need to do it after the 
			  Microsoft.CSharp.targets import either in this file or by importing another
			  file, i.e. PlayScript.Common.targets
			  (this is where we will include our multimedia pipeline tasks)
		<Import Project="$(MSBuildBinPath)\Microsoft.Common.targets" />
	-->
	
	<!-- PlayScript -->
		<Target Name="BeforeResolveReferences">
	  		<CreateProperty
	    		Value="$(AssemblySearchPaths);$(PsBuildBinPath)">
	    	    <Output TaskParameter="Value" PropertyName="AssemblySearchPaths" />
	        </CreateProperty>
	    </Target>
	<!-- PlayScript -->
	
	    <Import Project="$(MSBuildThisFileDirectory)\PlayScript.MSBuild.Debug.Targets" />
	</Project>

That works...

We still need to look into the custom Xamarin Mobile targets and  remove the hardcoded paths from our PlayScript targets, but lets leave that for another post.
