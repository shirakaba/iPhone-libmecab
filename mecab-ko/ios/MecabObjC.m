//
//  MecabObjC.m
//
//  Created by Watanabe Toshinori on 10/12/22 (originally as "Mecab.m").
//  Copyright 2010 FLCL.jp. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iconv.h>
#import "MecabObjC.h"

NSString *const DEFAULT_JAPANESE_RESOURCES_BUNDLE_NAME = @"mecab-naist-jdic-utf-8";
NSString *const DEFAULT_KOREAN_RESOURCES_BUNDLE_NAME = @"mecab-ko-dic-utf-8";

@implementation Mecab

+ (instancetype)mecabWithDicDirPath:(NSString *)dicDirPath
{
    return [[self alloc] initWithDicDirPath:dicDirPath];
}

- (instancetype)initWithDicDirPath:(NSString *)dicDirPath
{
    if(self = [super init])
    {
        mecab = mecab_new2([[@"--output-format-type=none --dicdir " stringByAppendingString:[NSString stringWithFormat:@"%@", dicDirPath]] UTF8String]);
        if (mecab == NULL) {
            fprintf(stderr, "error in mecab_new2: %s\n", mecab_strerror(NULL));
            
            return nil;
        }
    }
    return self;
}

- (NSArray<MecabNode *> *)parseToNodeWithString:(NSString *)string {
    return [self parseToNodeWithString:string calculateTrailingWhitespace:NO];
}

- (NSArray<MecabNode *> *)parseToNodeWithString:(NSString *)string calculateTrailingWhitespace:(BOOL)calculateTrailingWhitespace {    
    const mecab_node_t *node;
    const char *buf= [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSUInteger l= [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    
    node = mecab_sparse_tonode2(mecab, buf, l);
    if (node == NULL) {
        fprintf(stderr, "error\n");
        
        return nil;
    }
    
    NSMutableArray<MecabNode *> *newNodes = [NSMutableArray<MecabNode *> array];
    node = node->next;
    MecabNode *oldNode = NULL;
    for (; node->next != NULL; node = node->next) {
        BOOL firstNode = (node->prev == NULL) || (node->prev->prev == NULL);
        BOOL lastNode = (node->next == NULL) || (node->next->next == NULL);
        MecabNode *newNode = [MecabNode new];
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
    
    return [NSArray<MecabNode *> arrayWithArray:newNodes];
}

- (void)dealloc {
    if (mecab != NULL) {
        mecab_destroy(mecab);
    }
    
    [super dealloc];
}

@end

