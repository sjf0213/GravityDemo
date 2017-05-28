//
//  MyScene.m
//  GravityDemo
//
//  Created by 宋炬峰 on 2017/5/28.
//  Copyright © 2017年 宋炬峰. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

+ (CCScene *) scene{
    static CCScene *mainMenuScene = nil;
    static dispatch_once_t once = 0L;
    dispatch_once(&once, ^{
        mainMenuScene = [CCScene node];
        
        // 'layer' is an autorelease object.
        MyScene *node = [MyScene node];
        
        
        // add layer as a child to scene
        [mainMenuScene addChild: node];
        
        // return the scene
    });
    
    return mainMenuScene;
}

- (id) init
{
    self = [super init];
    if (!self) return NULL;
    
    self.color = [CCColor colorWithRed:1.0 green:0 blue:0];
    return self;
}

@end
