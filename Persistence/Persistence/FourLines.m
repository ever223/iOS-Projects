//
//  FourLines.m
//  Persistence
//
//  Created by xiaoo_gan on 12/1/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "FourLines.h"

#define kLinesKey @"kLinesKey"

@implementation FourLines

#pragma mark - Coding
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.lines = [aDecoder decodeObjectForKey:kLinesKey];
    }
    return self;
}
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.lines forKey:kLinesKey];
}

#pragma mark - Copying

- (id) copyWithZone:(NSZone *)zone
{
    FourLines *copy = [[[self class] allocWithZone:zone] init];
    NSMutableArray *linesCopy = [NSMutableArray array];
    for (id line in self.lines) {
        [linesCopy addObject:[line copyWithZone:zone]];
    }
    copy.lines = linesCopy;
    return copy;
}
@end
