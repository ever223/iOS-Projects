//
//  FirstLevelViewController.m
//  Nav
//
//  Created by xiaoo_gan on 11/16/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "FirstLevelViewController.h"
#import "SecondLevelViewController.h"
#import "DisclosureButtonViewController.h"
//@interface FirstLevelViewController ()
//
//@end
static NSString *CellIdentifier = @"Cell";
@implementation FirstLevelViewController
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"First Level";
        //self.controllers = @[];
        self.controllers = @[[[DisclosureButtonViewController alloc] init]];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.controllers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    SecondLevelViewController *controller = self.controllers[indexPath.row];
    
    cell.textLabel.text = controller.title;
    cell.imageView.image = controller.rowImage;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondLevelViewController *controller = self.controllers[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
