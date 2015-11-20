---
layout: post
title: "NUnit Console 2.4.8 vs 3.0 using .csproj files"
date: 2015-11-19 21:14:42 -0800
comments: true
categories: 
- mono
- os-x
- nunit
---
When using NUnit console 2.4.x and 3.x with `.csproj` files, it expects a valid and fairly complete MSBuild/xbuild project to determine the assembly name, dir location, and namespace that it will test in the Library-based project (Exe-based projects are possible if you have defined the proper entry point). In this example I used NUnit 2.4.x and 3.x **console** as there are execution differences but the same `.csproj` is being used so if you are using MonoDevelop/Xamarin Studio the IDE's built-in NUnit 2.4.x test pad will also work.

**NUnit 3.0 console (Install via nuget):**

    mono $(MTOOLS)/nunit3-console.exe  nunit-lib/nunit-lib.csproj --config=Debug
    
    NUnit Console Runner 3.0.5797 
    Copyright (C) 2015 Charlie Poole
    
    Runtime Environment
       OS Version: MacOSX 15.0.0.0 
      CLR Version: 4.0.30319.17020
    
    Test Files
        nunit-lib/nunit-lib.csproj
    
    Errors and Failures
    
    1) Failed : nunitlib.Test.TestCase
      Expected string length 8 but was 5. Strings differ at index 0.
      Expected: "Overflow"
      But was:  "Stack"
      -----------^
    at nunitlib.Test.TestCase () in <filename unknown>:line 0
    
    Test Run Summary
        Overall result: Failed
       Tests run: 1, Passed: 0, Errors: 0, Failures: 1, Inconclusive: 0
         Not run: 0, Invalid: 0, Ignored: 0, Explicit: 0, Skipped: 0
      Start time: 2015-11-20 12:36:28Z
        End time: 2015-11-20 12:36:28Z
        Duration: 0.132 seconds

**NUnit 2.4.8 (installed via Mono):**

**NOTE**: NUnit console 2.4.x is `broken` due a hard-coded Windows-style Directory Separator when parsing `.csproj` files and creating the expected CIL/assembly location, use `MONO_IOMAP` to work around it. This is not a issue in 3.0.

**NUnit Console 2.4.x w/o MONO_IOMAP:**

    nunit-console nunit-lib/nunit-lib.csproj -config=Debug
    ~~~~
    Unhandled Exception:
    System.IO.DirectoryNotFoundException: Directory "/Users/sushi/code/XamTests/nunit-lib/nunit-lib/bin\Debug" not found.
    ~~~~

**NUnit Console 2.4.x with MONO_IOMAP:**

    MONO_IOMAP=all nunit-console nunit-lib/nunit-lib.csproj -config=Debug
    
    NUnit version 2.4.8
    Copyright (C) 2002-2007 Charlie Poole.
    Copyright (C) 2002-2004 James W. Newkirk, Michael C. Two, Alexei A. Vorontsov.
    Copyright (C) 2000-2002 Philip Craig.
    All Rights Reserved.
    
    Runtime Environment - 
       OS Version: Unix 15.0.0.0
      CLR Version: 4.0.30319.17020 ( 4.2.1 (explicit/8862921 Thu Oct 29 17:09:16 EDT 2015) )
    
    .F
    Tests run: 1, Failures: 1, Not run: 0, Time: 0.115 seconds
    
    Test Case Failures:
    1) nunitlib.Test.TestCase :   Expected string length 8 but was 5. Strings differ at index 0.
      Expected: "Overflow"
      But was:  "Stack"
      -----------^

**.csproj example used in for example:**

    <?xml version="1.0" encoding="utf-8"?>
    <Project DefaultTargets="Build" ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
      <PropertyGroup>
        <Configuration Condition=" '$(Configuration)' == '' ">Debug</Configuration>
        <Platform Condition=" '$(Platform)' == '' ">AnyCPU</Platform>
        <ProjectGuid>{944946CD-39B2-4A16-A8A8-9F70F0450506}</ProjectGuid>
        <OutputType>Library</OutputType>
        <RootNamespace>nunitlib</RootNamespace>
        <AssemblyName>nunit-lib</AssemblyName>
        <TargetFrameworkVersion>v4.5</TargetFrameworkVersion>
      </PropertyGroup>
      <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|AnyCPU' ">
        <DebugSymbols>true</DebugSymbols>
        <DebugType>full</DebugType>
        <Optimize>false</Optimize>
        <OutputPath>bin\Debug</OutputPath>
        <DefineConstants>DEBUG;</DefineConstants>
        <ErrorReport>prompt</ErrorReport>
        <WarningLevel>4</WarningLevel>
        <ConsolePause>false</ConsolePause>
      </PropertyGroup>
      <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|AnyCPU' ">
        <DebugType>full</DebugType>
        <Optimize>true</Optimize>
        <OutputPath>bin\Release</OutputPath>
        <ErrorReport>prompt</ErrorReport>
        <WarningLevel>4</WarningLevel>
        <ConsolePause>false</ConsolePause>
      </PropertyGroup>
      <ItemGroup>
        <Reference Include="System" />
        <Reference Include="nunit.framework">
          <HintPath>..\packages\NUnit.2.6.4\lib\nunit.framework.dll</HintPath>
        </Reference>
      </ItemGroup>
      <ItemGroup>
        <Compile Include="Test.cs" />
      </ItemGroup>
      <Import Project="$(MSBuildBinPath)\Microsoft.CSharp.targets" />
      <ItemGroup>
        <None Include="packages.config" />
      </ItemGroup>
    </Project>

Ref: This was my [answer](http://stackoverflow.com/a/33827575/4984832) on StackOverflow
