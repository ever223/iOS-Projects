//
//  FissureScene.m
//  Fissure
//
//  Created by xiaoo_gan on 12/18/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "GameScene.h"

#define SCALE_RADIUS_WIDTH 20


@implementation GameScene

- (id) initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        //背景颜色
        self.backgroundColor = [SKColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.0];
        
        //初始化物理世界
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        //
        self.physicsWorld.contactDelegate = self;
        //创建出墨点对象数组
        _spawnPoints = [NSMutableArray array];
        //创建控制器对象数组
        _controls = [NSMutableArray array];
        //创建转盘对象数组
        _targets = [NSMutableArray array];
        //创建墨迹对象对象数组
        _fissures = [NSMutableArray array];
        //创建静态图片对象数组
        _staticImages = [NSMutableArray array];
        //初始化定时器
        lastFrameTime = 0;
        
        //创建视图边界范围
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectInset(self.frame, -150, -100)];
        self.physicsBody.categoryBitMask = PHYS_CAT_EDGE;
        
    }
    return self;
}

////加载地图数据
//- (void) loadFromLevelDictionary:(NSDictionary *)level {
//    
//    CGSize screenSize = self.size;
//    
//    for (NSDictionary *staticDic in level[@"static"]) {
//        NSString *image = staticDic[@"image"];
//        SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:image];
//        node.alpha = 0;
//        [self addChild:node];
//        node.position = CGPointMake(self.size.width / 2, self.size.height / 2);
//        [node animateToAlpha:0.65 delay:1.5 duration:1.5];
//        [_staticImages addObject:node];
//    }
//    
//    //创建 发射物粒子图层
//    projectileParticleLayerNode = [SKNode node];
//    projectileParticleLayerNode.position = CGPointMake(50, 200);
//    [self addChild:projectileParticleLayerNode];
//    
//    projectileLayerNode = [SKNode node];
//    projectileLayerNode.zPosition = 0.5;
//    [self addChild:projectileLayerNode];
//    
//    //显示发射物图层
//    projectileParticleLayerNode.alpha = 1;
//    projectileLayerNode.alpha = 1;
//    // 容许
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        shouldSpawnProjectile = YES;
//    });
//    
//    //出墨点对象数组
//    NSArray *spawnDics = level[@"spawns"];
//    //出墨点号
//    int spawnIndex = 0;
//    //将地图中的出墨点添加到当前地图中去
//    for (NSDictionary *dic in spawnDics) {
//        //初始化出墨点
//        SpawnPoint *spawn = [[SpawnPoint alloc] initWithDictionary:dic forSceneSize:screenSize];
//        //添加到当前出墨点对象数组
//        [_spawnPoints addObject:spawn];
//        EXLog(MODEL, DBG, @"在点（%.2f, %.2f）添加出墨点",  spawn.position.x, spawn.position.y);
//         //在地图上，添加出墨点
//        [self addChild:spawn.node];
//        
//        float delay = 0.1 + (spawnIndex * 0.25);
//        spawnIndex ++;
//        spawn.node.alpha = 0;
//        [spawn.node bounceInAfterDelay:delay duration:0.9 bounces:5];
//        [spawn.node animateToAlpha:0.1 delay:delay duration:0.4];
//    }
//    //从选择地图中获得控制器数组对象
//    NSArray *controlDics = level[@"controls"];
//    NSMutableArray *warps = [NSMutableArray array];
//    //控制器号
//    int controlIndex = 0;
//    // 将控制器添加到当前地图中去
//    for (NSDictionary *dic in controlDics) {
//        
//        if ([dic[@"ignore"] boolValue]) {
//            continue;
//        }
//        //创建控制器
//        SceneControl *control = [[SceneControl alloc] initWithDictionary:dic forSceneSize:screenSize];
//        //设置控制器的场景为当前
//        control.scene = self;
//        //添加控制器到对象数组中
//        [_controls addObject:control];
//        EXLog(MODEL, DBG, @"在点（%.2f, %.2f）添加控制器：%d", control.position.x, cont .position.y, control.controlType);
//        //在地图上，添加控制器
//        //节点
//        if (control.node) {
//            [self addChild:control.node];
//        }
//        //图标
//        if (control.icon) {
//            [self addChild:control.icon];
//        }
//        //范围形状
//        if (control.shape) {
//            [self addChild:control.shape];
//        }
//        if (control.controlType == CONTROL_TYPE_WARP) {
//            [warps addObject:control];
//        }
//        
//        float delay = 0.1 + (controlIndex * 0.1);
//        controlIndex ++;
//        //透明度都设置为0 即不显示
//        control.node.alpha = 0;
//        control.icon.alpha = 0;
//        control.shape.alpha = 0;
//        
//        //设置显示动画
//        [control.node bounceInAfterDelay:delay duration:0.9 bounces:5];
//        if (control.controlType != CONTROL_TYPE_SHAPE) {
//            [control.node animateToAlpha:0.1 delay:delay duration:0.4];
//        }
//        [control.icon bounceInAfterDelay:delay duration:0.9 bounces:5];
//        [control.icon animateToAlpha:1 delay:delay duration:0.4];
//        [control.shape bounceInAfterDelay:delay duration:0.9 bounces:5];
//        [control.shape animateToAlpha:1 delay:delay duration:0.4];
//        
//    }
//    
//    //
//    NSArray *fissureDics = level[@"fissures"];
//    int fissureIndex = 1;
//    for (NSDictionary *dic in fissureDics) {
//        Fissure *fissure = [[Fissure alloc] initWithDictionary:dic forSceneSize:screenSize];
//        fissure.fissureIndex = fissureIndex;
//        [_fissures addObject:fissure];
//        EXLog(MODEL, DBG, @"在点（%.2f, %.2f）加载fissure", fissure.position.x, fissure.position.y);
//        //在地图上，显示喷墨源
//        [self addChild:fissure];
//        //喷墨源id ＋1
//        fissureIndex ++;
//        //显示延迟时间
//        float delay = 0.25 + (fissureIndex * 0.25);
//        //初始化 不显示
//        fissure.alpha = 0;
//        //动画显示
//        [fissure animateToAlpha:1 delay:delay duration:1.5];
//    }
//    
//    NSArray *targetDics = level[@"targets"];
//    int targetIndex = 0;
//    for (NSDictionary *dic in targetDics) {
//        Target *target = [[Target alloc] initWithDictionary:dic forSceneSize:screenSize];
//        if (target.matchedFissure) {
//            target.color = ((Fissure *) _fissures[target.matchedFissure - 1]).color;
//        }
//        //将转盘添加到当前转盘数组
//        [_targets addObject:target];
//        
//        EXLog(MODEL, DBG, "在点（%.2f, %.2f）加载转盘", target.position.x, target.position.y);
//        //将转盘添加到当前地图上
//        [self addChild:target.node];
//        
//        //动画显示转盘
//        float delay = 0.1 + (targetIndex * 0.15);
//        targetIndex ++;
//        target.node.alpha = 0;
//        [target.node bounceInAfterDelay:delay duration:0.9 bounces:5];
//        [target.node animateToAlpha:1 delay:delay duration:0.4];
//    }
//    
//    //连接warp 区域
//    if ([warps count]== 0) {
//        EXLog(MODEL, DBG, @"没有warp区域");
//    } else if ([warps count] % 2 == 0) {
//        for (int i = 0; i < [warps count]; i += 2) {
//            SceneControl *w1 = warps[i];
//            SceneControl *w2 = warps[i + 1];
//            w1.connectedWarp = w2;
//            w2.connectedWarp = w1;
//        }
//    } else {
//        EXLog(MODEL, DBG, @"warp总数不正确: %d", (int) [warps count]);
//    }
//    
//    //容许全触发
//    canTriggerFull = YES;
//}
//
//- (void) forceWin {
//    [self allTargetsFull];
//}
//
////所有的转盘都已经被触发
//- (void) allTargetsFull {
//    if (!canTriggerFull) {
//        return;
//    }
//    canTriggerFull = NO;
//    [self levelOverStageOne];
//    
//}
//
//- (void) levelOverStageOne {
//    //首先显示静态图片
//    for (SKNode *node in _staticImages) {
//        [node animateToAlpha:0 delay:0 duration:0.5];
//    }
//    //显示控制器
//    int controlIndex = 0;
//    for (SceneControl *control in _controls) {
//        float delay = 0.5 + controlIndex * 0.15;
//        [control.node bounceInAfterDelay:delay - 0.25 duration:0.9 bounces:2];
//        [control.icon bounceInAfterDelay:delay - 0.25 duration:0.9 bounces:2];
//        [control.shape bounceInAfterDelay:delay - 0.25 duration:0.9 bounces:2];
//        [control.node animateToAlpha:0 delay:delay duration:0.5];
//        [control.icon animateToAlpha:0 delay:delay duration:0.5];
//        [control.shape animateToAlpha:0 delay:delay duration:0.5];
//        controlIndex ++;
//    }
//    //显示发射物
//    [projectileLayerNode animateToAlpha:0 delay:0 duration:0.75];
//    [projectileParticleLayerNode animateToAlpha:0 delay:0 duration:0.75];
//    
//    //延迟一秒开始发射
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        shouldSpawnProjectile = NO;
//    });
//    //  显示转盘
//    int targetIndex = 0;
//    for (Target *target in _targets) {
//        float delay = 1 + targetIndex * 0.15;
//        [target.node animateToAlpha:0 delay:delay duration:0.5];
//        [target.node animateToScale:0.5 delay:delay duration:0.5];
//        targetIndex ++;
//    }
//    // 显示出墨源
//    int fissureIndex = 0;
//    for (Fissure * fissure in _fissures) {
//        float delay = 1 + fissureIndex * 0.15;
//        [fissure animateToAlpha:0 delay:delay duration:0.5];
//        [fissure animateToScale:0.5 delay:delay duration:0.5];
//        fissureIndex ++;
//    }
//    //显示spawn
//    int spawnIndex = 0;
//    for (SpawnPoint * spawn in _spawnPoints) {
//        float delay = 1 + spawnIndex * 0.15;
//        [spawn.node animateToAlpha:0 delay:delay duration:0.5];
//        [spawn.node animateToScale:0.5 delay:delay duration:0.5];
//        spawnIndex ++;
//    }
//}
//
//
//- (void) removeNodeFromAllControlsNotInRange:(SKNode *)node {
//    for (SceneControl *control in _controls) {
//        
//        if (control.controlType == CONTROL_TYPE_WARP) {
//            continue;
//        }
//        //x轴方向上的距离
//        float dx = node.position.x - control.position.x;
//        //y轴方向上的距离
//        float dy = node.position.y - control.position.y;
//        //距离
//        float dist = sqrt(dx * dx + dy * dy);
//        //如果距离大于控制器的控制半径，则移除
//        if (dist > control.radius) {
//            [control.affectedProjectiles removeObjectIdenticalTo:node];
//        }
//    }
//}
//
////重置转盘的位置
//- (void) resetControlsToInitialPositions {
//    for (SceneControl *control in _controls) {
//        
//        [control.node bounceToPosition:control.initialPosition scale:1 delay:0 duration:1.1 bounces:5];
//        [control.icon bounceToPosition:control.initialPosition scale:1 delay:0 duration:1.1 bounces:5];
//        [control.shape bounceToPosition:control.initialPosition scale:1 delay:0 duration:1.1 bounces:5];
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            control.position = control.initialPosition;
//            control.radius = control.initialRadius;
//        });
//        
//    }
//}

@end



























