---
layout: post
title: "OS-X : Using DiffMerge as your Git visual merge and diff tool"
date: 2014-02-19 20:56:11 -0800
comments: true
categories: 
- git
- diff
- merge 
- meld
- DiffMerge
- Beyond Compare
- OS-X
---
[{% img right /images/diffmerge_small.png "LLVM vs. GCC code generation for Bare Metal ARM development" %}](/images/diffmerge_large.png)
I tend to stay on the cmd line as much as possible, but for visual diffs, an ncurses console diff tool just does not cut it for me. [Beyond Compare Pro](http://www.scootersoftware.com/moreinfo.php) by [Scooter](http://www.scootersoftware.com/index.php) on Windows is one of best that I have ever used and with licenses at work I never had to worry about not having it on a work desktop or laptop. 

But on OS-X at home, Beyond Compare was not available. There is a 4.0 release in the works (beta now), but $50.00 USD for a personal-use copy on OS-X and not having feature parity with Windows Pro features(?), I just can not pull the trigger on that purchuse when there are other 
(cheaper) options that work just as well for personal development.

So, normally for a **free** visual diff, you can not beat [meld](http://meldmerge.org), it is a great open-source tool, but on OS-X it fires up X (Quartz for me) and it getting long in the tooth in terms of the GUI's human factors (feature set is still great). If there was a Qt version of this, the search would be over... free or not!

So some searching landed me on an old post by [Todd Huss](http://twobitlabs.com/2011/08/install-diffmerge-git-mac-os-x/) about using DiffMerge as your visual diff/merge for git and it was actually what I was looking for, well almost ;-) It is missing a few features, but they have a free version and it works really well and has a great OS-X interface... search is over for now... 

> [SourceGear](http://www.sourcegear.com/diffmerge/) has a $19.00 USD version that include file export with HTML formatting and if I could see example HTML code that it produces, I pay for that feature in a heart-beat, but the feature is completely locked out till you actaully register, bummer...

Todd recommends using the DiffMerge installer version vs. the dmg version, I go the other way on that. Download the dmg version, open it and drag/drop the app to your Applications. Then in a term window you can copy the *Extras/diffmerge.sh* to your */usr/local/bin* directory (Execute attrib is already set, so no chmod needed..), but I copied it as just *vdiff* as that is quicker to type. No admin rights are need to install it that way and that makes me happy... I can *vdiff file1.c file2.c* on the cmd line to pop the GUI open and populate it.

I then used the git setup he has listed and everything is working great so far. Click on the image above to it comparing the disassembly of [LLVM vs. GCC code generation for bare metal ARM](/images/diffmerge_large.png) development.

{% codeblock lang:bash Your git setup is: %}
git config --global diff.tool diffmerge
git config --global difftool.diffmerge.cmd 'diffmerge "$LOCAL" "$REMOTE"'
git config --global merge.tool diffmerge
git config --global mergetool.diffmerge.cmd 'diffmerge --merge --result="$MERGED" "$LOCAL" "$(if test -f "$BASE"; then echo "$BASE"; else echo "$LOCAL"; fi)" "$REMOTE"'
git config --global mergetool.diffmerge.trustExitCode true
{% endcodeblock %}

{% codeblock lang:bash Your git shortcuts are: linenos:false %}
# diff the local file.m against the checked-in version
git difftool file.m
# diff the local file.m against the version in some-feature-branch
git difftool some-feature-branch file.m
# diff the file.m from the Build-54 tag to the Build-55 tag
git difftool Build-54..Build-55 file.m
#To resolve merge conflicts, just run git mergetool:
git mergetool
{% endcodeblock %}

Thanks [Todd](http://twobitlabs.com), works great.
