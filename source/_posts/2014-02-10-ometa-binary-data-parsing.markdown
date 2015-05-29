---
layout: post
title: "OMeta Binary data parsing"
date: 2014-02-10
comments: true
categories:
- Ometa
- Ometa/JS
- JavaScript
- C#
---
[Josh Marinacci ](http://joshondesign.com/)has a blog post concerning using OMeta to parse binary data and while there was not a complete cut/paste of all the Javascript code needed to run it in [OMeta/JS](http://tinlizzie.org/ometa-js), I saved his grammar for review as I was working on binary parsing using an OMeta that was using C# as the host language. Recently I give the link of his posting to someone else, but turns out Josh's blog was offline (crashed?).  (Update; Appears his blog is working again, so you can refer to the link below for his original post)

So I dug up what I had and whipped up an OMeta/JS example for a complete working proof of concept and here are the results. I am not a JavaScript kind-of-guy, so be nice regarding the code. ;-)

Note: The W3 spec has 18 chunks that can be defined in PNG files and I added 'iTXt' to Josh's original as the PNG I was using as an example had a large chunk of XML data in it, but a lot of chunks are still missing as this is just a proof of concept and the original binaries that I was parsing were not PNGs, but custom AMF2 byte streams that were getting converted to objects 'on the 'fly' via IlGenerator in C#...

