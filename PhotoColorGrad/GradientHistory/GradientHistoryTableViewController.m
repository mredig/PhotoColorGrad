//
//  GradientHistoryTableViewController.m
//  PhotoColorGrad
//
//  Created by Michael Redig on 4/11/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

#import "GradientHistoryTableViewController.h"
#import "PhotoColorGrad-Swift.h"
#import "GradientCell.h"

@interface GradientHistoryTableViewController ()

@end

@implementation GradientHistoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = @"Gradient History";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
	[self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [DefaultWrapper shared].gradientHistory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GradientCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GradientCell" forIndexPath:indexPath];

	NSArray *colors = [DefaultWrapper shared].gradientHistory[indexPath.row];
    // Configure the cell...
	cell.gradientColors = colors;

    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source

		NSMutableArray *colorsCopy = [[DefaultWrapper shared].gradientHistory mutableCopy];
		[colorsCopy removeObjectAtIndex:indexPath.row];
		[DefaultWrapper shared].gradientHistory = [colorsCopy copy];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/
@end
