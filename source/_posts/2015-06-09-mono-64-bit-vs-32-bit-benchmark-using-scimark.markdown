---
layout: post
title: "Mono - 64-bit vs. 32-bit benchmark using SciMark"
date: 2015-06-09 19:42:27 -0700
comments: true
categories: 
- mono
- scimark
- benchmark
---
{% img left http://sushihangover.github.io/images/mono-logo.png %} I wanted to compare 64-bit and 32-bit mono versions and PE32 vs PE32+ CIL images and see if 64-bit really is faster, at least on the number crunching side of things.

{% blockquote https://code.google.com/p/scimark-csharp %} This is the C# port of the Scimark benchmark. The original C and Java sources can be found at http://math.nist.gov/scimark2/. The original work to port the benchmark to C# was done by Chris Re and Wener Vogels of the Rotor project. {% endblockquote %}

Running an Apples to Apples comparision across platforms and different mono builds using different llvm versions jitting is not really valid test-case. So the following benchmark matrix is based on the **same** clang/llvm version compiling the **same** mono version in x64 (PE32+) and i386 (PE32) archs.

Compile: 

* x64 and x86 Mono Debug versions (Debug Full, no optimize) 
* x64 and x86 Mono Release (No Debug, Optimized)

Execute 32-bit Mono and 62-bit Mono loading the respective CIL (exe) images:

* **LLVM turned off**  
* **LLVM turned on** (--llvm)

{% pullquote %}
The results are not really that surprising in regards to is 64-bit number crunching faster than 32-bit, yes, 64-bit it faster, about 1.2x faster. The surprise for me is the LLVM results, both in  {" x86 and x64 versions of mono/llvm builds, mono enabled LLVM produces code that is 1.5x faster "} under SciMark. This speed difference is well worth the slightly longer startup times that jitting with LLVM causes.
{% endpullquote %}

Get the SciMark repo on my [GitHub]( https://github.com/sushihangover/scimark-csharp) and run it on your platform.

<div>
<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;border-color:#999;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:0px;overflow:hidden;word-break:normal;border-color:#999;color:#444;background-color:#F7FDFA;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:0px;overflow:hidden;word-break:normal;border-color:#999;color:#fff;background-color:#26ADE4;}
.tg .tg-s6z2{text-align:center}
.tg .tg-5hgy{background-color:#D2E4FC;text-align:center}
.tg .tg-2xdq{background-color:#D2E4FC;font-weight:bold;color:#009901;text-align:center}
.tg .tg-y9vz{color:#036400}
</style>
</div>

<div class="tg-wrap"><table id="tg-sAgiW" class="tg">
  <tr>
    <th class="tg-s6z2">CPU Arch</th>
    <th class="tg-s6z2">Build Type</th>
    <th class="tg-s6z2">LLVM</th>
    <th class="tg-s6z2">Score (MFlops)</th>
    <th class="tg-031e">Notes:</th>
  </tr>
  <tr>
    <td class="tg-s6z2">x86</td>
    <td class="tg-5hgy">Debug</td>
    <td class="tg-s6z2"></td>
    <td class="tg-5hgy">371.42</td>
    <td class="tg-031e"><br></td>
  </tr>
  <tr>
    <td class="tg-s6z2">x86</td>
    <td class="tg-5hgy">Debug</td>
    <td class="tg-s6z2">Yes</td>
    <td class="tg-5hgy">465.45</td>
    <td class="tg-031e">1.2 times faster using LLVM</td>
  </tr>
  <tr>
    <td class="tg-s6z2">x86</td>
    <td class="tg-5hgy">Release</td>
    <td class="tg-s6z2"></td>
    <td class="tg-5hgy">295.11</td>
    <td class="tg-031e"></td>
  </tr>
  <tr>
    <td class="tg-s6z2">x86</td>
    <td class="tg-5hgy">Release</td>
    <td class="tg-s6z2">Yes</td>
    <td class="tg-5hgy">448.92</td>
    <td class="tg-031e">1.5 times faster using LLVM over not <br>using it in Release mode</td>
  </tr>
  <tr>
    <td class="tg-s6z2">x64</td>
    <td class="tg-5hgy">Debug</td>
    <td class="tg-s6z2"></td>
    <td class="tg-5hgy">367.22</td>
    <td class="tg-031e"></td>
  </tr>
  <tr>
    <td class="tg-s6z2">x64</td>
    <td class="tg-5hgy">Debug</td>
    <td class="tg-s6z2">Yes</td>
    <td class="tg-5hgy">559.28</td>
    <td class="tg-031e"></td>
  </tr>
  <tr>
    <td class="tg-s6z2">x64</td>
    <td class="tg-5hgy">Release</td>
    <td class="tg-s6z2"></td>
    <td class="tg-5hgy">370.79</td>
    <td class="tg-031e"></td>
  </tr>
  <tr>
    <td class="tg-s6z2">x64</td>
    <td class="tg-5hgy">Release</td>
    <td class="tg-s6z2">Yes</td>
    <td class="tg-2xdq">569.46</td>
    <td class="tg-y9vz">1.2 times faster than x86 using LLVM<br>1.5 times faster than x64 without LLVM</td>
  </tr>
</table></div>
<script type="text/javascript" charset="utf-8">var TgTableSort=window.TgTableSort||function(n,t){"use strict";function r(n,t){for(var e=[],o=n.childNodes,i=0;i<o.length;++i){var u=o[i];if("."==t.substring(0,1)){var a=t.substring(1);f(u,a)&&e.push(u)}else u.nodeName.toLowerCase()==t&&e.push(u);var c=r(u,t);e=e.concat(c)}return e}function e(n,t){var e=[],o=r(n,"tr");return o.forEach(function(n){var o=r(n,"td");t>=0&&t<o.length&&e.push(o[t])}),e}function o(n){return n.textContent||n.innerText||""}function i(n){return n.innerHTML||""}function u(n,t){var r=e(n,t);return r.map(o)}function a(n,t){var r=e(n,t);return r.map(i)}function c(n){var t=n.className||"";return t.match(/\S+/g)||[]}function f(n,t){return-1!=c(n).indexOf(t)}function s(n,t){f(n,t)||(n.className+=" "+t)}function d(n,t){if(f(n,t)){var r=c(n),e=r.indexOf(t);r.splice(e,1),n.className=r.join(" ")}}function v(n){d(n,L),d(n,E)}function l(n,t,e){r(n,"."+E).map(v),r(n,"."+L).map(v),e==T?s(t,E):s(t,L)}function g(n){return function(t,r){var e=n*t.str.localeCompare(r.str);return 0==e&&(e=t.index-r.index),e}}function h(n){return function(t,r){var e=+t.str,o=+r.str;return e==o?t.index-r.index:n*(e-o)}}function m(n,t,r){var e=u(n,t),o=e.map(function(n,t){return{str:n,index:t}}),i=e&&-1==e.map(isNaN).indexOf(!0),a=i?h(r):g(r);return o.sort(a),o.map(function(n){return n.index})}function p(n,t,r,o){for(var i=f(o,E)?N:T,u=m(n,r,i),c=0;t>c;++c){var s=e(n,c),d=a(n,c);s.forEach(function(n,t){n.innerHTML=d[u[t]]})}l(n,o,i)}function x(n,t){var r=t.length;t.forEach(function(t,e){t.addEventListener("click",function(){p(n,r,e,t)}),s(t,"tg-sort-header")})}var T=1,N=-1,E="tg-sort-asc",L="tg-sort-desc";return function(t){var e=n.getElementById(t),o=r(e,"tr"),i=o.length>0?r(o[0],"td"):[];0==i.length&&(i=r(o[0],"th"));for(var u=1;u<o.length;++u){var a=r(o[u],"td");if(a.length!=i.length)return}x(e,i)}}(document);document.addEventListener("DOMContentLoaded",function(n){TgTableSort("tg-sAgiW")});</script>


