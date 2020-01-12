# Japanese Morphological Analyzer Mecab on iOS and macOS

This is a project that enables `mecab-ko` (a fork of Mecab that adds support for Korean) to be easily integrated into an iOS or macOS app.

Updated to work with Xcode 11, iOS 9+, macOS 10.11+, and Swift 5.

## Sample app

The sample app in LibMecabSample should build both an iOS Obj-C app (with a UI) and a macOS Swift app (without any UI; check the console for results).

<table>
    <tbody>
        <tr>
            <td align="center" valign="middle">
                <img width="400px" src="/github_img/ios_sample_jp.png"/>
            </td>
            <td align="center" valign="middle">
                <img width="400px" src="/github_img/ios_sample_ko.png"/>
            </td>
        </tr>
        <tr>
            <td align="center" valign="middle">
                <p><b>Japanese</b></p>
            </td>
            <td align="center" valign="middle">
                <p><b>Korean</b></p>
            </td>
        </tr>
    </tbody>
</table>

## Installing from Cocoapods

Specify these pods in your `Podfile` (you can omit the Japanese or Korean dictionary if you only plan to use Mecab with one of the two languages):

```ruby
# Fork of Mecab supporting both Japanese and Korean
pod 'mecab-ko'

# Japanese dictionary
pod 'mecab-naist-jdic-utf-8'

# Korean dictionary
pod 'mecab-ko-dic-utf-8'
```

```sh
pod update
```

## Installing as a Cocoapod from `npm` (for React Native iOS apps)

Add these npm packages (you can omit the Japanese or Korean dictionary if you only plan to use Mecab with one of the two languages):

```sh
yarn add mecab-ko mecab-naist-jdic-utf-8 mecab-ko-dic-utf-8

# or:

npm install --save mecab-ko mecab-naist-jdic-utf-8 mecab-ko-dic-utf-8
```

Next, specify these pods in your `Podfile` (you can omit the Japanese or Korean dictionary if you only plan to use Mecab with one of the two languages):

```ruby
# Fork of Mecab supporting both Japanese and Korean
pod 'mecab-ko', :podspec => '../node_modules/mecab-ko/mecab-ko.podspec'

# Japanese dictionary
pod 'mecab-naist-jdic-utf-8', :podspec => '../node_modules/mecab-naist-jdic-utf-8/mecab-naist-jdic-utf-8.podspec'

# Korean dictionary
pod 'mecab-ko-dic-utf-8', :podspec => '../node_modules/mecab-ko-dic-utf-8/mecab-ko-dic-utf-8.podspec'
```

Don't forget to install the pods.

```sh
cd ios
pod update
```

## Usage

Import the necessary `mecab_ko` headers into your class. Allocate and initialize a new Mecab object (specifying whether to use the Japanese or Korean dictionary via the `DEFAULT_JAPANESE_RESOURCES_BUNDLE_NAME` or `DEFAULT_KOREAN_RESOURCES_BUNDLE_NAME` constants) and then supply it a string to parse via the `parseToNodeWithString` method. It'll return an array of nodes that you can then manipulate as needed:

### Swift invocation

```swift
import mecab_ko

// ...

let jpBundlePath = Bundle.main.path(forResource: DEFAULT_JAPANESE_RESOURCES_BUNDLE_NAME, ofType: "bundle")
let jpBundleResourcePath = Bundle.init(path: jpBundlePath!)!.resourcePath

let mecabJapanese: Mecab = Mecab.init(dicDirPath: jpBundleResourcePath!)
let japaneseNodes: [MecabNode]? = mecabJapanese.parseToNode(with: "すもももももももものうち")
japaneseNodes?.forEach({ node in print("[\(node.surface)] \(node.partOfSpeech ?? "*") \(node.originalForm ?? "*")") })
```

### Obj-C invocation

```objc
#import <mecab_ko/MecabObjC.h>
#import <mecab_ko/MecabNode.h>

// ...

NSString *jpDicBundlePath = [[NSBundle mainBundle] pathForResource:DEFAULT_JAPANESE_RESOURCES_BUNDLE_NAME ofType:@"bundle"];
NSString *jpDicBundleResourcePath = [[NSBundle alloc] initWithPath:jpDicBundlePath].resourcePath;

self.mecab = [[Mecab alloc] initWithDicDirPath:jpDicBundleResourcePath];
NSArray<MecabNode *> results = [mecab parseToNodeWithString:@"すもももももももものうち"];
```

