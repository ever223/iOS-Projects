//
//  FissureScene.h
//  Fissure
//
//  Created by xiaoo_gan on 12/18/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "SceneControl.h"
#import "SpawnPoint.h"
#import "Fissure.h"
#import "Target.h"

#define PHYS_CAT_EDGE               0x0001
#define PHYS_CAT_PROJ               0x0002
#define PHYS_CAT_TARGET             0x0004
#define PHYS_CAT_FISSURE            0X0008

#define PHYS_CAT_CONTROL_TRANS      0x0100
#define PHYS_CAT_CONTROL_COLL       0x0200

#define PROJECTILE_PHYS_RADIUS      3

@protocol GameSceneDelegate <NSObject>
- (void) sceneAllTargetsLit;
- (void) sceneReadyToTransition;
@end

@interface GameScene : SKScene <SKPhysicsContactDelegate> {
    //?
    CFTimeInterval lastFrameTime;
    //?
    SKNode *projectileParticleLayerNode;
    SKNode *projectileLayerNode;
    
    //正在拖拽的控制器
    SceneControl *draggedControl;
    CGPoint dragOffset;
    //正在缩放的控制器
    SceneControl *scalingControl;
    float scalingOffset;
    
    //判断是否触发最大化
    BOOL canTriggerFull;
    
    //
    BOOL shouldSpawnProjectile;
    
}

@property (nonatomic, readonly) NSMutableArray *spawnPoints;
@property (nonatomic, readonly) NSMutableArray *controls;
@property (nonatomic, readonly) NSMutableArray *targets;
@property (nonatomic, readonly) NSMutableArray *fissures;
@property (nonatomic, readonly) NSMutableArray *staticImages;

@property (nonatomic, weak) id<GameSceneDelegate> sceneDelegate;

- (void) loadFromLevelDictionary: (NSDictionary *)level;
- (void) removeNodeFromAllControlsNotInRange:(SKNode *)node;
- (void) resetControlsToInitialPositions;
- (void) forceWin;

@end
