//
//  Mecab.m
//
//  Created by Watanabe Toshinori on 10/12/22.
//  Copyright 2010 FLCL.jp. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iconv.h>
#import "MecabObjC.h"



@implementation MecabObjC

- (NSArray<Node *> *)parseToNodeWithString:(NSString *)string {
    
    if (mecab == NULL) {
        // resourcepath is the path to the folder holding your dictionaries directory. This might be the Resources group in XCode, but I'm not sure.
        // see http://stackoverflow.com/questions/6263289/accesing-a-file-using-nsbundle-mainbundle-pathforresource-oftypeindirectory
        // http://stackoverflow.com/a/18141528/5951226
        // http://stackoverflow.com/a/3495426/5951226
        NSString *path = [[NSBundle mainBundle] resourcePath];
        // -d is the flag to link the dictionary:  https://fasiha.github.io/mecab-emscripten/
        mecab = mecab_new2([[@"-d " stringByAppendingString:path] UTF8String]);
        
        if (mecab == NULL) {
            fprintf(stderr, "error in mecab_new2: %s\n", mecab_strerror(NULL));
            
            return nil;
        }
    }
    
    const mecab_node_t *node;
    const char *buf= [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSUInteger l= [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    
    node = mecab_sparse_tonode2(mecab, buf, l);
    if (node == NULL) {
        fprintf(stderr, "error\n");
        
        return nil;
    }
    
    NSMutableArray<Node *> *newNodes = [NSMutableArray<Node *> array];
    node = node->next;
    for (; node->next != NULL; node = node->next) {
        
        Node *newNode = [Node new];
        newNode.surface = [[[NSString alloc] initWithBytes:node->surface length:node->length encoding:NSUTF8StringEncoding] autorelease];
        newNode.feature = [NSString stringWithCString:node->feature encoding:NSUTF8StringEncoding];
        [newNodes addObject:newNode];
        [newNode release];
    }
    
    return [NSArray<Node *> arrayWithArray:newNodes];
}

- (void)dealloc {
    if (mecab != NULL) {
        mecab_destroy(mecab);
    }
    
    [super dealloc];
}

@end

