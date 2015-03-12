//
//  TaskListController.m
//  Simple Storyboard
//
//  Created by xiaoo_gan on 11/23/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "TaskListController.h"

@interface TaskListController ()
@property (strong, nonatomic) NSArray *tasks;
@end

@implementation TaskListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tasks = @[@"walk the dog",
                   @"URGENT:buy milk",
                   @"clean hidden lair",
                   @"invent miniature dolphins",
                   @"find new henchmen",
                   @"get revenge on do-gooder heroes",
                   @"URGENT:fold laundry",
                   @"hold entire world hostage",
                   @"manicure"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.tasks count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = nil;
    NSString *task = [self.tasks objectAtIndex:indexPath.row];
    NSRange urgentRange = [task rangeOfString:@"URGENT"];
    if (urgentRange.location == NSNotFound) {
        identifier = @"plainCell";
    } else {
        identifier = @"attentionCell";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    UILabel *cellLabel = (UILabel *)[cell viewWithTag:1];
    NSMutableAttributedString *richTask = [[NSMutableAttributedString alloc] initWithString:task ];
    NSDictionary *urgentAttributes = @{NSFontAttributeName:[UIFont fontWithName:@"Courier" size:24],NSStrokeColorAttributeName:@3.0};
    [richTask setAttributes:urgentAttributes range:urgentRange];
    cellLabel.attributedText = richTask;
    return cell;
}
@end
