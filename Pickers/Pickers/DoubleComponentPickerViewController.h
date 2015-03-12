//
//  DoubleComponentPickerViewController.h
//  Pickers
//
//  Created by xiaoo_gan on 11/13/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kFillingComponnet 0
#define kBreadComponent 1

@interface DoubleComponentPickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *doublePicker;
@property (strong, nonatomic) NSArray *fillingTypes;
@property (strong,nonatomic) NSArray *breadTypes;

- (IBAction)buttonPressed;

@end
