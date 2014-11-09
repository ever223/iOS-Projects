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

typedef enum {
    isNumber,
    isOperation,
    isLeftBracket,
    isRightBracket
} charType;

@implementation ViewController

//判断display显示的最后一个字符的类型
- (charType) lastDisplayTextType {
    
    NSInteger length = [self.display.text length];
    NSString *lastCharactor = [self.Main subValueStack:self.display.text index:(length - 1)];
    if ([self.Main isNumber:lastCharactor]) {
        return isNumber;
    } else if([self.Main isOperation:lastCharactor]) {
        return isOperation;
    } else if([@"(" isEqualToString:lastCharactor]) {
        return isLeftBracket;
    } else {
        return isRightBracket;
    }
}

- (void) initTextValue {
    [self.display setText:@"0"];
    [self.currentNumber setText:@""];
    isTypeNumber = NO;
    isAnswered = NO;
    [self.Main clearAll];
}

//加载时，进行初始化
- (void) viewDidLoad {
    self.Main = [[CalculatorMain alloc] init];
    [self initTextValue];
}
//拼接display的内容
- (void) appendDisplayText:(NSString *) digit {
    [self.display setText: [self.display.text stringByAppendingString:digit]];
}

//拼接当前数值的内容
- (void) appendCurrentNumber: (NSString *) digit {
    [self.currentNumber setText:[self.currentNumber.text stringByAppendingString:digit]];
}

//按下：0 1 2 3 4 5 6 7 8 9 . 键时
- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    
    if ([self lastDisplayTextType] == isRightBracket) { //若display显示的最后一个字符是")"，则不处理
        return;
    }
    
    if (isAnswered) {
        [self.currentNumber setText:@""];
        isAnswered = NO;
    }
    
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
}

//当MC M+ M- MR ⌫ AC被按下时，调用
- (IBAction)mPressed:(UIButton *)sender {
    NSString *mTitle = [sender currentTitle];
    if ([@"MC" isEqualToString:mTitle]) {           //MC是清除储存数据
        [self.Main memClear];
    } else if([@"M＋" isEqualToString:mTitle]) {     //M+是计算结果并加上已经储存的数
        [self.Main memAdd:self.display.text.doubleValue];
    } else if([@"M－" isEqualToString:mTitle]) {     //M-是计算结果并用已储存的数字减去目前的结果
        [self.Main memSub:self.display.text.doubleValue];
    } else if([@"MR" isEqualToString:mTitle]) {     //MR是读取储存的数据,并显示在屏幕上
        [self.display setText:[NSString stringWithFormat:@"%g", self.Main.memeryNumber]];
        isAnswered = YES;
        
    } else if([@"⌫" isEqualToString:mTitle]) {      //删除屏幕上的最后一个数字或者操作符
        if ([self.display.text length] == 1) {
            [self initTextValue];
        } else {
            NSInteger length = [self.display.text length];
            NSString *displayText = [self.display.text substringToIndex: (length - 1)];
            [self.display setText:displayText];
        }
        
    } else if([@"AC" isEqualToString:mTitle]) {     //清除屏幕上的内容
        [self initTextValue];
    }
}

//当( ) % ÷ × - + ±按下时，调用
- (IBAction)operationPressed:(UIButton *)sender {
    NSString *op = [sender currentTitle];
    if (isAnswered) {
        [self.currentNumber setText:self.display.text];
        isAnswered = NO;
    }
    if ([@"(" isEqualToString:op]) {
        if (!isTypeNumber) { //若前面输入的是数值，则不处理
            if ([self.display.text isEqualToString:@"0"]) {
                [self.display setText:op];
            } else {
                [self appendDisplayText:op];
            }
            [self.Main addBracketCount];
        }
    } else if ([@")" isEqualToString:op] ) {
        if (self.Main.bracketCount > 0)  {              //若已输入的左括号和右括号抵消后为0，则不处理
            if (isTypeNumber) {
                [self appendDisplayText:op];
                [self.Main subBrackCount];
                isTypeNumber = YES;                     //")"后面不能接"("
            }
        }
    } else {
        if ([self lastDisplayTextType] == isLeftBracket) {  //如果display最后一个字符为左括号，则不处理
            return;
        }
        if (isTypeNumber) {                             //当 % ÷ × - + ±按下时
            isTypeNumber = NO;                          //当前不是在输入数值
            [self appendDisplayText:op];
            [self.currentNumber setText:@""];
        }
    }
}

- (IBAction)enterPressed:(UIButton *)sender {
    if (isTypeNumber) {             //如果按下“＝”键前，正在输入数值或者“）”，则调用
        isAnswered = YES;
    } else {
        return;
    }
    [self appendDisplayText:@"＝"];   //在字符串最后添加标记符
    NSString *displayText = self.display.text;
    [self.Main answerOperation: self.display.text];     //计算
    NSString *resultText =[NSString stringWithFormat:@"%2.15g", self.Main.result];
    [self.display setText:resultText];
    NSLog(@"%@%@", displayText, resultText);
}

@end
