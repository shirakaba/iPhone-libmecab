//
//  Mecab.h
//
//  Created by Watanabe Toshinori on 10/12/22.
//  Copyright 2010 FLCL.jp. All rights reserved.
//

//#import "/Users/jamie/Documents/git/iPhone-libmecab/mecab/mecab.h"
#import "mecab.h" // or #import <mecab.h> to use globally installed one
#import <Foundation/Foundation.h> // imported implicitly via mecab_Prefix.pch
#import "Node.h"

extern NSString *const DEFAULT_JAPANESE_RESOURCES_BUNDLE_NAME;
extern NSString *const DEFAULT_KOREAN_RESOURCES_BUNDLE_NAME;

@interface Mecab : NSObject {
    mecab_t *mecab;
}

/** Uses Japanese dictionary by default. */
- (NSArray<Node *> *)parseToNodeWithString:(NSString *)string;

/** Specify the path from the main bundle to the dicdir folder */
- (NSArray<Node *> *)parseToNodeWithString:(NSString *)string dicdirRelativePath:(NSString *)dicdirRelativePath koreanMode:(size_t)koreanMode;

@end

