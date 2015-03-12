//
//  SceneControl.m
//  Fissure
//
//  Created by xiaoo_gan on 12/18/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "SceneControl.h"
#import "FissureScene.h"
#import "EXDebug.h"

// ?
#define CHECK_VALUE(_v) if (!dictionary[_v]) { EXLog(MODEL, WARN, @"字典缺失参数：%@", _v); }

#define WARP_NODE_REDIUS_UNIT   28.4

static NSString *s_controlStrings[NUM_CONTROL_TYPES] = {
    @"push",
    @"gravity",
    @"repel",
    @"propel",
    @"slow",
    @"warp",
    @"shape",
};

@implementation SceneControl

//对各空间进行初始化数据
- (id) initWithDictionary:(NSDictionary *)dictionary forSceneSize:(CGSize)sceneSize {
    if (self = [super init]) {
        float offset = (sceneSize.width > 481) ? 44 : 0;
        sceneSize.width = 480;
        
        _controlType = [self controlTypeForString:dictionary[@"type"]];
        _angle = [dictionary[@"angle"] floatValue];
        _position = CGPointMake([dictionary[@"px"] floatValue] *sceneSize.width + offset, [dictionary[@"py"] floatValue] * sceneSize.height);
        _radius = [dictionary[@"radius"] floatValue] * sceneSize.width;
        _minRadius = [dictionary[@"minRadiusScale"] floatValue] * _radius;
        _maxRadius = [dictionary[@"maxRadiusScale"] floatValue] * _radius;
        _canMove = [dictionary[@"canMove"] boolValue];
        _canRotate = [dictionary[@"canRotate"] boolValue];
        _canScale = [dictionary[@"canScale"] boolValue];
        _power = [dictionary[@"power"] floatValue];
        _powerVector = CGVectorMake(_power * sceneSize.width * cos(_angle), _power * sceneSize.width * sin(_angle));
        
        CHECK_VALUE(@"px");
        CHECK_VALUE(@"py");
        CHECK_VALUE(@"type");
        CHECK_VALUE(@"angle");
        CHECK_VALUE(@"radius");
        CHECK_VALUE(@"minRadiusScale");
        CHECK_VALUE(@"maxRadiusScale");
        CHECK_VALUE(@"canRotate");
        CHECK_VALUE(@"canMove");
        CHECK_VALUE(@"canScale");
        CHECK_VALUE(@"power");
        
        //初始化半径和位置
        _initialRadius = _radius;
        _initialPosition = _position;
        
        //创建范围数组
        _affectedProjectiles = [NSMutableArray array];
        
        //创建这个控制器的参数
        _node = [SKSpriteNode spriteNodeWithImageNamed:@"disc"];
        _node.alpha = 0.1;
        _node.color = [UIColor redColor];
        _node.colorBlendFactor = 1;
        _node.size = CGSizeMake(_radius * 2 , _radius * 2);
        _node.position = _position;
        _node.userData = [NSMutableDictionary dictionaryWithDictionary:@{@"isControl":@(YES), @"control":self}];
        
        _node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_radius];
        _node.physicsBody.friction = 0;
        _node.physicsBody.dynamic = YES;
        _node.physicsBody.collisionBitMask = 0;
        _node.physicsBody.contactTestBitMask = PHYS_CAT_PROJ;
        //创建控制器的图标
        switch (_controlType) {
            case CONTROL_TYPE_PUSH:
                _icon = [SKSpriteNode spriteNodeWithImageNamed:@"disc_push"];
                _icon.zRotation = _angle - (M_PI / 2);  //所指方向
                _node.color = [UIColor colorWithRed:0 green:0.4 blue:1 alpha:1];
                break;
            case CONTROL_TYPE_PROPEL:
                _icon = [SKSpriteNode spriteNodeWithImageNamed:@"disc_propel"];
                _node.color = [UIColor colorWithRed:0 green:1 blue:0.4 alpha:1];
                break;
            case CONTROL_TYPE_SLOW:
                _icon = [SKSpriteNode spriteNodeWithImageNamed:@"disc_slow"];
                _node.color = [UIColor colorWithRed:1 green:0.4 blue:0.4 alpha:1];
                break;
            case CONTROL_TYPE_GRAVITY:
                _icon = [SKSpriteNode spriteNodeWithImageNamed:@"disc_attract"];
                _icon.zRotation = M_PI / 2;
                _node.color = [UIColor colorWithRed:1 green:0.5 blue:0 alpha:1];
                break;
            case CONTROL_TYPE_REPEL:
                _icon = [SKSpriteNode spriteNodeWithImageNamed:@"disc_repel"];
                _icon.zRotation = M_PI / 2;
                _node.color = [UIColor colorWithRed:1 green:0.4 blue:1 alpha:1];
                break;
            case CONTROL_TYPE_WARP: {
                _node.color = [UIColor clearColor];
                // *
                SKEmitterNode *emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"warp" ofType:@"sks"]];
                emitter.particleScale *= (_radius / WARP_NODE_REDIUS_UNIT);
                emitter.particleScaleSpeed *= (_radius / WARP_NODE_REDIUS_UNIT);
                emitter.particleSpeedRange *= (_radius / WARP_NODE_REDIUS_UNIT);
                [_node addChild:emitter];
            }
                break;
                
            case CONTROL_TYPE_SHAPE: {
                _node.alpha = 0.0;
                _shape = [SKShapeNode node];
                NSArray *points = dictionary[@"points"];
                if (!points) {
                    _shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-_radius, -_radius, _radius * 2, _radius * 2)].CGPath;
                    _shape.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_radius];
                } else {
                    BOOL first = YES;
                    UIBezierPath *path = [UIBezierPath bezierPath];
                    for (NSDictionary *point in points) {
                        float angle = [point[@"angle"] floatValue];
                        float radius = [point[@"radius"] floatValue];
                        float px = [point[@"px"] floatValue];
                        float py = [point[@"py"] floatValue];
                        if(first) {
                            [path moveToPoint:CGPointMake(px, py)];
                            first = NO;
                        } else {
                            [path addLineToPoint:CGPointMake(px, py)];
                        }
                    }
                    [path closePath];
                    _shape.path = path.CGPath;
                    _shape.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path.CGPath];
                }
                _shape.zRotation = _angle;
                _shape.antialiased = YES;
                _shape.fillColor = [UIColor colorWithWhite:0.5 alpha:0.3];
                _shape.strokeColor = [UIColor colorWithWhite:0.5 alpha:0.7];
                _shape.lineWidth = 1;
                _shape.position = _position;
                
                _shape.physicsBody.friction = 0;
                _shape.physicsBody.dynamic = YES;
                _shape.physicsBody.categoryBitMask = PHYS_CAT_CONTROL_COLL;
                _shape.physicsBody.collisionBitMask = 0;
                _shape.physicsBody.contactTestBitMask = 0;
                
                _node.physicsBody.categoryBitMask = 0;
                _node.physicsBody.contactTestBitMask = 0;
                _node.physicsBody.collisionBitMask = 0;
            }
                break;
                
            default:
                break;
        }
        if (_icon) {
            _icon.color = [UIColor colorWithWhite:0 alpha:0.3];
            _icon.colorBlendFactor =1;
            _icon.position = _position;
        }
    }
    return self;
}

