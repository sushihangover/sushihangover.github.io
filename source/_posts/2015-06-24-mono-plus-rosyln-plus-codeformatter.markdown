---
layout: post
title: "OS-X + Mono + Rosyln + CodeFormatter"
date: 2015-06-25 06:20:17 -0700
comments: true
categories: 
- os-x
- microsoft
- mono
- rosyln
- codeformatter
---
CodeFormatter is a tool that uses Roslyn to automatically rewrite the source to follow Microsoft's coding styles, which are [documented here](https://github.com/dotnet/corefx/blob/master/Documentation/coding-style.md).

CodeFormatter has been released as open-source for 6 months now, but I have not had a chance to look at it.

With Roslyn compiling on OS-X and I had a couple of projects that really needed to be cleaned up, I thought I would give it a try.

15 minutes in total to clone the repo and get things built properly, would have been quicker but the VS solution file is not very Xamanin Studio/MonoDevelop friendly as it includes ToolVersion 14 items (That would be included in VS 2015 beta).

But those projects are not needed to get the main program working... 

### mono ./CodeFormatter.exe

	Must specify at least one project / solution / rsp to format
	CodeFormatter [/file:<filename>] [/lang:<language>] [/c:<config>[,<config>...]>]
	    [/copyright:<file> | /nocopyright] [/tables] [/nounicode]
	    [/rule(+|-):rule1,rule2,...]  [/verbose]
	    <project, solution or response file>

	    /file        - Only apply changes to files with specified name
	    /lang        - Specifies the language to use when a responsefile is
	                   specified. i.e. 'C#', 'Visual Basic', ... (default: 'C#')
	    /c           - Additional preprocessor configurations the formatter
	                   should run under.
	    /copyright   - Specifies file containing copyright header.
	                   Use ConvertTests to convert MSTest tests to xUnit.
	    /nocopyright - Do not update the copyright message.
	    /tables      - Let tables opt out of formatting by defining
	                   DOTNET_FORMATTER
	    /nounicode   - Do not convert unicode strings to escape sequences
	    /rule(+|-)   - Enable (default) or disable the specified rule
	    /rules       - List the available rules
	    /verbose     - Verbose output

### mono ./CodeFormatter.exe /rules

	Name                 Description
	==============================================
	BraceNewLine         :Ensure all braces occur on a new line
	Copyright            :Insert the copyright header into every file
	NewLineAbove         :Ensure there is a new line above the first namespace and using in the file
	CustomCopyright      :Remove any custom copyright header from the file
	UsingLocation        :Place using directives outside namespace declarations
	UnicodeLiterals      :Use unicode escape sequence instead of unicode literals
	ExplicitVisibility   :Ensure all members have an explicit visibility modifier
	IllegalHeaders       :Remove illegal headers from files
	FormatDocument       :Run the language specific formatter on every document
	ExplicitThis         :Remove explicit this/Me prefixes on expressions except where necessary
	ReadonlyFields       :Mark fields which can be readonly as readonly
	FieldNames           :Prefix private fields with _ and statics with s_


 I'll be checking next to see if it really works on some source code. ;-)