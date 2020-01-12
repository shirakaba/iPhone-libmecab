//
//  LibMecabSampleViewController.h
//  LibMecabSample
//
//  Created by Watanabe Toshinori on 10/12/27.
//  Copyright 2010 FLCL.jp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NodeCell.h"
#import <mecab_ko/MecabObjC.h>
#import <mecab_ko/MecabNode.h>

@class Mecab;

@interface LibMecabSampleViewController : UIViewController {
	
	UITextField *textField;
	UITableView *tableView_;
	NodeCell *nodeCell;
	
	Mecab *mecabJp;
    Mecab *mecabKo;
	NSArray<MecabNode *> *nodes;

}

@property (nonatomic, retain) IBOutlet UITextField *textField;
@property (nonatomic, retain) IBOutlet UITableView *tableView_;
@property (nonatomic, retain) IBOutlet NodeCell *nodeCell;
@property (nonatomic, retain) Mecab *mecabJp;
@property (nonatomic, retain) Mecab *mecabKo;
@property (nonatomic, retain) NSArray<MecabNode *> *nodes;

- (IBAction)parse:(id)sender;

@end

