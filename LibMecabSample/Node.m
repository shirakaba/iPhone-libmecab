//
//  Node.m
//
//  Created by Watanabe Toshinori on 10/12/22.
//  Copyright 2010 FLCL.jp. All rights reserved.
//

#import "Node.h"


@implementation Node

@synthesize surface;
@synthesize feature; // All features, as comma-separated string. Empty fields marked with: *
@synthesize features; // All features, parsed into array

- (void)setFeature:(NSString *)value {
	if (feature) {
		[feature release];
	}
	
	if (value) {
		feature = [value retain];
		self.features = [value componentsSeparatedByString:@","];
	} else {
		feature = nil;
		self.features = nil;
	}
}

- (NSString *)partOfSpeech {
	if (!features || [features count] < 1) {
		return nil;
	}
	return [features objectAtIndex:0];
}

- (NSString *)partOfSpeechSubtype1 {
	if (!features || [features count] < 2) {
		return nil;
	}
	return [features objectAtIndex:1];
}

- (NSString *)partOfSpeechSubtype2 {
	if (!features || [features count] < 3) {
		return nil;
	}
	return [features objectAtIndex:2];
}

- (NSString *)partOfSpeechSubtype3 {
	if (!features || [features count] < 4) {
		return nil;
	}
	return [features objectAtIndex:3];
}

- (NSString *)inflection {
	if (!features || [features count] < 5) {
		return nil;
	}
	return [features objectAtIndex:4];
}

- (NSString *)useOfType {
	if (!features || [features count] < 6) {
		return nil;
	}
	return [features objectAtIndex:5];
}

- (NSString *)originalForm {
	if (!features || [features count] < 7) {
		return nil;
	}
	return [features objectAtIndex:6];
}

- (NSString *)reading {
	if (!features || [features count] < 8) {
		return nil;
	}
	return [features objectAtIndex:7];
}

- (NSString *)pronunciation {
	if (!features || [features count] < 9) {
		return nil;
	}
	return [features objectAtIndex:8];
}

- (void)dealloc {
	self.surface = nil;
	self.feature = nil;
    self.features = nil;

	[super dealloc];
}

@end
