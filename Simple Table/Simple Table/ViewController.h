//
//  ViewController.h
//  Simple Table
//
//  Created by xiaoo_gan on 11/14/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITabBarControllerDelegate, UITableViewDataSource>
@property (copy, nonatomic) NSArray *dwarves;


@end

