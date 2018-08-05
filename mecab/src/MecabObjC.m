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
    return [self parseToNodeWithString:string dicdirRelativePath:DEFAULT_JAPANESE_RESOURCES_BUNDLE_NAME_IOS calculateTrailingWhitespace:NO];
}

- (NSArray<Node *> *)parseToNodeWithString:(NSString *)string dicdirRelativePath:(NSString *)dicdirRelativePath {
    return [self parseToNodeWithString:string dicdirRelativePath:DEFAULT_JAPANESE_RESOURCES_BUNDLE_NAME_IOS calculateTrailingWhitespace:NO];
}

- (NSArray<Node *> *)parseToNodeWithString:(NSString *)string dicdirRelativePath:(NSString *)dicdirRelativePath calculateTrailingWhitespace:(BOOL)calculateTrailingWhitespace {
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
                // NSLog(@"%lu", strlen(node->surface));
                if(newNode.leadingWhitespaceLength > 0 && node->prev != NULL){
                    oldNode.trailingWhitespace = [[[NSString alloc] initWithBytes:(node->prev->surface + node->prev->length) length:newNode.leadingWhitespaceLength encoding:NSUTF8StringEncoding] autorelease];
                }
            }
            [oldNode release];
        }
        /* We calculate the trailingWhitespace on the last node by checking whether the length of node->surface exceeds node->length. */
        if(lastNode && calculateTrailingWhitespace){
            // Don't need to cut off any leadingWhitespace; the surface has been trimmed already. So only need to refer to node->length.
            // "Analyzer": length 8, rlength 9.
            // node->prev->surface + 0 == 'Analyzer'
            // node->prev->surface + 1 == 'nalyzer'
            // node->prev->surface + 7 == 'r'
            // node->prev->surface + 8 == 0x00
            // node->prev->surface + 9 == '\0' Coincidence?
            // const int offset = newNode.leadingWhitespaceLength + node->length;
            const int offset = node->length;
            
            /* The final '\0' is counted for in the rlength value. Should be guaranteed to be there, as our buffer 'buf' is based on a C string. */
            NSString *trailingWhitespace = [[[NSString alloc] initWithBytes:(node->surface + offset) length:strlen(node->surface) - offset encoding:NSUTF8StringEncoding] autorelease];
            if(trailingWhitespace.length > 0){
                newNode.trailingWhitespace = trailingWhitespace;
            }
            // Only apply if trailingWhitespace has more than 0 length.
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

