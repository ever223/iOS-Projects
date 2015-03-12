//
//  GameViewController.m
//  Fissure
//
//  Created by xiaoo_gan on 12/18/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@interface GameViewController ()

@end

@implementation GameViewController

SINGLETON_IMPL(GameViewController);

- (id) init {
    if ((self = [super init])) {
        self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)];
        //设置背景颜色为红色
        self.view.backgroundColor = [UIColor redColor];
        
        sceneView = [[SKView alloc] initWithFrame:self.view.bounds];
        sceneView.showsFPS = YES;           //不显示帧速
        sceneView.showsNodeCount = YES;     //不显示节点数
        sceneView.showsDrawCount = YES;     //
        
        [self.view addSubview:sceneView];   //添加场景视图
        
        scene = [[GameScene alloc] initWithSize:self.view.bounds.size];
        scene.sceneDelegate = self;         //设置场景代理
        [sceneView presentScene:scene];     //显示场景
        
        
//        //菜单按钮
//        menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        //菜单按钮frame
//        menuButton.frame = CGRectMake(self.view.bounds.size.width - 40, 0, 40, 40);
//        //添加菜单按钮事件
//        [menuButton addTarget:self action:@selector(pressedMenu:) forControlEvents:UIControlEventTouchUpInside];
//        //菜单按钮添加到视图中
//        [self.view addSubview:menuButton];
//        //菜单按钮图标
//        UIImageView *mImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_menu"]];
//        mImage.frame = CGRectMake(15, 5, 20, 20);
//        mImage.alpha = 0.25;
//        //添加图标到菜单
//        [menuButton addSubview:mImage];
//        
//        //重新开始按钮
//        restartButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        //按钮边界范围
//        restartButton.frame = CGRectMake(self.view.bounds.size.width - 40, self.view.bounds.size.height - 40, 40, 40);
//        //添加按钮事件
//        [restartButton addTarget:self action:@selector(pressedRestart:) forControlEvents:UIControlEventTouchUpInside];
//        //将重新开始按钮添加到视图中
//        [self.view addSubview:restartButton];
//        //重新开始按钮图标
//        UIImageView *rImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_restart"]];
//        //图标大小
//        rImage.frame = CGRectMake(15, 15, 20, 20);
//        //图标透明度
//        rImage.alpha = 0.25;
//        //为按钮设置图标
//        [restartButton addSubview:rImage];
    }
    return self;
}

- (void) pressedMenu:(UIButton *) button {
    
}
- (void) pressedRestart:(UIButton *) button {
    
}


@end


































