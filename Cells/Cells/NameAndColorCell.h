//
//  NameAndColorCell.h
//  Cells
//
//  Created by xiaoo_gan on 11/15/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NameAndColorCell : UITableViewCell
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *color;

@property (strong, nonatomic) IBOutlet UILabel *nameValue;
@property (strong ,nonatomic) IBOutlet UILabel *colorValue;
@end
