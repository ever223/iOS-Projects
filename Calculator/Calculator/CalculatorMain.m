//
//  CalculatorMain.m
//  Calculator
//
//  Created by xiaoo_gan on 11/6/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "CalculatorMain.h"

@implementation CalculatorMain

@synthesize memeryNumber;
@synthesize result;
- (double) returnAndRemoveFirstNumberStack {
    double tmp = [[self.numberStack firstObject] doubleValue];
    [self.numberStack removeObjectAtIndex:0];
    return tmp;
}
- (NSString *) returnFirstOperationStack {
    return [self.operationStack firstObject];
}
- (void) removeFirstOperationStack {
    [self.operationStack removeObjectAtIndex:0];
}
- (double) operate:(double) a operator:(NSString *) op numb:(double) b {
    double tmp;
    if ([@"+" isEqualToString:op]) {
            tmp = a + b;
        } else if ([@"-" isEqualToString:op]) {
            tmp = a - b;
        } else if ([@"×" isEqualToString:op]) {
            tmp = a * b;
        } else if ([@"÷" isEqualToString:op]) {
            tmp = a / b;
        };
    return tmp;
}
- (void) answerOperation {
    double num1, num2, num3;
    if ([self.numberStack count] == 1) {
        result = [self returnAndRemoveFirstNumberStack];
        return;
    }
    num1 = [self returnAndRemoveFirstNumberStack];
    num2 = [self returnAndRemoveFirstNumberStack];
    while ([self.operationStack count] > 0) {
        NSString *op1 = [self returnFirstOperationStack];
        //NSLog(@"%@", op1);
        if ([self.operationStack count] == 1) {
            result = [self operate:num1 operator:op1 numb:num2];
            //NSLog(@"num1 = %g, num2 = %g", num1, num2);
            [self removeFirstOperationStack];
            return;
        } else {
            if ([@"×" isEqualToString:op1] || [@"÷" isEqualToString:op1]) {
                num1 = [self operate:num1 operator:op1 numb:num2];
                num2 = [self returnAndRemoveFirstNumberStack];
                NSLog(@"num1 = %g, num2 = %g", num1, num2);
                [self removeFirstOperationStack];
            } else if ([@"+" isEqualToString:op1 ] || [@"-" isEqualToString:op1]) {
                NSString *op2 = [self.operationStack objectAtIndex:1];
                if ([@"×" isEqualToString:op2] || [@"÷" isEqualToString:op2]) {
                    num3 = [self returnAndRemoveFirstNumberStack];
                    num2 = [self operate:num2 operator:op2 numb:num3];
                    [self.operationStack removeObjectAtIndex:1];
                } else if ([@"+" isEqualToString:op2 ] || [@"-" isEqualToString:op2]) {
                    num1 = [self operate:num1 operator:op1 numb:num2];
                    num2 = [self returnAndRemoveFirstNumberStack];
                    [self removeFirstOperationStack];
                }
            }
        }
    }
}
-(double) memeryNumber {
    if (!memeryNumber) {
        memeryNumber = 0;
    }
    return memeryNumber;
}
- (NSMutableArray *) numberStack {
    if (!_numberStack) {
        _numberStack = [NSMutableArray arrayWithCapacity:20];
    }
    return _numberStack;
}
- (NSMutableArray *) operationStack {
    if (!_operationStack) {
        _operationStack = [NSMutableArray arrayWithCapacity:20];
    }
    return _operationStack;
}
- (void) pushNumber:(NSString *) number {           //数值入栈
    [self.numberStack addObject:number];
    
}
- (NSString *) popNumber {                          //数值出栈
    id topNumber = [self.numberStack lastObject];
    if (topNumber != nil) {
        [self.numberStack removeLastObject];
    }
    return topNumber;
}

- (void) pushOperation:(NSString *) operation { //操作符入栈
    [self.operationStack addObject:operation];
    
}

- (NSString *) popOperation {                   //操作符出栈
    NSString *topOperation = [self.operationStack lastObject];
    if(topOperation != nil) {
        [self.operationStack removeLastObject];
    }
    return topOperation;
}

- (void) memClear {
    memeryNumber = 0;
    NSLog(@"memeryNumber = %g",memeryNumber);
}

- (void) memAdd:(double) number {
    memeryNumber = memeryNumber + number;
    NSLog(@"memeryNumber = %g",memeryNumber);
}

- (void) memSub:(double)memNum {
    memeryNumber = memeryNumber - memNum;
    NSLog(@"memeryNumber = %g",memeryNumber);
}

- (void) clearAll {             //清除所有数据
    [self.numberStack removeAllObjects];
    [self.operationStack removeAllObjects];
    result = 0;
}

- (void) readStack {
    NSLog(@"%@", self.numberStack);
    NSLog(@"%@", self.operationStack);
}

@end
