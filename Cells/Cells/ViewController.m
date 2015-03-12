//
//  ViewController.m
//  Cells
//
//  Created by xiaoo_gan on 11/15/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "ViewController.h"
#import "NameAndColorCell.h"
@interface ViewController ()

@end

@implementation ViewController
static NSString *CellTableIdentifier = @"CellTableIdentifier";
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.computers =  @[@{@"Name" : @"MacBook Air", @"Color" : @"Silver"},
                        @{@"Name" : @"MacBook Pro", @"Color" : @"Silver"},
                        @{@"Name" : @"iMac", @"Color" : @"Silver"},
                        @{@"Name" : @"Mac Mini", @"Color" : @"Silver"},
                        @{@"Name" : @"Mac Pro", @"Color" : @"Black"}];
    UITableView *tableView = (id)[self.view viewWithTag:1];
    tableView.rowHeight = 65;
    UINib *nib = [UINib nibWithNibName:@"NameAndColorCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.computers count];
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NameAndColorCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    NSDictionary *rowData = self.computers[indexPath.row];
    cell.name = rowData[@"Name"];
    cell.color = rowData[@"Color"];
    return cell;
}
@end
