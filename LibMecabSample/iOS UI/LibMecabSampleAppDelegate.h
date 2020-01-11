//
//  LibMecabSampleAppDelegate.h
//  LibMecabSample
//
//  Created by Watanabe Toshinori on 10/12/27.
//  Copyright 2010 FLCL.jp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LibMecabSampleViewController;

@interface LibMecabSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    LibMecabSampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet LibMecabSampleViewController *viewController;

@end

