//
//  DoubleComponentPickerViewController.m
//  Pickers
//
//  Created by xiaoo_gan on 11/13/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "DoubleComponentPickerViewController.h"

@interface DoubleComponentPickerViewController ()

@end

@implementation DoubleComponentPickerViewController
- (IBAction)buttonPressed
{
    NSInteger fillingRow = [self.doublePicker selectedRowInComponent:kFillingComponnet];
    NSInteger breadRow = [self.doublePicker selectedRowInComponent:kBreadComponent];
    NSString *filling = self.fillingTypes[fillingRow];
    NSString *bread = self.breadTypes[breadRow];
    
    NSString *message = [[NSString alloc] initWithFormat:@"You %@ on %@ bread will be right up.", filling, bread];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you for your order" message:message delegate:nil cancelButtonTitle:@"Great!" otherButtonTitles: nil];
    [alert show];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.fillingTypes = @[@"Ham", @"Turkey", @"Peaut Butter", @"Tuna Salad", @"Chicken Salad", @"Roast Beef", @"Vegemite"];
    self.breadTypes = @[@"White", @"Whole Wheat", @"Rye", @"Sourdough", @"Seven Grain"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == kFillingComponnet) {
        return [self.fillingTypes count];
    } else {
        return [self.breadTypes count];
    }
}
#pragma mark Picker Delegate Methods
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == kFillingComponnet) {
        return self.fillingTypes[row];
    } else {
        return self.breadTypes[row];
    }
}
@end
