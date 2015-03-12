//
//  DependentComponentPickerViewController.m
//  Pickers
//
//  Created by xiaoo_gan on 11/13/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "DependentComponentPickerViewController.h"

@interface DependentComponentPickerViewController ()

@end

@implementation DependentComponentPickerViewController
- (IBAction)buttonPressed
{
    
    NSInteger stateRow = [self.dependentPicker selectedRowInComponent:kStateComponent];
    NSInteger zipRow = [self.dependentPicker selectedRowInComponent:kZipComponent];
    
    NSString *state = self.states[stateRow];
    NSString *zip = self.zips[zipRow];
    
    NSString *title = [[NSString alloc] initWithFormat:@"You selected zip code %@.", zip];
    NSString *message = [[NSString alloc] initWithFormat:@"%@ is in %@", zip, state];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURL = [bundle URLForResource:@"statedictionary" withExtension:@"plist"];
    self.stateZips = [NSDictionary dictionaryWithContentsOfURL:plistURL];
    NSArray *allStates = [self.stateZips allKeys];
    NSArray *sortedStates = [allStates sortedArrayUsingSelector:@selector(compare:)];
    self.states = sortedStates;
    NSString *selectedState = self.states[0];
    self.zips = self.stateZips[selectedState];
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
    if (component == kStateComponent) {
        return [self.states count];
    } else {
        return [self.stateZips count];
    }
}
#pragma mark Picker Delegate Methods
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == kStateComponent) {
        return self.states[row];
    }else {
        return self.zips[row];
    }
}
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == kStateComponent) {
        NSString *selectedState = self.states[row];
        self.zips = self.stateZips[ selectedState];
        [self.dependentPicker reloadComponent:kZipComponent];
        [self.dependentPicker  selectRow:0 inComponent:kZipComponent animated:YES];
    }
}
- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == kZipComponent) {
        return 100;
    } else {
        return 200;
    }
}
@end
