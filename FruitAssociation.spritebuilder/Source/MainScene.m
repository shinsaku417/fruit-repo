//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene {
    CCSprite *_orange;
    CCSprite *_apple;
    CCSprite *_cherry;
    CCSprite *_lemon;
    CCSprite *_banana;
    CCSprite *_grapes;
    
    CCLabelTTF *_title;
    CCButton *_playButton;
}

- (void)onEnter {
    [super onEnter];
    
    [self bounceSpriteUp:_orange];
    [self bounceSpriteUp:_apple];
    [self bounceSpriteUp:_cherry];
    [self bounceSpriteDown:_lemon];
    [self bounceSpriteDown:_banana];
    [self bounceSpriteDown:_grapes];
    
    CCActionMoveTo *moveTo = [CCActionMoveTo actionWithDuration:1.5f position:ccp(0.5, _title.position.y)];
    CCActionEaseBounceOut *bounceOut = [CCActionEaseBounceOut actionWithAction:moveTo];
    [_title runAction:bounceOut];
    
    CCActionMoveTo *moveButton = [CCActionMoveTo actionWithDuration:1.5f position:ccp(0.5, _playButton.position.y)];
    CCActionEaseBounceOut *bounceButton = [CCActionEaseBounceOut actionWithAction:moveButton];
    [_playButton runAction:bounceButton];
}

- (void)bounceSpriteUp:(CCSprite *)sprite {
    CCActionMoveTo *moveTo = [CCActionMoveTo actionWithDuration:1.0f position:ccp(sprite.position.x,sprite.position.y + 0.1)];
    CCActionEaseBounceOut *bounceOut = [CCActionEaseBounceOut actionWithAction:moveTo];
    [sprite runAction:bounceOut];
}

- (void)bounceSpriteDown:(CCSprite *)sprite {
    CCActionMoveTo *moveTo = [CCActionMoveTo actionWithDuration:1.0f position:ccp(sprite.position.x,sprite.position.y - 0.1)];
    CCActionEaseBounceOut *bounceOut = [CCActionEaseBounceOut actionWithAction:moveTo];
    [sprite runAction:bounceOut];
}

- (void)play {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"GamePlay"];
    CCTransition *transition = [CCTransition transitionFadeWithDuration:0.8f];
    [[CCDirector sharedDirector] presentScene:gameplayScene withTransition:transition];
}

@end
