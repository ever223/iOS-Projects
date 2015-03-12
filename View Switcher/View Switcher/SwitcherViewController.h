//
//  SwitcherViewController.h
//  View Switcher
//
//  Created by xiaoo_gan on 11/12/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YellowViewController;
@class BlueViewController;

@interface SwitcherViewController : UIViewController

@property YellowViewController *yellowViewController;
@property BlueViewController *blueViewController;

- (IBAction)switcherViews:(id)sender;

@end