This would give you the following result:

```
すもも: 名詞,一般,*,*,*,*,すもも,スモモ,スモモ  
も: 助詞,係助詞,*,*,*,*,も,モ,モ  
もも: 名詞,一般,*,*,*,*,もも,モモ,モモ  
も: 助詞,係助詞,*,*,*,*,も,モ,モ  
もも: 名詞,一般,*,*,*,*,もも,モモ,モモ  
の: 助詞,連体化,*,*,*,*,の,ノ,ノ  
うち: 名詞,非自立,副詞可能,*,*,*,うち,ウチ,ウチ
```

If you're planning to use this to present results to users, you'll probably need to write quite a bit of parsing code to put the nodes back together in a useful way since the nodes will be broken down into the smallest possible pieces.

A few examples:

欲しがっていた  
```
欲し: 形容詞,自立,*,*,形容詞・イ段,ガル接続,欲しい,ホシ,ホシ  
がっ: 動詞,接尾,*,*,五段・ラ行,連用タ接続,がる,ガッ,ガッ  
て: 助詞,接続助詞,*,*,*,*,て,テ,テ  
い: 動詞,非自立,*,*,一段,連用形,いる,イ,イ  
た: 助動詞,*,*,*,特殊・タ,基本形,た,タ,タ  
```

通ったんだろうな  
```
通っ: 動詞,自立,*,*,五段・ラ行,連用タ接続,通る,トオッ,トーッ  
た: 助動詞,*,*,*,特殊・タ,基本形,た,タ,タ  
ん: 名詞,非自立,一般,*,*,*,ん,ン,ン  
だろ: 助動詞,*,*,*,特殊・ダ,未然形,だ,ダロ,ダロ  
う: 助動詞,*,*,*,不変化型,基本形,う,ウ,ウ  
な: 助詞,終助詞,*,*,*,*,な,ナ,ナ  
```

光らせておくように  
```
光らせ: 動詞,自立,*,*,一段,連用形,光らせる,ヒカラセ,ヒカラセ  
て: 助詞,接続助詞,*,*,*,*,て,テ,テ  
おく: 動詞,非自立,*,*,五段・カ行イ音便,基本形,おく,オク,オク  
よう: 名詞,非自立,助動詞語幹,*,*,*,よう,ヨウ,ヨー  
に: 助詞,副詞化,*,*,*,*,に,ニ,ニ  
```

## License

### `iPhone-libmecab`

Feel free to use this sample project under the terms of the licenses inherited from `mecab-ko`.

### `mecab-ko`

`mecab-ko` is free software; I can only specify one license in the metadata for the Cocoapods `mecab-ko.podspec` and npm `package.json`, so I have specified BSD, but it can be used under the GPL, LGPL, and/or BSD licenses; please feel free to do so despite the limitations of what I can write into the metadata.

For details, please check the `COPYING`, `GPL`, `LGPL`, and `BSD` files in `mecab-ko/Assets`.

### `mecab-ko-dic-utf-8`

`mecab-ko-dic-utf-8` is available only under the Apache 2.0 licence: `mecab-ko-dic-utf-8/bundleContents/COPYING`.

### `mecab-naist-jdic-utf-8`

`mecab-naist-jdic-utf-8` is available only under the BSD licence: `mecab-naist-jdic-utf-8/bundleContents/COPYING`.

## Contributors

This repository has had a long history (9 years?), being contributed to by (to my knowledge):

* Toshinori Watanabe (link to fork now broken, but was re-hosted at some point by Richard North [here](https://github.com/rnorth/iPhone-libmecab))
* Matthew Long (fork [here](https://github.com/lxmmxl56/iPhone-libmecab))
* Jamie Birch (the [current fork](https://github.com/shirakaba/iPhone-libmecab))

Special thank you to Joseph Toronto on StackOverflow for assisting both Matthew Long and myself by providing [setup steps](http://stackoverflow.com/a/37891729/3295398).

## Acknowledgments

This repository is based on:

[Mecab](http://taku910.github.io/mecab/)  
[iPhone-libmecab](https://github.com/FLCLjp/iPhone-libmecab/)


## See also

* https://github.com/shirakaba/mecab-ko
* https://github.com/shirakaba/mecab-ko-dic-utf-8
* https://github.com/shirakaba/mecab-naist-jdic-utf-8
* Mecab for Japanese, Korean, and Chinese: https://github.com/junhewk/RcppMeCab