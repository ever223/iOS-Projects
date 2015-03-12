//
//  ViewController.h
//  Sections
//
//  Created by xiaoo_gan on 11/15/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITabBarDelegate>

@property (copy, nonatomic) NSDictionary *names;
@property (copy, nonatomic) NSArray *keys;

@end

