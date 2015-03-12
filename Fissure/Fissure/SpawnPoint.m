//
//  SpawnPoint.m
//  Fissure
//
//  Created by xiaoo_gan on 12/18/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "SpawnPoint.h"

#define CHECK_VALUE(_v) if (!dictionary[_v]) { EXLog(MODEL, WARN, @"出墨点 丢失参数：%@", _v); }

@implementation SpawnPoint

- (id) initWithDictionary:(NSDictionary *)dictionary forSceneSize:(CGSize)sceneSize {
    if ((self = [super init])) {
        float offset = (sceneSize.width > 481) ? 44 : 0;
        sceneSize.width = 480;
        
        //出墨点的位置
        _position = CGPointMake([dictionary[@"px"] floatValue] * sceneSize.width + offset, [dictionary[@"py"] floatValue] * sceneSize.height);
        //
        _positionJitter = CGSizeMake([dictionary[@"jx"] floatValue] * sceneSize.width, [dictionary[@"jy"] floatValue] * sceneSize.height);
        
        _friction = [dictionary[@"friction"] floatValue];
        _frameInterval = [dictionary[@"frameInterval"] intValue];
        
        //角度方向
        float angle = [dictionary[@"angle"] floatValue];
        //速度大小
        float speed = [dictionary[@"speed"] floatValue] * sceneSize.width;
        //初始化xy方向上的速率
        _initialVelocity = CGVectorMake(cos(angle) * speed, sin(angle) * speed);
        
        //CHECK_VALUE(_v) 各个参数
        CHECK_VALUE(@"px");
        CHECK_VALUE(@"py");
        CHECK_VALUE(@"jx");
        CHECK_VALUE(@"jy");
        CHECK_VALUE(@"friction");
        CHECK_VALUE(@"frameInterval");
        CHECK_VALUE(@"angle");
        CHECK_VALUE(@"speed");
        
        _frameInterval = 1;
        
        //创建出墨点
        _node = [SKSpriteNode spriteNodeWithImageNamed:@"disc"];
        //设置透明度为0.1
        _node.alpha = 0.1;
        //设置颜色 默认为黑色
        _node.color = [UIColor blackColor];
        //设置颜色混合因子 最大 = 1
        _node.colorBlendFactor = 1;
        //设置出墨点的大小
        _node.size = CGSizeMake(MAX(_positionJitter.width, _positionJitter.height) + 5, MAX(_positionJitter.width, _positionJitter.height) + 5);
        //设置出墨点的位置
        _node.position = _position;
    }
    return self;
}
- (BOOL) shouldSpawnThisFrame {
    frameCount ++;
    if (frameCount > _frameInterval) {
        frameCount = 1;
        return YES;
    }
    return NO;
}
@end
