//
//  Recap.m
//  FruitAssociation
//
//  Created by Shinsaku Uesugi on 8/19/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Recap.h"

@implementation Recap {
    CCLabelTTF *_gameOver;
    
    CCLabelTTF *_scoreMessage;
    CCLabelTTF *_scoreLabel;
    
    CCLabelTTF *_highscoreMessage;
    CCLabelTTF *_highscoreLabel;
    
    CCButton *_againButton;
}

- (void)onEnter {
    [super onEnter];
    
    NSUserDefaults *gameState = [NSUserDefaults standardUserDefaults];
    _scoreLabel.string = [NSString stringWithFormat:@"%i", [gameState integerForKey:@"score"]];
    _highscoreLabel.string = [NSString stringWithFormat:@"%i", [gameState integerForKey:@"highscore"]];
    
    [self bounce:_gameOver];
    [self bounce:_scoreMessage];
    [self bounce:_scoreLabel];
    [self bounce:_highscoreMessage];
    [self bounce:_highscoreLabel];
    
    CCActionMoveTo *moveTo = [CCActionMoveTo actionWithDuration:1.0f position:ccp(0.5, _againButton.position.y)];
    CCActionEaseBounceOut *bounceOut = [CCActionEaseBounceOut actionWithAction:moveTo];
    [_againButton runAction:bounceOut];
}

- (void)again {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"GamePlay"];
    CCTransition *transition = [CCTransition transitionFadeWithDuration:0.8f];
    [[CCDirector sharedDirector] presentScene:gameplayScene withTransition:transition];
}

- (void)bounce:(CCSprite *)sprite {
    CCActionMoveTo *moveTo = [CCActionMoveTo actionWithDuration:1.0f position:ccp(0.5, sprite.position.y)];
    CCActionEaseBounceOut *bounceOut = [CCActionEaseBounceOut actionWithAction:moveTo];
    [sprite runAction:bounceOut];
}


@end
