//
//  ViewController.m
//  Swipes
//
//  Created by xiaoo_gan on 12/1/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "ViewController.h"

#define kMinimumGestureLength   25
#define kMaximumVariance        5

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UISwipeGestureRecognizer *vertical = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reportHorizontalSwipe:)];
    vertical.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:vertical];
    
    UISwipeGestureRecognizer *horizontal = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reportVerticalSwipe:)];
    horizontal.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:horizontal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) eraseText
{
    self.label.text = @"";
}

#pragma mark -

- (void)reportHorizontalSwipe:(UIGestureRecognizer *)recongnizer
{
    self.label.text = @"Horizontal Swipe detected";
    [self performSelector:@selector(eraseText) withObject:nil afterDelay:2];
}
- (void)reportVerticalSwipe:(UIGestureRecognizer *)recongnizer
{
    self.label.text = @"Vertical swipe detected";
    [self performSelector:@selector(eraseText) withObject:nil afterDelay:2];
    
}
//- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    self.gestureStartPoint = [touch locationInView:self.view];
//}
//- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    CGPoint currentPosition = [touch locationInView:self.view];
//    
//    CGFloat deltaX = fabs(self.gestureStartPoint.x - currentPosition.x);
//    CGFloat deltaY = fabs(self.gestureStartPoint.y - currentPosition.y);
//    
//    if (deltaX >= kMinimumGestureLength && deltaY <= kMaximumVariance) {
//        self.label.text = @"Horizontal swipe detected";
//        [self performSelector:@selector(eraseText) withObject:nil afterDelay:2];
//        
//    }else if(deltaY >= kMinimumGestureLength && deltaX <= kMaximumVariance) {
//        self.label.text = @"Vertical swipe detected";
//        [self performSelector:@selector(eraseText) withObject:nil afterDelay:2];
//    }
//    
//}
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
@end
