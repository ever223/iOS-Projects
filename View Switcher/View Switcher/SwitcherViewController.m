//
//  SwitcherViewController.m
//  View Switcher
//
//  Created by xiaoo_gan on 11/12/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "SwitcherViewController.h"
#import "BlueViewController.h"
#import "YellowViewController.h"

@interface SwitcherViewController ()

@end

@implementation SwitcherViewController

- (IBAction)switcherViews:(id)sender {
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:1.25];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    if (self.yellowViewController.view.subviews == nil) {
        if (self.yellowViewController == nil) {
            self.yellowViewController = [[YellowViewController alloc] initWithNibName:@"YellowView" bundle:nil];
        }
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        [self.blueViewController.view removeFromSuperview];
        [self.view insertSubview:self.yellowViewController.view atIndex:0];
    } else {
        if (self.blueViewController.view.subviews == nil) {
            if (self.blueViewController == nil) {
                self.blueViewController = [[BlueViewController alloc] initWithNibName:@"blueView" bundle:nil];
            
            }
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
            [self.yellowViewController.view removeFromSuperview];
            [self.view insertSubview:self.blueViewController.view atIndex:0];
        }
    }
    [UIView commitAnimations];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.blueViewController = [[BlueViewController alloc] initWithNibName:@"blueView" bundle:nil];
    [self.view insertSubview:self.blueViewController.view atIndex:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if (self.blueViewController.view.subviews == nil) {
        self.blueViewController = nil;
    } else {
        self.yellowViewController = nil;
    }
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
