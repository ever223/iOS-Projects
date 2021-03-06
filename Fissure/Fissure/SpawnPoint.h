//
//  SpawnPoint.h
//  Fissure
//
//  Created by xiaoo_gan on 12/18/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <SpriteKit/SpriteKit.h>
#import "EXDebug.h"
@interface SpawnPoint : NSObject {
    //决定什么时候 spawn
    int frameCount;
}
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) CGSize positionJitter;
@property (nonatomic, assign) CGVector initialVelocity;
@property (nonatomic, assign) float friction;
@property (nonatomic, assign) int frameInterval;

@property (nonatomic, strong) SKSpriteNode *node;

- (id) initWithDictionary:(NSDictionary *)dictionary forSceneSize:(CGSize) sceneSize;
- (BOOL) shouldSpawnThisFrame;
@end
