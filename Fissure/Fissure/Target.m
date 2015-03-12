//
//  Target.m
//  Fissure
//
//  Created by xiaoo_gan on 12/18/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "Target.h"

#define CHECK_VALUE(_v) if (!dictionary[_v]) { EXLog(MODEL, WARN, @"Target字典缺失参数： %@", _v ); }

#define TARGET_RADIUS 20
#define DIALS_PER_TARGET 7
#define NUM_DIAL_IMAGES 7


@implementation Target

- (id) initWithDictionary:(NSDictionary *)dictionary forSceneSize:(CGSize)sceneSize {
    if ((self = [super init])) {
        float offset = (sceneSize.width > 481) ? 44 : 0;
        sceneSize.width = 480;
        _position = CGPointMake([dictionary[@"px"] floatValue] * sceneSize.width + offset, [dictionary[@"py"] floatValue] *sceneSize.height);
        _matchedFissure = [dictionary[@"matchedFissure"] intValue];
        
        CHECK_VALUE(@"px");
        CHECK_VALUE(@"py");
        CHECK_VALUE(@"matchedFissure");
        
        //初始化各参数
        _progress = 0;
        _hysteresis = 1;
        _progressPerHit = 0.5;
        _lastHitTime = 0;
        _lossPerTime = 0.6;
        
        //转盘数组
        _dials = [NSMutableArray array];
        
        //为这个控制器创建节点
        _node = [SKNode node];
        _node.position = _position;
        _node.userData = [NSMutableDictionary dictionaryWithDictionary:@{@"isTarget":@(YES), @"target":self}];
        _node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:TARGET_RADIUS];
        _node.physicsBody.dynamic = YES;
        _node.physicsBody.categoryBitMask = PHYS_CAT_TARGET;
        _node.physicsBody.collisionBitMask = 0;
        _node.physicsBody.contactTestBitMask = 0;
        _node.physicsBody.friction = 0;
        
        // 创建转盘 7个转盘零件
        static float dial_factor[DIALS_PER_TARGET] = {1, 0.8, 1, 0.4, 1, 0.6, 1 };
        for (int i = 0; i < DIALS_PER_TARGET; i ++) {
            SKSpriteNode *dial = [SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"activity_disc_%d", i]];
            //坐标为（0，0）
            dial.position = CGPointZero;
            //设置颜色 黑色
            dial.color = [UIColor blackColor];
            //设置颜色混合因子 最大
            dial.colorBlendFactor = 1;
            //设置透明度
            dial.alpha = 0.15;
            //设置大小
            dial.size = CGSizeMake(TARGET_RADIUS * 2 * dial_factor[i], TARGET_RADIUS * 2 * dial_factor[i]);
            //初始旋转角度
            dial.zRotation = rand() % 1000 / 1000.0 * 2 * M_PI;
            
            dial.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:TARGET_RADIUS];
            dial.physicsBody.dynamic = YES;
            dial.physicsBody.categoryBitMask = 0;
            dial.physicsBody.collisionBitMask = 0;
            dial.physicsBody.contactTestBitMask = 0;
            dial.physicsBody.angularVelocity = 0;
            dial.physicsBody.affectedByGravity = NO;
            dial.physicsBody.friction = 0;
            dial.physicsBody.angularDamping = 0;
            
            //将该转盘零件添加到该转盘
            [_node addChild:dial];
            //添加该转盘到数组
            [_dials addObject:dial];
        }
    }
    return self;
}
//设置转盘颜色
- (void) setColor:(UIColor *)color {
    _color = color;
    //为每个小零件设置颜色
    for (SKSpriteNode *dial in _dials) {
        dial.color = color;
        dial.alpha = 0.4;
    }
}
//被发射物击中持续时间
- (void) hitByProjectile {
    accelToTime = _currentTime + 0.1;
}
- (void) updateForDuration:(CFTimeInterval)duration {
    _currentTime += duration;
    //是否被击中？
    if (_currentTime < accelToTime) {
        _lastHitTime = _currentTime;
        
        //
        if (_progress < 1) {
            _progress += _progressPerHit * duration;
            if (_progress > 1) {
                _progress = 1;
            }
        }
    }
    //是否完成？
    if (_progress >= 1) {
        _timeFull += duration;
    } else {
        _timeFull = 0;
    }
    //如果不动了，则不必更新他的累积时间
    if (_progress <= 0) {
        return;
    }
    CFTimeInterval sinceLastHit = _currentTime - _lastHitTime;
    if (sinceLastHit > _hysteresis) {
        _progress -= (duration * _lossPerTime);
    }
    [self updateDialSpeed];
}
- (void) updateDialSpeed {
    int i = 0;
    for (SKSpriteNode *dial in _dials) {
        dial.physicsBody.angularVelocity = 4 * ((i < 3) ? 1 : -1) * (float)(i + 2) / DIALS_PER_TARGET * _progress;
        i ++;
    }
}
//控制器移开后，则计时归零
- (void) controlMoved {
    _timeFull = 0;
}

@end






















