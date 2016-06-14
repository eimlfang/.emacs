//
//  GameScene.h
//  FG2DLibrary
//

//  Copyright (c) 2015年 Fang Zijian. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#define kTargetNodeName @"kTargetNode"

typedef NS_ENUM(NSInteger, FGMoveType) {
    FGMoveTypeNone,
    FGMoveTypeFinger,
    FGMoveTypeController
};

typedef NS_ENUM(NSInteger, FGMoveDirection) {
    FGMoveDirectionNone,
    FGMoveDirectionLeft,
    FGMoveDirectionRight,
    FGMoveDirectionUp,
    FGMoveDirectionDown
};

@interface GameScene : SKScene
{
    FGMoveType _moveType;
    FGMoveDirection _moveDirection;
}


@end
