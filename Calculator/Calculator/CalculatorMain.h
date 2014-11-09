//
//  CalculatorMain.h
//  Calculator
//
//  Created by xiaoo_gan on 11/6/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorMain : NSObject
@property (strong, nonatomic) NSMutableArray *numberStack;
@property (strong, nonatomic) NSMutableArray *operationStack;
@property (readonly) double memeryNumber;
@property (readonly) double result;

- (void) pushNumber:(NSString *) number;
- (NSString *) popNumber;

- (void) pushOperation:(NSString *) operation;
- (NSString *) popOperation;

- (void) memClear;
- (void) memAdd: (double) memNum;
- (void) memSub: (double) memNum;

- (void) answerOperation;

- (void) clearAll;
- (void) readStack;
@end
