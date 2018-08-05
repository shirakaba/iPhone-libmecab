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

NSString *const DEFAULT_JAPANESE_RESOURCES_BUNDLE_NAME_IOS = @"dicdirNaistJdic.bundle";
NSString *const DEFAULT_JAPANESE_RESOURCES_BUNDLE_NAME_MACOS = @"dicdirNaistJdic-macos.bundle";
NSString *const DEFAULT_KOREAN_RESOURCES_BUNDLE_NAME_IOS = @"dicdirKoDic.bundle";
NSString *const DEFAULT_KOREAN_RESOURCES_BUNDLE_NAME_MACOS = @"dicdirKoDic-macos.bundle";

@implementation Mecab

- (NSArray<Node *> *)parseToNodeWithString:(NSString *)string {
    return [self parseToNodeWithString:string dicdirRelativePath:DEFAULT_JAPANESE_RESOURCES_BUNDLE_NAME_IOS];
}

- (NSArray<Node *> *)parseToNodeWithString:(NSString *)string dicdirRelativePath:(NSString *)dicdirRelativePath {
    
    if (mecab == NULL) {
        // https://developer.apple.com/documentation/foundation/bundle
        NSString *path = [[NSBundle mainBundle] resourcePath];
        mecab = mecab_new2([[@"--output-format-type=none --dicdir " stringByAppendingString:[NSString stringWithFormat:@"%@/%@", path, dicdirRelativePath]] UTF8String]);
        
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
    const mecab_node_t *prevNode = NULL;
    Node *oldNode = NULL;
    for (; node->next != NULL; node = node->next) {
        Node *newNode = [Node new];
        newNode.surface = [[[NSString alloc] initWithBytes:node->surface length:node->length encoding:NSUTF8StringEncoding] autorelease];
        newNode.feature = [NSString stringWithCString:node->feature encoding:NSUTF8StringEncoding];
        newNode.leadingWhitespaceLength = node->rlength - node->length;
        if(oldNode != NULL){
            if(newNode.leadingWhitespaceLength > 0 && prevNode != NULL){
                oldNode.trailingWhitespace = [[[[[NSString alloc] initWithBytes:prevNode->surface length:(prevNode->length + newNode.leadingWhitespaceLength) encoding:NSUTF8StringEncoding] autorelease] substringFromIndex:prevNode->length] autorelease];
                // oldNode.trailingWhitespace = [[[NSString alloc] initWithBytes:prevNode->surface length:(prevNode->length + newNode.leadingWhitespaceLength) encoding:NSUTF8StringEncoding] autorelease];
            }
            [oldNode release];
        }
        [newNodes addObject:newNode];
        prevNode = node;
        oldNode = newNode;
        [newNode release];
    }
    if(oldNode != NULL){
        [oldNode release];
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

