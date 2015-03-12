//
//  YellowViewController.m
//  View Switcher
//
//  Created by xiaoo_gan on 11/12/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "YellowViewController.h"

@interface YellowViewController ()

@end

@implementation YellowViewController
- (IBAction)yellowButtonPressed:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Yellow Button Pressed" message:@"You pressed the button on the yellow view" delegate:nil cancelButtonTitle:@"Yep, I did" otherButtonTitles: nil];
    [alert show];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

@end
