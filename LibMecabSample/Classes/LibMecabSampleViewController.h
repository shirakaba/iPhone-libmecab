//
//  LibMecabSampleViewController.h
//  LibMecabSample
//
//  Created by Watanabe Toshinori on 10/12/27.
//  Copyright 2010 FLCL.jp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NodeCell.h"
#import "../mecab/objc_bridging/Node.h"

@class Mecab;

@interface LibMecabSampleViewController : UIViewController {
	
	UITextField *textField;
	UITableView *tableView_;
	NodeCell *nodeCell;
	
	Mecab *mecab;
	NSArray<Node *> *nodes;

}

@property (nonatomic, retain) IBOutlet UITextField *textField;
@property (nonatomic, retain) IBOutlet UITableView *tableView_;
@property (nonatomic, retain) IBOutlet NodeCell *nodeCell;
@property (nonatomic, retain) Mecab *mecab;
@property (nonatomic, retain) NSArray<Node *> *nodes;

- (IBAction)parse:(id)sender;

@end

