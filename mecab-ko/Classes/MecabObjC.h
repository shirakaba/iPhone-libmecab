//
//  Mecab.h
//
//  Created by Watanabe Toshinori on 10/12/22.
//  Copyright 2010 FLCL.jp. All rights reserved.
//

//#import "/Users/jamie/Documents/git/iPhone-libmecab/mecab/mecab.h"
#import <mecab_ko/mecab.h> // or #import <mecab.h> to use globally installed one
#import <Foundation/Foundation.h> // imported implicitly via mecab_Prefix.pch
#import "Node.h"

extern NSString *const DEFAULT_JAPANESE_RESOURCES_BUNDLE_NAME_IOS;
extern NSString *const DEFAULT_JAPANESE_RESOURCES_BUNDLE_NAME_MACOS;
extern NSString *const DEFAULT_KOREAN_RESOURCES_BUNDLE_NAME_IOS;
extern NSString *const DEFAULT_KOREAN_RESOURCES_BUNDLE_NAME_MACOS;

@interface Mecab : NSObject {
    mecab_t *mecab;
}

/** Uses Japanese iOS resources bundle by default, and leaves the trailingWhitespace value as NULL. */
- (NSArray<Node *> *)parseToNodeWithString:(NSString *)string;

/** You may specify the path from the main bundle to the dicdir folder. The trailingWhitespace value is left as NULL. */
- (NSArray<Node *> *)parseToNodeWithString:(NSString *)string dicdirRelativePath:(NSString *)dicdirRelativePath;

/** You may specify the path from the main bundle to the dicdir folder. The trailingWhitespace value is calculated where applicable. */
- (NSArray<Node *> *)parseToNodeWithString:(NSString *)string dicdirRelativePath:(NSString *)dicdirRelativePath calculateTrailingWhitespace:(BOOL)calculateTrailingWhitespace;

@end

