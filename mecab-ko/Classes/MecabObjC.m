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

NSString *const DEFAULT_JAPANESE_RESOURCES_BUNDLE_NAME_IOS = @"mecab-naist-jdic-utf-8.bundle";
NSString *const DEFAULT_JAPANESE_RESOURCES_BUNDLE_NAME_MACOS = @"mecab-naist-jdic-utf-8.bundle";
NSString *const DEFAULT_KOREAN_RESOURCES_BUNDLE_NAME_IOS = @"mecab-ko-dic-utf-8.bundle";
NSString *const DEFAULT_KOREAN_RESOURCES_BUNDLE_NAME_MACOS = @"mecab-ko-dic-utf-8.bundle";

@implementation Mecab

// - (NSArray<Node *> *)parseToNodeWithString:(NSString *)string {
//     return [self parseToNodeWithString:string dicdirPath:DEFAULT_JAPANESE_RESOURCES_BUNDLE_NAME_IOS calculateTrailingWhitespace:NO];
// }

- (NSArray<Node *> *)parseToNodeWithString:(NSString *)string dicdirPath:(NSString *)dicdirPath {
    return [self parseToNodeWithString:string dicdirPath:dicdirPath calculateTrailingWhitespace:NO];
}

- (NSArray<Node *> *)parseToNodeWithString:(NSString *)string dicdirPath:(NSString *)dicdirPath calculateTrailingWhitespace:(BOOL)calculateTrailingWhitespace {
    if (mecab == NULL) {
        mecab = mecab_new2([[@"--output-format-type=none --dicdir " stringByAppendingString:[NSString stringWithFormat:@"%@", dicdirPath]] UTF8String]);
        
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
    Node *oldNode = NULL;
    for (; node->next != NULL; node = node->next) {
        BOOL firstNode = (node->prev == NULL) || (node->prev->prev == NULL);
        BOOL lastNode = (node->next == NULL) || (node->next->next == NULL);
        Node *newNode = [Node new];
        /* Note: this method will not identify whitespace at the start of input text. MeCab always trims leading whitespace from each node's surface (although does acknowledge the increased rlength), so we'd have to compare the original string's length to node->length. */
        newNode.surface = [[[NSString alloc] initWithBytes:node->surface length:node->length encoding:NSUTF8StringEncoding] autorelease];
        newNode.feature = [NSString stringWithCString:node->feature encoding:NSUTF8StringEncoding];
        newNode.leadingWhitespaceLength = node->rlength - node->length;
        if(oldNode != NULL){
            if(calculateTrailingWhitespace){
                if(newNode.leadingWhitespaceLength > 0 && node->prev != NULL){
                    oldNode.trailingWhitespace = [[[NSString alloc] initWithBytes:(node->prev->surface + node->prev->length) length:newNode.leadingWhitespaceLength encoding:NSUTF8StringEncoding] autorelease];
                }
            }
            [oldNode release];
        }
        /* We calculate the trailingWhitespace on the last node by checking whether the length of node->surface exceeds node->length. */
        if(calculateTrailingWhitespace && lastNode){
            // Don't need to cut off any leadingWhitespace; the surface has been trimmed already. So only need to refer to node->length.
            NSString *trailingWhitespace = [[[NSString alloc] initWithBytes:node->surface + node->length length:strlen(node->surface) - node->length encoding:NSUTF8StringEncoding] autorelease];
            if(trailingWhitespace.length > 0){
                newNode.trailingWhitespace = trailingWhitespace;
            }
        }
        [newNodes addObject:newNode];
        oldNode = newNode;
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

