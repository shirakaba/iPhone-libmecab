//
//  MecabNode.h
//
//  Created by Watanabe Toshinori on 10/12/22 (originally as "Node.h").
//  Copyright 2010 FLCL.jp. All rights reserved.
//

#import <Foundation/Foundation.h> // imported implicitly via mecab_Prefix.pch

//#import "/Users/jamie/Documents/git/iPhone-libmecab/mecab/mecab.h"
#import "mecab.h" // or #import <mecab.h> to use globally installed one

@interface MecabNode : NSObject {
    NSString *feature;
    NSArray<NSString *> *features;
    int leadingWhitespaceLength;
    NSString *trailingWhitespace;
    
    NSString *surface; // provided in original implementation
    NSString *partOfSpeech;
    NSString *partOfSpeechSubtype1;
    NSString *partOfSpeechSubtype2;
    NSString *partOfSpeechSubtype3;
    NSString *inflection;
    NSString *useOfType;
    NSString *originalForm;
    NSString *reading;
    NSString *pronunciation;
}

// These are assigned pre-emptively to MecabNode, pulled out of the mecab node.
@property (nonatomic, retain, nullable) NSString *feature;
@property (nonatomic, retain, nullable) NSArray<NSString *> *features;
@property (nonatomic, retain, nullable) NSString *trailingWhitespace;
@property (nonatomic) int leadingWhitespaceLength;

// These are getters (calculated only when called).
@property (nonatomic, retain, nonnull) NSString *surface; // provided in original implementation
@property (nonatomic, retain, nullable) NSString *partOfSpeech;
@property (nonatomic, retain, nullable) NSString *partOfSpeechSubtype1;
@property (nonatomic, retain, nullable) NSString *partOfSpeechSubtype2;
@property (nonatomic, retain, nullable) NSString *partOfSpeechSubtype3;
@property (nonatomic, retain, nullable) NSString *inflection;
@property (nonatomic, retain, nullable) NSString *useOfType;
@property (nonatomic, retain, nullable) NSString *originalForm;
@property (nonatomic, retain, nullable) NSString *reading;
@property (nonatomic, retain, nullable) NSString *pronunciation;

// 品詞
- (nullable NSString *)partOfSpeech;
// 品詞細分類1
- (nullable NSString *)partOfSpeechSubtype1;
// 品詞細分類2
- (nullable NSString *)partOfSpeechSubtype2;
// 品詞細分類3
- (nullable NSString *)partOfSpeechSubtype3;
// 活用形
- (nullable NSString *)inflection;
// 活用型
- (nullable NSString *)useOfType;
// 原形
- (nullable NSString *)originalForm;
// 読み
- (nullable NSString *)reading;
// 発音
- (nullable NSString *)pronunciation;

- (int)leadingWhitespaceLength;

- (nullable NSString *)trailingWhitespace;

@end

