//
//  LibMecabSampleViewController.m
//  LibMecabSample
//
//  Created by Watanabe Toshinori on 10/12/27.
//  Copyright 2010 FLCL.jp. All rights reserved.
//

#import "LibMecabSampleViewController.h"
#import <mecab_ko/MecabObjC.h>
#import <mecab_ko/MecabNode.h>

@implementation LibMecabSampleViewController

@synthesize textField;
@synthesize tableView_;
@synthesize nodeCell;
@synthesize mecab;
@synthesize nodes;

- (void)viewDidLoad {
	[super viewDidLoad];
    
    NSString *jpDicBundlePath = [[NSBundle mainBundle] pathForResource:DEFAULT_JAPANESE_RESOURCES_BUNDLE_NAME ofType:@"bundle"];
    NSString *jpDicBundleResourcePath = [[NSBundle alloc] initWithPath:jpDicBundlePath].resourcePath;
	
	self.mecab = [[Mecab alloc] initWithDicDirPath:jpDicBundleResourcePath];
}

- (IBAction)parse:(id)sender {
	[textField resignFirstResponder];
	
	NSString *string = textField.text;
    self.nodes = [mecab parseToNodeWithString:string calculateTrailingWhitespace:NO];
	
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
	MecabNode *node = [nodes objectAtIndex:indexPath.row];
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
