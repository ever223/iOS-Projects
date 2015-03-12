//
//  ViewController.m
//  Sections
//
//  Created by xiaoo_gan on 11/15/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "ViewController.h"

static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITableView *tableView = (id)[self.view viewWithTag:1];
    [tableView registerClass:[UITableView class] forCellReuseIdentifier:SectionsTableIdentifier];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
    self.names = [NSDictionary dictionaryWithContentsOfFile:path];
    self.keys = [[self.names allKeys] sortedArrayUsingSelector:@selector(compare:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 
#pragma mark Table View Data Source Methods
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.keys count];
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = self.keys[section];
    NSArray *nameSection = self.names[key];
    return [nameSection count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.keys[section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SectionsTableIdentifier];
    NSString *key = self.keys[indexPath.section];
    NSArray *nameSection = self.names[key];
    cell.textLabel.text = nameSection[indexPath.row];
    return cell;
}
@end
