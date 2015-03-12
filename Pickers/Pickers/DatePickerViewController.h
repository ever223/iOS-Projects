//
//  DatePickerViewController.h
//  Pickers
//
//  Created by xiaoo_gan on 11/13/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerViewController : UIViewController
@property (strong,nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)buttonPressed;
@end
