---
layout: post
title: "Octopress - Deploy and update Git source"
date: 2015-06-08 06:39:42 -0700
comments: true
categories: 
- octopress
- git
- github
---
![](/images/Octopress_logo.png)

I use [Octopress](http://octopress.org) for this [GitHub](https://github.com/sushihangover) blog and can tend to forget to push the source to Github as it is not part of the 'rake deploy'.

'rake deploy' only updates the master branch on Github on order to publish the website and instead of hack'ing the deploy function to handle pushing the ''source' branch also (waiting on the Octopress 3.0 release for that), I wrote a script to handle it all. 

This *lazy* script that does all the steps that I would have to do manually but tend to never do. And it is in my root Octopress directory so it included in my source revisions ;-) 

Nothing special: just generates, deploys, adds all on the source branch along with a commit and push. For good measure it then garbage collects the repo to keep everything clean.

    #!/usr/bin/env bash
    echo "Generate and deploying website"
    rake generate
    rake deploy
    echo "Commiting and pushing source files"
    git add --all; 
    git commit -m "New posts"; 
    git push 
    git gc
    pushd _deploy
    git gc
    popd



