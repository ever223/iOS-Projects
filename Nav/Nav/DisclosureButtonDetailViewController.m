//
//  DisclosureButtonDetailViewController.m
//  Nav
//
//  Created by xiaoo_gan on 11/16/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "DisclosureButtonDetailViewController.h"

@interface DisclosureButtonDetailViewController ()

@end

@implementation DisclosureButtonDetailViewController

- (UILabel *)label
{
    return (id)self.view;
}
- (void)loadView
{
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    self.view = label;
}
- (void)viewWillAppear:(BOOL)animated
{
    //[super viewWillAppear:<#animated#>];
    self.label.text = self.message;
}
@end
