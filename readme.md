# Japanese Morphological Analyzer Mecab on iPhone（Cocoa Static Library Version）

This is an application that integrates Mecab and allows it to be used on iOS.  
Mecab is built as a Cocoa Touch Static Libarary.  
Updated to work with Xcode 7 and iOS 9.

## Building

The sample app in LibMecabSample should build and run as configured in both 
the simulator and on devices.

## Implementing

You can implement Mecab from this repo into your own app using the following steps:

1.  Manually copy the `mecab` folder over to your project folder. Select `Add Files to "yourProject"...` from the Xcode menu and choose the `mecab.xcodeproj` in the mecab folder you copied over.  The project along with it's subfolders and all required classes will be added to your project tree.

2.  Drag the `Mecab.h`, `Mecab.m`, `Node.h`, and `Node.m` files from the `LibMecabSample` folder into your project, making sure to select `Copy items if needed`.

3.  Still in the LibMecabSample folder, drag the `ipadic` folder into your project; I recommend dragging it into the `Supporting Files` group to make sure it goes into your main bundle where mecab can find it.  Again, be sure to select `Copy items if needed`.

4. Go into your project's `Build Phases`, look under `Compile Sources` and add `-fno-objc-arc` to `Compiler Flags` for both Mecab.h and Node.h.

5.  Still in `Build Phases`, ensure that the following are added in `Link Binary With Libraries`:

 * libmecab.a (this is listed under the 'Workspace' folder)
 * libiconv.tbd (this may be listed under 'iOS 11.2' or a similar folder)
 * libstdc++.tbd (this may be listed under 'iOS 11.2' or a similar folder)

6. Under "Header Search Paths" in `Build Settings` add `mecab`.

7. Clean and build.

Special thanks to [Joseph Toronto on Stack Overflow](http://stackoverflow.com/a/37891729/3295398) for coming up with these steps.

## Usage

### By modifying the current project

Import `"Mecab.h"` into your class. Allocate and initialize a new Mecab object and then supply it a string to parse via the `parseToNodeWithString` method.  It'll return an array of nodes that you can then manipulate as needed:

<pre>
Mecab *mecab = [[Mecab alloc] init];  
NSArray *results = [mecab parseToNodeWithString:@"すもももももももものうち"];
</pre>

This would give you the following result:

<pre>
すもも: 名詞,一般,*,*,*,*,すもも,スモモ,スモモ  
も: 助詞,係助詞,*,*,*,*,も,モ,モ  
もも: 名詞,一般,*,*,*,*,もも,モモ,モモ  
も: 助詞,係助詞,*,*,*,*,も,モ,モ  
もも: 名詞,一般,*,*,*,*,もも,モモ,モモ  
の: 助詞,連体化,*,*,*,*,の,ノ,ノ  
うち: 名詞,非自立,副詞可能,*,*,*,うち,ウチ,ウチ
</pre>

If you're planning to use this to present results to users, you'll probably need to write quite a bit of parsing code to put the nodes back together in a useful way since the nodes will be broken down into the smallest possible pieces.

A few examples:

欲しがっていた  
<pre>
欲し: 形容詞,自立,*,*,形容詞・イ段,ガル接続,欲しい,ホシ,ホシ  
がっ: 動詞,接尾,*,*,五段・ラ行,連用タ接続,がる,ガッ,ガッ  
て: 助詞,接続助詞,*,*,*,*,て,テ,テ  
い: 動詞,非自立,*,*,一段,連用形,いる,イ,イ  
た: 助動詞,*,*,*,特殊・タ,基本形,た,タ,タ  
</pre>

通ったんだろうな  
<pre>
通っ: 動詞,自立,*,*,五段・ラ行,連用タ接続,通る,トオッ,トーッ  
た: 助動詞,*,*,*,特殊・タ,基本形,た,タ,タ  
ん: 名詞,非自立,一般,*,*,*,ん,ン,ン  
だろ: 助動詞,*,*,*,特殊・ダ,未然形,だ,ダロ,ダロ  
う: 助動詞,*,*,*,不変化型,基本形,う,ウ,ウ  
な: 助詞,終助詞,*,*,*,*,な,ナ,ナ  
</pre>

光らせておくように  
<pre>
光らせ: 動詞,自立,*,*,一段,連用形,光らせる,ヒカラセ,ヒカラセ  
て: 助詞,接続助詞,*,*,*,*,て,テ,テ  
おく: 動詞,非自立,*,*,五段・カ行イ音便,基本形,おく,オク,オク  
よう: 名詞,非自立,助動詞語幹,*,*,*,よう,ヨウ,ヨー  
に: 助詞,副詞化,*,*,*,*,に,ニ,ニ  
</pre>

### By incorporating into your own project

1. In your own project's root directory (where I also assume your `.git` lives), run:

```bash
# Add a submodule tracking the 'master' branch (or alternatively the 'korean' branch)
git submodule add -b master git@github.com:shirakaba/iPhone-libmecab.git
    
# Update your submodule from the remote.
git submodule update --remote
```

2. Open your own project's `.xcodeproj` or `.xcworkspace` instead if you have one. Add `mecab.xcodeproj` to it.

3. In your own project's `.xcodeproj`/`.xcworkspace` file, choose your target (the app you're making) from the TARGETS column, then click the 'Build Phases' tab. In there, add the `mecabResources` bundle to Target Dependencies.

4. Still in the 'Build Phases' tab, press the `+` button to add another build phase, called either 'Copy Files' or 'Embed Frameworks'. In this build phase, add the `mecabResources` bundle.

5. Next, in the 'General' tab, add the `mecabResources` bundle to the `Embedded Binaries` list.

6. Back in `Build Phases`, ensure that the following are added in `Link Binary With Libraries`:

 * libmecab.a (this is listed under the 'Workspace' folder)
 * libiconv.tbd (this may be listed under 'iOS 11.2' or a similar folder)
 * libstdc++.tbd (this may be listed under 'iOS 11.2' or a similar folder)

7. In any Swift file in your project, add the line:

```Swift
let mecab: Mecab = Mecab()
let nodes: [Node] = mecab.parseToNode(with: input)
```
    
8. If Xcode has succeeded in indexing, you should be able to Cmd-click on 'Node' and test out 'Jump to definition', which will take you to `Node.h`.

9. In your target's Build Settings tab, set `Objective-C Bridging Header` to a path that picks up the bridging header. For me, this was simply: `IPhone-libmecab/mecab/src/mecab-Bridging-Header.h`. If it fails to find this file upon running, then carefully compare the path that it looked with (in the error message) with the path that it should be navigating to.

## License

Mecab is free software and can be used under the GPL, LGPL, and/or BSD licenses.
For details, please check the COPYING, GPL, LGPL, and BSD files included with Mecab.
Feel free to use this repository under the terms of the licenses inherited from Mecab.

## Acknowledgments

This repository is based on:

[Mecab](http://taku910.github.io/mecab/)  
[iPhone-libmecab](https://github.com/FLCLjp/iPhone-libmecab/)