// 控制器类型的字符
- (ControlType_t) controlTypeForString:(NSString *)cString {
    for (int i = 0; i < NUM_CONTROL_TYPES; i ++) {
        if ([cString isEqualToString:s_controlStrings[i]]) {
            return i;
        }
    }
    EXLog(MODEL, WARN, @"无效的控制器类型:%@", cString);
    return CONTROL_TYPE_PUSH;
}

- (void) setPosition:(CGPoint)position {
    _position = position;
    
    //更新节点位置
    _node.position = position;
    _shape.position = position;
    _icon.position = position;
    
}
- (void) setRadius:(float)radius {
    if (radius < _minRadius) {
        radius = _minRadius;
    }
    if (radius > _maxRadius) {
        radius = _maxRadius;
    }
    if (radius == _radius) {
        return;
    }
    
    _radius = radius;
    //设置半径大小
    [_node setScale:_radius / _initialRadius];
}

- (void) updateAffectedProjectilesForDuration:(CFTimeInterval)duration {
    switch (_controlType) {
        case CONTROL_TYPE_PUSH: {
            float xmag = _powerVector.dx * duration;
            float ymag = _powerVector.dy * duration;
            for (SKNode *node in _affectedProjectiles) {
                node.physicsBody.velocity = CGVectorMake(node.physicsBody.velocity.dx + xmag, node.physicsBody.velocity.dy + ymag);
                node.zRotation = atan2(node.physicsBody.velocity.dy, node.physicsBody.velocity.dx);
            }
            break;
        }
        case CONTROL_TYPE_PROPEL: {
            float multiplier = 1 + _power * duration;
            for (SKNode *node in _affectedProjectiles) {
                node.physicsBody.velocity = CGVectorMake(node.physicsBody.velocity.dx * multiplier, node.physicsBody.velocity.dy * multiplier);
            }
            break;
        }
        case CONTROL_TYPE_SLOW: {
            float mutiplier = 1 - _power * duration;
            NSMutableArray *toRemove = [NSMutableArray array];
            for (SKNode *node in _affectedProjectiles) {
                node.physicsBody.velocity = CGVectorMake(node.physicsBody.velocity.dx * mutiplier, node.physicsBody.velocity.dy * mutiplier);
                if (fabs(node.physicsBody.velocity.dx) < 3 && fabs(node.physicsBody.velocity.dy) < 3) {
                    [toRemove addObject:node];
                }
            }
            if([toRemove count]) {
                for (SKNode *node in toRemove) {
                    [_affectedProjectiles removeObjectIdenticalTo:node];
                    [node removeFromParent];
                }
            }
            break;
        }
        case CONTROL_TYPE_GRAVITY: {
            
            break;
        }
        case CONTROL_TYPE_REPEL: {
            
            break;
        }
        case CONTROL_TYPE_WARP: {
            
            break;
        }
            
        default:
            break;
    }
}
@end
































