#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "mecab.h"
#import "MecabNode.h"
#import "MecabObjC.h"

FOUNDATION_EXPORT double mecab_koVersionNumber;
FOUNDATION_EXPORT const unsigned char mecab_koVersionString[];

