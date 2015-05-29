---
published: true
layout: post
title: "Octopress: Backing up your source directory"
date: 2014-02-12 21:00:12 -0800
comments: true
categories: 
- Octopress
- GitHub
- git
---
It has only been a couple of days using [Octopress](http://octopress.org) and [Pow*](http://pow.cx) but I am already sold. For offline blogging, [GitHub Pages](http://pages.github.com) support, a great set of standard Markdown-ish driven Plugins, etc... the workflow is great. There are a few things that I am missing like:

My Missing Octopress Items:
> * Image Auto Thumbnailing
> * Image Popups from those Thumbnails
> * Post Staging (The 'published: false' yaml front matter is a start but....)
> * Auto source directory version control

That last one was my highest proirity. When you run the Octopress GitHub Pages setup, it configures the deployment repo (XXXXXX.github.io), but you still need to backup and/or version control the 'source' directory.

Here is my quick way of doing this using the deployment repo.

> * Add a **source** branch your your "XXXXXX.github.io" repo
> * Set your local source directory as a **single branch** of that repo
> * Commit and Push after you do a *rake deploy*

So lets add a source branch to your GitHub Page repo:
		Note: This is my quick way (ie. hackie) to get an ***EMPTY* new *remote* branch** into an existing repo. If someone knows a better way, I'd love to hear it.

{% codeblock lang:bash %}
# Get your current repo and place it into a a temp directory
git clone https://github.com/sushihangover/sushihangover.github.io.git foo.bar
pushd foo.bar
# Add a new branch to your local copy
git checkout -b source
# Delete all the existing context
rm -Rf *
# Commit all those deletes
git commit --all --message="Initial Empty source branch"
# Push that emopty branch back to GitHub
git push 
popd
# GEt rid of that temp. directory
rm -Rf foo.bar
{% endcodeblock %}

You already have an existing source directory and if you did not change the _config.yaml defaults is under your Octopress directory and those files need to be placed in this new source branch you just created.

{% codeblock lang:bash %}
# Move your existing source directory out of the way for now
mv source source.org
# Clone your GitHub Page repo BUT only a single branch of it, only the source branch and into a directory named source
# Note: The "--single-branch -branch source" options are not used by most git users but can make speciallized repo copies quick and fool-proof
git clone --single-branch -branch source https://github.com/sushihangover/sushihangover.github.io.git source
# Now copy your existing source files into this empty repo directory
cp -R source.org source
pushd source
# Commit and Push your sources files to GitHub
git commit --all --message="Initial source branch commit"
# Add your commit comment and save
git push
{% endcodeblock %}

Now you have two branches in your Pages repo. **master** will be your deployed/published blog pages and **source** will be the content Octopress uses to create those pages.

Now, anytime you need to **backup work-in-progress** source changes or after you you do a **rake deploy** you can just do this:
```
pushd source; git commit --all --message="Blog updated"; git push; popd
```
I'll be including this in the Github Page deploy plugin in the future so everytime I publish (deploy) I will also get a matching commit to the source branch.... But that and the other items on the Todo list will have to wait till later... ;-) 

* Pow is a zero-config Rack server for Mac OS X : [Watch Me](http://get.pow.cx/media/screencast.mov)

