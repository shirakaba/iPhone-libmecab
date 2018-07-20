//
//  LibMecabSampleViewController.m
//  LibMecabSample
//
//  Created by Watanabe Toshinori on 10/12/27.
//  Copyright 2010 FLCL.jp. All rights reserved.
//

#import "LibMecabSampleViewController.h"
#import "../mecab/src/MecabObjC.h"
#import "../mecab/src/Node.h"

@implementation LibMecabSampleViewController

@synthesize textField;
@synthesize tableView_;
@synthesize nodeCell;
@synthesize mecab;
@synthesize nodes;

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.mecab = [[Mecab new] autorelease];
}

- (IBAction)parse:(id)sender {
	[textField resignFirstResponder];
	
	NSString *string = textField.text;
	
    // Default Japanese mode:
    // self.nodes = [mecab parseToNodeWithString:string];
    self.nodes = [mecab parseToNodeWithString:string dicdirRelativePath:DEFAULT_KOREAN_RESOURCES_BUNDLE_NAME koreanMode:(size_t)0];
	
	[tableView_ reloadData];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (nodes) {
		return [nodes count];
	}
	
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"NodeCell";
    
    NodeCell *cell = (NodeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"NodeCell" owner:self options:nil];
		cell = nodeCell;
		self.nodeCell = nil;
    }
    
	Node *node = [nodes objectAtIndex:indexPath.row];
	cell.surfaceLabel.text = node.surface;
    cell.featureLabel.text = [node reading]; // node.pronunciation field (field index 8) exists in Japanese (whether or not populated), but for Korean, the top index is 7 (which corresponds to node.pronunciation), although I don't yet know what that actually is.
    
    return cell;
}

- (void)dealloc {
	self.mecab = nil;
	self.nodes = nil;
	
	self.textField = nil;
	self.tableView_ = nil;
	self.nodeCell = nil;
    [super dealloc];
}

@end
