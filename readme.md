# Japanese and Korean Morphological Analyzer Mecab on iOS and macOS

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

This would give you an array of nodes with the following raw metadata:

```
すもも: 名詞,一般,*,*,*,*,すもも,スモモ,スモモ  
も: 助詞,係助詞,*,*,*,*,も,モ,モ  
もも: 名詞,一般,*,*,*,*,もも,モモ,モモ  
も: 助詞,係助詞,*,*,*,*,も,モ,モ  
もも: 名詞,一般,*,*,*,*,もも,モモ,モモ  
の: 助詞,連体化,*,*,*,*,の,ノ,ノ  
うち: 名詞,非自立,副詞可能,*,*,*,うち,ウチ,ウチ
```

You can access each piece of metadata by getting the full comma-separated feature string `node.feature` or indexing into the pre-processed features array, `node.features`.

```objc
@interface MecabNode : NSObject {
    /* What text the node consists of. */
    NSString *surface;

    /* The raw comma-separated string of metadata about the node. */
    NSString *feature;

    /* All the comma-separated features converted into an array, for 
     * direct access. */
    NSArray<NSString *> *features;

    /* The leading whitespace in front of this node (strictly 0 for the
     * first node, as Mecab always trims whitespace at the start of input
     * text). */
    int leadingWhitespaceLength;

    /* Trailing whitespace is only calculated if passing YES into
     * calculateTrailingWhitespace when calling this method on the mecab
     * instance:
     * 
     * - (NSArray<MecabNode *> *)parseToNodeWithString:(NSString *)string calculateTrailingWhitespace:(BOOL)calculateTrailingWhitespace;
     *
     */
    NSString *trailingWhitespace;
}
```

### Examples

#### Japanese
##### Feature schema

It's based on IPADIC, and the tags are fully documented here https://osdn.net/projects/ipadic/docs ([English manual](https://osdn.net/projects/ipadic/docs/ipadic-2.7.0-manual-en.pdf/en/1/ipadic-2.7.0-manual-en.pdf.pdf)):

| index | role (Japanese)  | role (English) |
| ------|------------|------------------------- |
| 0     | 品詞       | part-of-speech |
| 1     | 品詞細分類1 | part-of-speech subtype 1 |
| 2     | 品詞細分類2 | part-of-speech subtype 2 |
| 3     | 品詞細分類3 | part-of-speech subtype 3 |
| 4     | 活用形     | inflected form |
| 5     | 活用型     | inflection type |
| 6     | 原形       | original form |
| 7     | 読み       | reading |
| 8     | 発音       | pronunciation |

##### Example feature strings

> 欲しがっていた

```
欲し: 形容詞,自立,*,*,形容詞・イ段,ガル接続,欲しい,ホシ,ホシ  
がっ: 動詞,接尾,*,*,五段・ラ行,連用タ接続,がる,ガッ,ガッ  
て: 助詞,接続助詞,*,*,*,*,て,テ,テ  
い: 動詞,非自立,*,*,一段,連用形,いる,イ,イ  
た: 助動詞,*,*,*,特殊・タ,基本形,た,タ,タ  
```

> 通ったんだろうな

```
通っ: 動詞,自立,*,*,五段・ラ行,連用タ接続,通る,トオッ,トーッ  
た: 助動詞,*,*,*,特殊・タ,基本形,た,タ,タ  
ん: 名詞,非自立,一般,*,*,*,ん,ン,ン  
だろ: 助動詞,*,*,*,特殊・ダ,未然形,だ,ダロ,ダロ  
う: 助動詞,*,*,*,不変化型,基本形,う,ウ,ウ  
な: 助詞,終助詞,*,*,*,*,な,ナ,ナ  
```

> 光らせておくように

```
光らせ: 動詞,自立,*,*,一段,連用形,光らせる,ヒカラセ,ヒカラセ  
て: 助詞,接続助詞,*,*,*,*,て,テ,テ  
おく: 動詞,非自立,*,*,五段・カ行イ音便,基本形,おく,オク,オク  
よう: 名詞,非自立,助動詞語幹,*,*,*,よう,ヨウ,ヨー  
に: 助詞,副詞化,*,*,*,*,に,ニ,ニ  
```

