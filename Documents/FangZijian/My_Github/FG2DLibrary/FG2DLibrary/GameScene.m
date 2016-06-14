//
//  GameScene.m
//  FG2DLibrary
//
//  Created by Besprout's Mac Mini on 15/10/13.
//  Copyright (c) 2015年 Fang Zijian. All rights reserved.
//

#import "GameScene.h"
#import "FGSceneConfig.h"
@interface GameScene(){
    FGSceneConfig *_thisConfig;
    SKSpriteNode *_selectedNode;
}

@end
@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    [self fgSetGameMoveType:FGMoveTypeFinger];
    _thisConfig = [[FGSceneConfig alloc] init];
    [self addTestSprite];

}
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [self fgUpdate];
}

#pragma mark - FGManager

- (void)fgSetGameMoveType:(FGMoveType)type
{
    _moveType = type;
    [self fgDidMoveToView];
}

- (void)fgDidMoveToView{
    [self fgMoveTypeBlocks:_moveType withController:^{
        _selectedNode = (SKSpriteNode *)[self childNodeWithName:kTargetNodeName];
    } finger:^{
        _selectedNode = nil;
    }];
}

- (void)fgMoveTypeBlocks:(FGMoveType)moveType withController:(void (^)(void))controller finger:(void (^)(void))finger{
    switch (_moveType) {
        case FGMoveTypeController:
            // 控制器动作回调
            if (controller) {
                controller();
            }
            break;
        case FGMoveTypeFinger:
            // 手指动作回调
            if (finger) {
                finger();
            }
            break;
        case FGMoveTypeNone:break;
        default:
            break;
    }
}

- (void)fgTouchBegan:(NSSet *)touches
{
    //    [self selectNodeForTouch:touches];
    
    [self fgMoveTypeBlocks:_moveType withController:^{
        [self moveDirectionWithTouch:touches];
    } finger:^{
        [self selectNodeForTouch:touches];
    }];
    //    switch (_moveType) {
    //        case FGMoveTypeController:
    //            break;
    //        case FGMoveTypeFinger:
    //            [self selectNodeForTouch:touches];
    //
    //            break;
    //        case FGMoveTypeNone:break;
    //        default:
    //            break;
    //    }
}
- (void)fgTouchMoved:(NSSet *)touches
{
    [self fgMoveTypeBlocks:_moveType withController:^{
        [self moveDirectionWithTouch:touches];
    } finger:^{
        [self dragNode:touches];
    }];
}
- (void)fgTouchEnded:(NSSet *)touches
{}

- (void)fgUpdate{
    [self fgMoveTypeBlocks:_moveType withController:^{
        // 只支持左右平移的时候
    [self moveAction:_moveDirection];
        
    } finger:^{
        
    }];
}

#pragma mark - Touch
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self fgTouchBegan:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self fgTouchMoved:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    _moveDirection = FGMoveDirectionNone;
    [self fgTouchEnded:touches];
}

#pragma mark - Node
- (void)selectNodeForTouch:(NSSet *)touches {
    for (UITouch *touch in touches) {
        CGPoint touchLocation = [touch locationInNode:self];
        SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
        NSString *nodeName = touchedNode.name;
        if (nodeName) {
            _selectedNode = touchedNode;
        }else{
            _selectedNode = nil;
        }
    }
}

#pragma mark - Action

#pragma mark 拖动精灵
/*
 用手指点击精灵并拖动
 */
- (void)dragNode:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    CGPoint previousPosition = [touch previousLocationInNode:self];
    CGPoint translation = CGPointMake(positionInScene.x - previousPosition.x, positionInScene.y - previousPosition.y);// 不让精灵飘逸
    
    [self panForTranslation:translation];
}

- (CGPoint)boundLayerPos:(CGPoint)newPos {
    CGSize winSize = self.size;
    CGPoint retval = newPos;
    retval.x = MIN(retval.x, 0);
//    retval.x = MAX(retval.x, -[self size].width+ winSize.width);
    retval.y = [self position].y;
    return retval;
}

- (void)panForTranslation:(CGPoint)translation {
    CGPoint position = [_selectedNode position];
    if([[_selectedNode name] isEqualToString:@"TestingNode"]) {
        [_selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    }

}
#pragma mark 移动精灵
/*
    一般用于点击区域或者按钮让精灵移动，适用于场景内只有一个精灵的情况。
 touch处判断移动方向，update方法调用- (void)moveAction:(FGMoveType)moveType
 来刷新精灵位置
 */
- (FGMoveDirection)moveDirectionWithTouch:(NSSet *)touches{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if (location.x < self.frame.size.width/2) {
            _moveDirection = FGMoveDirectionLeft;
        }else{
            _moveDirection = FGMoveDirectionRight;
        }
    }
    return _moveDirection;
}

- (void)moveToPosition:(NSSet *)touches
{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        __block SKAction *action = [SKAction moveByX:location.x y:location.y duration:1.1];
        SKSpriteNode *node = (SKSpriteNode *)[self childNodeWithName:@"TestingNode"];
//        [node runAction:action completion:^{
//        }];
        node.position = location;
    }
}

#pragma mark - Interface
- (void)moveAction:(FGMoveDirection)moveDirection{
    if (moveDirection == FGMoveTypeNone) {
        return;
    }
    CGFloat moveOffset = 0;
    switch (moveDirection) {
        case FGMoveDirectionLeft:
            moveOffset = -1;
            break;
        case FGMoveDirectionRight:
            moveOffset = 1;
        default:
            break;
    }
    moveOffset = moveOffset*[_thisConfig nodeMoveSpeed];
    // 左右平移
    __block SKAction *action = [SKAction moveByX:moveOffset y:0 duration:0.01];
    SKSpriteNode *node = (SKSpriteNode *)[self childNodeWithName:@"TestingNode"];
    [node runAction:action completion:^{
    }];
}


#pragma mark - For Testing
- (void)addTestSprite{
    SKSpriteNode *testNode = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    
    testNode.xScale = 0.2;
    testNode.yScale = 0.2;
    testNode.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    testNode.name = @"TestingNode";
    //    SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
    //
    //    [sprite runAction:[SKAction repeatActionForever:action]];
    
    [self addChild:testNode];
    
    NSLog(@"testNode.x:%.2f,testNode.y:%.2f",testNode.position.x,testNode.position.y);

}


@end
