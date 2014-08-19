//
//  Recap.m
//  FruitAssociation
//
//  Created by Shinsaku Uesugi on 8/19/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Recap.h"

@implementation Recap {
    CCLabelTTF *_scoreLabel;
    CCLabelTTF *_highscoreLabel;
}

- (void)onEnter {
    [super onEnter];
    
    NSUserDefaults *gameState = [NSUserDefaults standardUserDefaults];
    _scoreLabel.string = [NSString stringWithFormat:@"%i", [gameState integerForKey:@"score"]];
    _highscoreLabel.string = [NSString stringWithFormat:@"%i", [gameState integerForKey:@"highscore"]];
}

- (void)again {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"GamePlay"];
    CCTransition *transition = [CCTransition transitionFadeWithDuration:0.8f];
    [[CCDirector sharedDirector] presentScene:gameplayScene withTransition:transition];
}

@end