#### Korean
##### Feature schema

Information about the dictionary format and part-of-speech tags used by mecab-ko-dic is documented in [this Google Spreadsheet](https://docs.google.com/spreadsheet/ccc?key=0ApcJghR6UMXxdEdURGY2YzIwb3dSZ290RFpSaUkzZ0E&usp=sharing), linked to from `mecab-ko-dic`'s [repo readme](https://bitbucket.org/eunjeon/mecab-ko-dic/src/master/README.md).

Note how ko-dic has one less feature column than NAIST JDIC, and has an altogether different set of information (e.g.  doesn't provide the "original form" of the word).

The tags are a slight modification of those specified by 세종 (Sejong), whatever that is. The mappings from Sejong to mecab-ko-dic's tag names are given in tab "태그 v2.0" on the above-linked spreadsheet.

The dictionary format is specified fully (in Korean) in tab "사전 형식 v2.0" of the spreadsheet. Any blank values default to `*`.

| index | role (Korean)  | role (English) | notes |
| ------|------------|-------------------------| - |
| 0     | 품사 태그    | part-of-speech tag      | See "태그 v2.0" tab on spreadsheet  |
| 1     | 의미 부류    | meaning                 | (too few examples for me to be sure) |
| 2     | 종성 유무    | presence or absence | `T` for true; `F` for false; else `*` |
| 3     | 읽기 | reading | usually matches surface, but may differ for foreign words e.g. Chinese character words |
| 4     | 타입     | type | One of: `Inflect` (활용); `Compound` (복합명사); or `Preanalysis` (기분석) |
| 5     | 첫번째 품사     | first part-of-speech | e.g. given a part-of-speech tag of "VV+EM+VX+EP", would return `VV` |
| 6     | 마지막 품사       | last part-of-speech | e.g. given a part-of-speech tag of "VV+EM+VX+EP", would return `EP` |
| 7     | 표현       | expression | "활용, 복합명사, 기분석이 어떻게 구성되는지 알려주는 필드" – Fields that tell how usage, compound nouns, and key analysis are organized |

##### Example feature strings

> mecab-ko-dic은 MeCab을 사용하여, 한국어 형태소 분석을 하기 위한 프로젝트입니다.

```
mecab    SL,*,*,*,*,*,*,*
-    SY,*,*,*,*,*,*,*
ko    SL,*,*,*,*,*,*,*
-    SY,*,*,*,*,*,*,*
dic    SL,*,*,*,*,*,*,*
은    JX,*,T,은,*,*,*,*
MeCab    SL,*,*,*,*,*,*,*
을    JKO,*,T,을,*,*,*,*
사용    NNG,행위,T,사용,*,*,*,*
하    XSV,*,F,하,*,*,*,*
여    EC,*,F,여,*,*,*,*
,    SC,*,*,*,*,*,*,*
한국어    NNG,*,F,한국어,Compound,*,*,한국/NNG/*+어/NNG/*
형태소    NNG,*,F,형태소,Compound,*,*,형태/NNG/*+소/NNG/*
분석    NNG,행위,T,분석,*,*,*,*
을    JKO,*,T,을,*,*,*,*
하    VV,*,F,하,*,*,*,*
기    ETN,*,F,기,*,*,*,*
위한    VV+ETM,*,T,위한,Inflect,VV,ETM,위하/VV/*+ᆫ/ETM/*
프로젝트    NNG,*,F,프로젝트,*,*,*,*
입니다    VCP+EF,*,F,입니다,Inflect,VCP,EF,이/VCP/*+ᄇ니다/EF/*
.    SF,*,*,*,*,*,*,*
EOS
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
* Overview of Japanese tokenizer dictionaries: https://www.dampfkraft.com/nlp/japanese-tokenizer-dictionaries.html