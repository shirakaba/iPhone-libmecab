//
//  MecabObjC.h
//
//  Created by Watanabe Toshinori on 10/12/22 (originally as "Mecab.h").
//  Copyright 2010 FLCL.jp. All rights reserved.
//

//#import "/Users/jamie/Documents/git/iPhone-libmecab/mecab/mecab.h"
#import <mecab_ko/mecab.h> // or #import <mecab.h> to use globally installed one
#import <Foundation/Foundation.h> // imported implicitly via mecab_Prefix.pch
#import "MecabNode.h"

extern NSString *const DEFAULT_JAPANESE_RESOURCES_BUNDLE_NAME;
extern NSString *const DEFAULT_KOREAN_RESOURCES_BUNDLE_NAME;

@interface Mecab : NSObject {
    mecab_t *mecab;
}

+ (instancetype)mecabWithDicDirPath:(NSString *)dicDirPath;

/** You must specify the absolute path to the dicdir folder.*/
- (instancetype)initWithDicDirPath:(NSString *)dicDirPath;

/** The trailingWhitespace value is left as NULL. */
- (NSArray<MecabNode *> *)parseToNodeWithString:(NSString *)string;

/** The trailingWhitespace value is calculated where applicable. */
- (NSArray<MecabNode *> *)parseToNodeWithString:(NSString *)string calculateTrailingWhitespace:(BOOL)calculateTrailingWhitespace;

@end

