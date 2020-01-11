//
//  NodeCell.h
//  MecabSample
//
//  Created by Watanabe Toshinori on 10/12/22.
//  Copyright 2010 FLCL.jp. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NodeCell : UITableViewCell {

	UILabel *featureLabel;
	UILabel *surfaceLabel;

}

@property (nonatomic, retain) IBOutlet UILabel *featureLabel;
@property (nonatomic, retain) IBOutlet UILabel *surfaceLabel;

@end