Original PNG parse concept from Josh is at the following link assuming he gets the blog working: [http://joshondesign.com/2013/03/18/ConciseComputing](http://joshondesign.com/2013/03/18/ConciseComputing)

And his related email thread on vpri.org : [http://vpri.org/pipermail/ometa/2013-March/000524.html](http://vpri.org/pipermail/ometa/2013-March/000524.html)

So if you load up OMeta/JS, the complete grammar and Javascript functions needed is shown below. Just open up your JS console before doing a "Do It" so you can see the chunk information found in the PNG and interact with the final object.

Here is an example console output of parsing a PNG file via this OMeta/JS script:

```
[Log] loaded
[Log] got 24648 bytes
[Log] i32 : 13 <= [13, 0, 0, 0]
[Log] ChunkType :IHDR : [73, 72, 68, 82]
[Log] i32 : 139 <= [139, 0, 0, 0]
[Log] i32 : 119 <= [119, 0, 0, 0]
[Log] i32 : 25 <= [25, 0, 0, 0]
[Log] ChunkType :tEXt : [116, 69, 88, 116]
[Log] String:SoftwareAdobe ImageReady (...byteArrayOmitted...)
[Log] i32 : 1974 <= [182, 7, 0, 0]
[Log] ChunkType :iTXt : [105, 84, 88, 116]
[Log] String:ML:com.adobe.xmp<?xpacket begin="ï»¿" id="W5M (...only first 50 bytes shown...)
[Log] i32 : 22568 <= [40, 88, 0, 0]
[Log] ChunkType :IDAT : [73, 68, 65, 84]
[Log] i32 : 0 <= [0, 0, 0, 0]
[Log] ChunkType :IEND : [73, 69, 78, 68]
[Log] ["PNG HEADER", Array[5], Array[0]]
```

This is a working example of parsing binary data parsing in Ometa/JS. 
{% codeblock OMeta/JS PNG Parse lang:js https://gist.github.com/sushihangover/8919188 %}
ometa BinaryParser <: Parser {
    // Portable Network Graphics (PNG) Specification (Second Edition)
    // http://www.w3.org/TR/PNG/
    // Note: not all chunk are defined, this is just a POC
    //entire PNG stream
    START  = [header:h (chunk+):c number*:n] -> [h,c,n],
   
    //chunk definition
    chunk  = int4:len str4:t apply(t,len):d byte4:crc
        -> [#chunk, [#type, t], [#length, len], [#data, d], [#crc, crc]],
   
    //chunk types
    IHDR :len  = int4:w int4:h byte:dep byte:type byte:comp byte:filter byte:inter
        -> {type:"IHDR", data:{width:w, height:h, bitdepth:dep, colortype:type, compression:comp, filter:filter, interlace:inter}},
    gAMA :len  = int4:g                  -> {type:"gAMA", value:g},
    pHYs :len  = int4:x int4:y byte:u    -> {type:"pHYs", x:x, y:y, units:u},
    tEXt :len  = repeat('byte',len):d    -> {type:"tEXt", data:toAscii(d)},
    iTXt :len  = repeat('byte',len):d    -> {type:"iTXt", data:toShortAscii(d)},
    tIME :len  = int2:y byte:mo byte:day byte:hr byte:min byte:sec
        -> {type:"tIME", year:y, month:mo, day:day, hour:hr, minute:min, second:sec},
    IDAT :len  = repeat('byte',len):d    -> {type:"IDAT", data:"omitted"},
    IEND :len  = repeat('byte',len):d    -> {type:"IEND"},
   
    //useful definitions
    byte    = number,
    header  = 137 80 78 71 13 10 26 10    -> "PNG HEADER",        //mandatory header
    int2    = byte:a byte:b               -> byteArrayToInt16([b,a]),  //2 bytes to a 16bit integer
    int4    = byte:a byte:b byte:c byte:d -> byteArrayToInt32([d,c,b,a]), //4 bytes to 32bit integer
    str4    = byte:a byte:b byte:c byte:d -> toChunkType([a,b,c,d]),  //4 byte string
    byte4   = repeat('byte',4):d -> d,
    END
}
BinaryParser.repeat = function(rule, count) {
  var ret = [];
  for(var i=0; i<count; i++) { 
     ret.push(this._apply(rule));
  }
  return ret;
}
toAscii = function(byteArray) {
  var foo = String.fromCharCode.apply(String, byteArray);
  console.log ("String:" + foo + " (...byteArrayOmitted...)");
  return foo;
}
toShortAscii = function(byteArray) {
  var embeddedText = String.fromCharCode.apply(String, byteArray);
  // The iTxt chunk can contain a lot of text/xml, so truncate for proof of concept
  console.log ("String:" + embeddedText.slice(1, 51) + " (...only first 50 bytes shown...)");
  return embeddedText;
}
toChunkType = function(byteArray) {
  var aChuckType = String.fromCharCode.apply(String, byteArray);
  console.log ("ChunkType :" + aChuckType + " : " + byteArray );
  return aChuckType;
}
byteArrayToInt32  = function(localByteArray) {
  var uint8array = new Uint8Array(localByteArray);
  var uint32array = new Uint32Array(
                    uint8array.buffer,
                    uint8array.byteOffset + uint8array.byteLength - 4,
                    1 // 4Bytes long
                  );
  var newInt32 = uint32array[0];
  console.log ( "i32 : " + newInt32 + " <= " + localByteArray );
  return newInt32;
}
byteArrayToInt16  = function(byteArray) {
  var ints = [];
  alert(byteArray.length);
  for (var i = 0; i < byteArray.length; i += 2) {
    //ints.push((byteArray[i] << 8) | (byteArray[i+1]));
  }
  console.log (ints);
  return ints;
}
fetchBinary = function() {
    var req = new XMLHttpRequest();
    req.open("GET","http://sushihangover.azurewebsites.net/Content/Static/IronyLogoSmall.png",true);
    req.responseType = "arraybuffer";
    req.onload = function(e) {
        console.log("loaded");
        var buf = req.response;
        if(buf) {
            var byteArray = new Uint8Array(buf);
            console.log("got " + byteArray.byteLength + " bytes");
            var arr = [];
            for(var i=0; i<byteArray.byteLength; i++) {
                arr.push(byteArray[i]);
            }
            // watch out if you uncomment the next line, it can kill your browser w/ large png files
            // console.log(arr);
            var parserResults = BinaryParser.match(arr, "START");
            console.log(parserResults);
        }
    }
    req.send(null);
};
fetchBinary();
{% endcodeblock %}

