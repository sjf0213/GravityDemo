//
//  MyScene.m
//  GravityDemo
//
//  Created by 宋炬峰 on 2017/5/28.
//  Copyright © 2017年 宋炬峰. All rights reserved.
//

#import "MyScene.h"
#import "Box2D.h"
#import "Box2DExamples.h"
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
@interface MyScene(){
    b2World *world;
}
@end
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

-(void)draw:(CCRenderer *)renderer transform:(const GLKMatrix4 *)transform{
    [super draw:renderer transform:transform];
    
    // Draw the raycast
    glColor4ub(255, 0, 0, 255);
    //ccDrawLine(CGPointMake(0, 0), CGPointMake(200, 200));
}

- (id) init
{
    self = [super init];
    if (!self) return NULL;
    
    self.color = [CCColor colorWithRed:1.0 green:0 blue:0];
    
    // Header background
    CCSprite9Slice* headerBg = [CCSprite9Slice spriteWithImageNamed:@"header.png"];
    headerBg.positionType = CCPositionTypeMake(CCPositionUnitUIPoints, CCPositionUnitUIPoints, CCPositionReferenceCornerTopLeft);
    headerBg.position = ccp(0,0);
    headerBg.anchorPoint = ccp(0,1);
    headerBg.contentSizeType = CCSizeTypeMake(CCSizeUnitNormalized, CCSizeUnitUIPoints);
    headerBg.contentSize = CGSizeMake(1, 44);
    
    [self addChild:headerBg];
    
    // Init the box2d world
    [self initWorld];
    
    // Get the screen size
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    
    // Defines the boxes size
    CGSize size12 = CGSizeMake(screenSize.height / 2, screenSize.height / 2);

    [self addBoxWithFrame:
     CGRectMake(ptm(screenSize.width / 2), ptm(size12.height), ptm(size12.width), ptm(size12.height))];
    
//    [self schedule:@selector(update:) interval:0.1];
    return self;
}

//- (void)update:(CCTime)dt
//{
//    // It is recommended that a fixed time step is used with Box2D for stability
//    // of the simulation, however, we are using a variable time step here.
//    // You need to make an informed choice, the following URL is useful
//    // http://gafferongames.com/game-physics/fix-your-timestep/
//    
//    int32 velocityIterations = 6;
//    int32 positionIterations = 2;
//    
//    // Instruct the world to perform a single step of simulation. It is
//    // generally best to keep the time step and iterations fixed
//    world->Step(dt, velocityIterations, positionIterations);
//    world->ClearForces();
//}

- (void)initWorld
{
    // Get the screen size
    CGSize screenSize = [CCDirector sharedDirector].viewSize;
    
    // Define the gravity vector
    b2Vec2 gravity = b2Vec2(0.0f, -10.0f);
    
    // Do we want to let bodies sleep?
    // This will speed up the physics simulation
    //bool doSleep = false;
    
    // Construct a world object, which will hold and simulate the rigid bodies
    world = new b2World(gravity);
    world->SetContinuousPhysics(true);
    
    // Debug Draw functions
        uint32 flags = 0;
    flags += b2Draw::e_shapeBit;
    flags += b2Draw::e_jointBit;
    flags += b2Draw::e_centerOfMassBit;
    
   
    // Define the ground body
    b2BodyDef groundBodyDef;
    groundBodyDef.position.Set(0, 0); // bottom-left corner
    
    // Call the body factory which allocates memory for the ground body
    // from a pool and creates the ground box shape (also from a pool).
    // The body is also added to the world
    b2Body* groundBody = world->CreateBody(&groundBodyDef);
    
    // Define the ground box shape.
    b2PolygonShape groundBox;
    
    // Bottom
    groundBox.SetAsBox(ptm(screenSize.width / 2), ptm(1.0f), b2Vec2(ptm(screenSize.width / 2), 0.0f), 0.0f);
    groundBody->CreateFixture(&groundBox, 0);
    
    // Top
    groundBox.SetAsBox(ptm(screenSize.width / 2), ptm(1.0f), b2Vec2(ptm(screenSize.width / 2), ptm(screenSize.height)), 0.0f);
    groundBody->CreateFixture(&groundBox, 0);
    
    // Left
    groundBox.SetAsBox(ptm(1.0f), ptm(screenSize.height / 2), b2Vec2(0, ptm(screenSize.height / 2)), 0.0f);
    groundBody->CreateFixture(&groundBox, 0);
    
    // Right
    groundBox.SetAsBox(ptm(1.0f), ptm(screenSize.height / 2), b2Vec2(ptm(screenSize.width), ptm(screenSize.height / 2)), 0.0f);
    groundBody->CreateFixture(&groundBox, 0);
}

- (void)addBoxWithFrame:(CGRect)frame
{
    struct b2BodyDef bd;
    
    bd.type = b2_dynamicBody;
    bd.position.Set(frame.origin.x, frame.origin.y);
    
    b2CircleShape box;
    box.m_radius = ptm(12.5f);
    
    struct b2FixtureDef fixtureDef;
    
    fixtureDef.shape = &box;
    fixtureDef.density = 1.0f;
    fixtureDef.friction = 0.4f;
    fixtureDef.restitution = 0.3f;
    //bd.position.Set(ptm(A.x), ptm(A.y));
    b2Body *head = world->CreateBody(&bd);
    head->CreateFixture(&fixtureDef);
}

@end
