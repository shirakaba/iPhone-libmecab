//
//  MecabNode.m
//
//  Created by Watanabe Toshinori on 10/12/22 (originally as "Node.m").
//  Copyright 2010 FLCL.jp. All rights reserved.
//

#import "MecabNode.h"


@implementation MecabNode

@synthesize feature; // All features, as comma-separated string. Empty fields marked with: *
@synthesize features; // All features, parsed into array

@synthesize surface;
@synthesize partOfSpeech;
@synthesize partOfSpeechSubtype1;
@synthesize partOfSpeechSubtype2;
@synthesize partOfSpeechSubtype3;
@synthesize inflection;
@synthesize useOfType;
@synthesize originalForm;
@synthesize reading;
@synthesize pronunciation;
@synthesize leadingWhitespaceLength;
@synthesize trailingWhitespace;
// MecabObjC.m sets newNode.feature =, but never any other property (lazy setting)
- (void)setFeature:(NSString *)value {
    if (feature) [feature release];
    
    if (value) {
        feature = [value retain];
        self.features = [value componentsSeparatedByString:@","];
    } else {
        feature = nil;
        self.features = nil;
    }
}

// surface seems to be exposed by Mecab itself, hence why I haven't written a setter for it here.
// I wrote the implementation for all these setters, but in practice MecabObjC.m only assigns to newNode lazily.
- (void)setPartOfSpeech:(NSString *)value {
    if (partOfSpeech) [partOfSpeech release];
    partOfSpeech = value ? [value retain] : nil;
}

- (void)setPartOfSpeechSubtype1:(NSString *)value {
    if (partOfSpeechSubtype1) [partOfSpeechSubtype1 release];
    partOfSpeechSubtype1 = value ? [value retain] : nil;
}

- (void)setPartOfSpeechSubtype2:(NSString *)value {
    if (partOfSpeechSubtype2) [partOfSpeechSubtype2 release];
    partOfSpeechSubtype2 = value ? [value retain] : nil;
}

- (void)setPartOfSpeechSubtype3:(NSString *)value {
    if (partOfSpeechSubtype3) [partOfSpeechSubtype3 release];
    partOfSpeechSubtype3 = value ? [value retain] : nil;
}

- (void)setInflection:(NSString *)value {
    if (inflection) [inflection release];
    inflection = value ? [value retain] : nil;
}

- (void)setUseOfType:(NSString *)value {
    if (useOfType) [useOfType release];
    useOfType = value ? [value retain] : nil;
}

- (void)setOriginalForm:(NSString *)value {
    if (originalForm) [originalForm release];
    originalForm = value ? [value retain] : nil;
}

- (void)setReading:(NSString *)value {
    if (reading) [reading release];
    reading = value ? [value retain] : nil;
}

- (void)setPronunciation:(NSString *)value {
    if (pronunciation) [pronunciation release];
    pronunciation = value ? [value retain] : nil;
}

- (void)setLeadingWhitespaceLength:(int)value {
    leadingWhitespaceLength = value;
}

- (void)setTrailingWhitespace:(NSString *)value {
    if (trailingWhitespace) [trailingWhitespace release];
    trailingWhitespace = value ? [value retain] : nil;
}

// surface seems to be exposed by Mecab itself, hence why I haven't written a field for it here.

- (NSString *)partOfSpeech {
    if (!features || [features count] < 1) return nil;
    return [features objectAtIndex:0];
}

- (NSString *)partOfSpeechSubtype1 {
    if (!features || [features count] < 2) return nil;
    return [features objectAtIndex:1];
}

- (NSString *)partOfSpeechSubtype2 {
    if (!features || [features count] < 3) return nil;
    return [features objectAtIndex:2];
}

- (NSString *)partOfSpeechSubtype3 {
    if (!features || [features count] < 4) return nil;
    return [features objectAtIndex:3];
}

- (NSString *)inflection {
    if (!features || [features count] < 5) return nil;
    return [features objectAtIndex:4];
}

- (NSString *)useOfType {
    if (!features || [features count] < 6) return nil;
    return [features objectAtIndex:5];
}

- (NSString *)originalForm {
    if (!features || [features count] < 7) return nil;
    return [features objectAtIndex:6];
}

- (NSString *)reading {
    if (!features || [features count] < 8) return nil;
    return [features objectAtIndex:7];
}

- (NSString *)pronunciation {
    if (!features || [features count] < 9) return nil;
    return [features objectAtIndex:8];
}

- (int)leadingWhitespaceLength {
    return leadingWhitespaceLength;
}

- (NSString *)trailingWhitespace {
    return trailingWhitespace;
}

- (void)dealloc {
    // release methods untested here because we're using ARC.
    // Note: http://stackoverflow.com/a/7906891/5951226 says you shouldn't actually nil out properties in dealloc, and certainly not 'retain' ones.
    self.feature = nil;
    self.features = nil;
    // self.leadingWhitespaceLength = nil;
    
    self.surface = nil;
    self.partOfSpeech = nil;
    self.partOfSpeechSubtype1 = nil;
    self.partOfSpeechSubtype2 = nil;
    self.partOfSpeechSubtype3 = nil;
    self.inflection = nil;
    self.useOfType = nil;
    self.originalForm = nil;
    self.reading = nil;
    self.pronunciation = nil;
    self.trailingWhitespace = nil;
    
    [super dealloc];
}

@end

