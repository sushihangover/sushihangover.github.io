---
layout: post
title: "Sharpen - Part 2"
date: 2016-09-25 12:33:03 -0700
comments: true
categories: 
- c#
- sharpen
- mono
- java
- os-x
---

##Sharpen Setup

###Get Maven:

	brew install maven

###Check Maven:

	mvn --version
	
	Apache Maven 3.3.9 (bb52d8502b132ec0a5a3f4c09453c07478323dc5; 2015-11-10T08:41:47-08:00)
	Maven home: /usr/local/Cellar/maven/3.3.9/libexec
	Java version: 1.8.0_92, vendor: Oracle Corporation
	Java home: /Library/Java/JavaVirtualMachines/jdk1.8.0_92.jdk/Contents/Home/jre
	Default locale: en_US, platform encoding: UTF-8
	OS name: "mac os x", version: "10.11.6", arch: "x86_64", family: "mac"


###Clone the repo(s):

	git clone https://github.com/mono/sharpen.git
	git clone https://github.com/ydanila/sharpen_imazen_config.git

###Set your Java/JDK version to 1.7

* [http://sushihangover.github.io/sharpen/](http://sushihangover.github.io/sharpen/)


###Build the Sharpen config:

	pushd sharpen_imazen_config
	mvn install
	popd

Note: This is a sample config and a great starting point

###Build Sharpen

#####Note: Make sure that you are on the develop branch of Sharpen!

	pushd sharpen
	git checkout develop 

####Edit the `pom.xml` file so the cmd line `-help` option works:

	git diff pom.xml
	
	diff --git a/pom.xml b/pom.xml
	index 1098a2d..4fedcbc 100644
	--- a/pom.xml
	+++ b/pom.xml
	@@ -122,7 +122,7 @@
	     <testSourceDirectory>src/test</testSourceDirectory>
	     <resources>
	       <resource>
	-        <directory>src/test/resources</directory>
	+        <directory>src/main/resources</directory>
	       </resource>
	     </resources>
	     <testResources>

mvn clean test
mvn install

###Running Sharpen:

#### Cmd line help:

	java -jar ${PWD}/src/target/sharpencore-0.0.1-SNAPSHOT-jar-with-dependencies.jar -help     

#### Convert Java to C# (with config)

##### Copy config:
	cp ../sharpen_imazen_config/sharpen-all-options .
	cp ../sharpen_imazen_config/sharpen.config/target/MEConfiguration.sharpenconfig .

#### Run with config:

	java -jar \
	   ${PWD}/src/target/sharpencore-0.0.1-SNAPSHOT-jar-with-dependencies.jar \
	   /Users/sushi/code/github/PlayScriptParser/src \
	   -configurationClass \
	   MEConfiguration.sharpenconfig-jar @sharpen-all-options

	~~~
	Configuration Class: sharpen.config.MEConfiguration
	Configuration Class: Sharpen.Runtime
	project: asc
	Pascal case mode: NamespaceAndIdentifiers
	Native type system mode on.
	Separating interface constants to their own classes.
	Organize usings mode on.
    ~~~
   
#### Convert C# Location:

Your converted C# classes will be located **NEXT** the original source directory, `/Users/sushi/code/github/PlayScriptParser`, in my case, the **asc.net** directory

	cd /Users/sushi/code/github/PlayScriptParser
	ls -1
		asc.net
		build
		src
