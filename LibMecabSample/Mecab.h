//
//  Mecab.h
//
//  Created by Watanabe Toshinori on 10/12/22.
//  Copyright 2010 FLCL.jp. All rights reserved.
//

//#import "/Users/jamie/Documents/git/iPhone-libmecab/mecab/mecab.h"
#import "../mecab/mecab.h" // or #import <mecab.h> to use globally installed one
#import <UIKit/UIKit.h>
#import "Node.h"


@interface Mecab : NSObject {
	mecab_t *mecab;
}

- (NSArray<Node *> *)parseToNodeWithString:(NSString *)string;

@end
