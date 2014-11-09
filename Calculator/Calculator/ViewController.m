//
//  ViewController.m
//  Calculator
//
//  Created by xiaoo_gan on 11/5/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "ViewController.h"
@interface ViewController()
@property (retain, nonatomic) CalculatorMain *Main;
@end


@implementation ViewController


- (void) initTextValue {
    [self.display setText:@"0"];
    [self.currentNumber setText:@"0"];
    isTypeNumber = NO;
    isMemery = NO;
    isAnswered = NO;
    [self.Main clearAll];
}

- (void) viewDidLoad {
    self.Main = [[CalculatorMain alloc] init];
    [self.display setText:@"0"];    //初始化时，将显示框内容设置为0
    [self.currentNumber setText:@""];
    isTypeNumber = NO;
    isMemery = NO;
    isReType = NO;
    
}

- (void) appendDisplayText:(NSString *) digit {
    [self.display setText: [self.display.text stringByAppendingString:digit]];  //拼接display的内容
   
}
- (void) appendCurrentNumber: (NSString *) digit {
    [self.currentNumber setText:[self.currentNumber.text stringByAppendingString:digit]];   //拼接当前数值的内容
}

- (IBAction)digitPressed:(UIButton *)sender {
    if (isReType) {
        [self initTextValue];
        isReType = NO;
    }
    NSString *digit = [sender currentTitle];
    if ([@"0" isEqual:self.currentNumber.text] && [@"0" isEqual:digit]) { //防止出现0000的数值
        isTypeNumber = NO;
        return;
    }
    if(isTypeNumber) {
        if (![@"." isEqual:digit] || ([@"." isEqual:digit] && [self.currentNumber.text rangeOfString:@"."].location == NSNotFound)) {
            [self appendDisplayText:digit];
            [self appendCurrentNumber:digit];
        }
    }
    else {
        if ([@"." isEqualToString:digit]) {
            if ([self.currentNumber.text isEqualToString:@""]) {
                [self appendDisplayText:@"0"];                      //第一个输入的字符是. ,则自动补成"0."格式
            }
            [self appendDisplayText:digit];
            [self appendCurrentNumber:digit];
        } else {
            if ([self.display.text isEqualToString:@"0"]) {
                [self.display setText:digit];                       //若输入第一个数非0非.，则去掉第一个0
            } else {
                [self appendDisplayText:digit];
            }
            [self.currentNumber setText:digit];
        }
        isTypeNumber = YES;
    }
   // NSLog(@"%lf", self.currentNumber.text.doubleValue);
}

- (IBAction)mPressed:(UIButton *)sender {   //当MC M+ M- MR ⌫ AC被按下时，调用该方法
    NSString *mTitle = [sender currentTitle];
    if ([@"MC" isEqualToString:mTitle] && isMemery) {           //MC是清除储存数据
        [self.Main memClear];
        
    } else if([@"M＋" isEqualToString:mTitle]) {     //M+是计算结果并加上已经储存的数
        [self.Main memAdd:self.display.text.doubleValue];
        isMemery = YES;
    } else if([@"M－" isEqualToString:mTitle]) {     //M-是计算结果并用已储存的数字减去目前的结果
        [self.Main memSub:self.display.text.doubleValue];
        isMemery = YES;
        
    } else if([@"MR" isEqualToString:mTitle]) {     //MR是读取储存的数据,并显示在屏幕上
        [self.display setText:[NSString stringWithFormat:@"%g", self.Main.memeryNumber]];
        isTypeNumber = NO;
        isReType = YES;
        
    } else if([@"⌫" isEqualToString:mTitle]) {      //删除屏幕上的最后一个数字或者操作符
//        if ([self.display.text length] == 1) {
//            [self.display setText:@"0"];
//        } else {
//            int length = [self.display.text length];
//            NSString *displayText = [self.display.text substringToIndex: (length - 1)];
//            [self.display setText:displayText];
//        }
        
    } else if([@"AC" isEqualToString:mTitle]) {     //清除屏幕上的内容
        [self initTextValue];
    }
}
- (IBAction)operationPressed:(UIButton *)sender { //当( ) % ÷ × - + ±按下时，调用该方法
    NSString *op = [sender currentTitle];
    if (isReType) {
        [self.currentNumber setText:[NSString stringWithFormat:@"%g", self.Main.result]];
        isReType = NO;
    }
    
    if (isTypeNumber) {
        isTypeNumber = NO;
        [self appendDisplayText:op];
        [self.Main pushNumber: self.currentNumber.text]; //将当前的数值输压入数值栈
        [self.Main pushOperation:op];
        [self.currentNumber setText:@""];
    } else {
        return;
    }
}
- (IBAction)enterPressed:(UIButton *)sender {
    if (isTypeNumber) {
        [self.Main pushNumber:self.currentNumber.text];
        isReType = YES;
    } else {
        return;
    }
    [self.Main answerOperation];
    [self.display setText:[NSString stringWithFormat:@"%g", self.Main.result]];
    //[self.Main clearAll];
    //isReType =YES;
}
@end
