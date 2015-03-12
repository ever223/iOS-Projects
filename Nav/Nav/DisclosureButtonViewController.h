//
//  DisclosureButtonViewController.h
//  Nav
//
//  Created by xiaoo_gan on 11/16/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "SecondLevelViewController.h"

@class DisclosureButtonDetailViewController;

@interface DisclosureButtonViewController : SecondLevelViewController

@property (copy, nonatomic) NSArray *movies;
@property (strong, nonatomic) DisclosureButtonDetailViewController *detailController;

@end
