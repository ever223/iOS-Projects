//
//  Fissure.m
//  Fissure
//
//  Created by xiaoo_gan on 12/18/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "Fissure.h"

#define CHECK_VALUE(_v) if (!dictionary[_v]) { EXLog(MODEL,WARN, @"墨迹字典缺失参数：%@",_v); }

@implementation Fissure

- (id) initWithDictionary:(NSDictionary *)dictionary forSceneSize:(CGSize)sceneSize {
    if ((self = [super init])) {
        float offset = (sceneSize.width > 481) ? 44 : 0;
        sceneSize.width = 480;
        self.position = CGPointMake([dictionary[@"px"] floatValue] * sceneSize.width + offset, [dictionary[@"py"] floatValue] * sceneSize.height);
        float radius = [dictionary[@"radius"] floatValue] * sceneSize.width;
        
        NSDictionary *colorDic = dictionary[@"color"];
        //读取颜色
        _color = [UIColor colorWithRed:[colorDic[@"r"] floatValue] green:[colorDic[@"g"] floatValue] blue:[colorDic[@"b"] floatValue] alpha:[colorDic[@"a"] floatValue]];
        
        CHECK_VALUE(@"px");
        CHECK_VALUE(@"py");
        CHECK_VALUE(@"radius");
        self.zPosition = 1;
        
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
        self.physicsBody.dynamic =YES;
        self.physicsBody.categoryBitMask = PHYS_CAT_FISSURE;
        self.physicsBody.collisionBitMask = 0;
        self.physicsBody.contactTestBitMask = 0;
        self.physicsBody.friction = 0;
        //制作发射物特效
        SKEmitterNode *emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"fissure" ofType:@"sks"]];
        emitter.particleColorSequence = [self sequenceForColor:_color];
        [self addChild:emitter];
    }
    return self;
    
}
- (SKKeyframeSequence *) sequenceForColor:(UIColor *) color {
    CGFloat r, g, b,a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    return [[SKKeyframeSequence alloc] initWithKeyframeValues:@[[UIColor colorWithRed:r green:g blue:b alpha:0.5], [UIColor colorWithWhite:0.4 alpha:0]] times:@[@(0), @(1)]];
}
@end













