//
//  GamePlay.m
//  FruitAssociation
//
//  Created by Shinsaku Uesugi on 8/18/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GamePlay.h"

@implementation GamePlay {
    // Fruit Display
    CCSprite *_fruit;
    
    // Name of fruit on display
    NSString *_fruitName;
    
    // Array that keeps all the fruits in the game
    NSArray *_fruitArray;
    
    // Another choice name
    NSString *_anotherFruitName;
    
    // Answer is on the left button
    BOOL *_answerLeft;
    
    // Score label
    CCLabelTTF *_scoreLabel;
    int _score;
    
    // Things before pressing ready button
    CCLabelTTF *_rememberLabel;
    CCButton *_readyButton;
    
    // Things after pressing ready button
    CCLabelTTF *_previousLabel;
    CCButton *_left;
    CCButton *_right;
    
    CCColor *_red;
    CCColor *_purple;
    
    NSMutableArray *_throwArray;
    
    int _life;
    CCSprite *_lifeOne;
    CCSprite *_lifeTwo;
    CCSprite *_lifeThree;
    
    CCLabelTTF *_timer;
    int _time;
}

// When Entering onto the scene
// 1. Randomly load 1 fruit onto the scene
// 2. Set fruitName (answer) to that fruit
// 3. Set anotherChoiceName (false answer)
- (void)onEnter {
    [super onEnter];
    _red = [CCColor colorWithRed:1 green:0.1 blue:0.1];
    _left.visible = false;
    _right.visible = false;
    _life = 3;
    _score = 0;
    _time = 60;
    _fruitArray = [NSArray arrayWithObjects:@"Apple",@"Orange",@"Banana",@"Lemon",@"Grapes",@"Cherry", nil];
    _throwArray = [NSMutableArray array];
    int rngInitial = arc4random() % 6;

    switch(rngInitial) {
        case 0:
            [_fruit setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"image/apple.png"]];
            _fruitName = _fruitArray[0];
            [self setAnotherChoice:0];
            break;
        case 1:
            [_fruit setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"image/orange.png"]];
            _fruitName = _fruitArray[1];
            [self setAnotherChoice:1];
            break;
        case 2:
            [_fruit setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"image/banana.png"]];
            _fruitName = _fruitArray[2];
            [self setAnotherChoice:2];
            break;
        case 3:
            [_fruit setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"image/lemon.png"]];
            _fruitName = _fruitArray[3];
            [self setAnotherChoice:3];
            break;
        case 4:
            [_fruit setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"image/grapes.png"]];
            _fruitName = _fruitArray[4];
            [self setAnotherChoice:4];
            break;
        default:
            [_fruit setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"image/cherry.png"]];
            _fruitName = _fruitArray[5];
            [self setAnotherChoice:5];
    }
}

// When pressed ready or one of left/right buttons during gameplay
// 1. Set answers
// 2. Generate another fruit
- (void)next {
    if (_readyButton.visible == true) {
        _rememberLabel.visible = false;
        _readyButton.visible = false;
        
        _previousLabel.visible = true;
        _left.visible = true;
        _right.visible = true;
        [self schedule:@selector(timerUpdate) interval:1.f];
    }
    [self setAnswer];
    [self generateFruit];
}

// Generate new fruit onto the scene, and set another choice given that fruit
- (void)generateFruit {
    // random number from 0-5 for displaying random fruit
    int rngDisplay = arc4random() % 6;
    switch(rngDisplay) {
        case 0:
            [_fruit setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"image/apple.png"]];
            _fruitName = _fruitArray[0];
            [self setAnotherChoice:0];
            break;
        case 1:
            [_fruit setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"image/orange.png"]];
            _fruitName = _fruitArray[1];
            [self setAnotherChoice:1];
            break;
        case 2:
            [_fruit setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"image/banana.png"]];
            _fruitName = _fruitArray[2];
            [self setAnotherChoice:2];
            break;
        case 3:
            [_fruit setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"image/lemon.png"]];
            _fruitName = _fruitArray[3];
            [self setAnotherChoice:3];
            break;
        case 4:
            [_fruit setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"image/grapes.png"]];
            _fruitName = _fruitArray[4];
            [self setAnotherChoice:4];
            break;
        default:
            [_fruit setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"image/cherry.png"]];
            _fruitName = _fruitArray[5];
            [self setAnotherChoice:5];
    }
}

// 1. Generate random number from 0-4 (6 fruits - 1 answer)
// 2. Create mutablearray copy of fruit array
// 3. Remove answer fruit from the array
// 4. Set anotherFruitName with respect to randomly generated number
- (void)setAnotherChoice:(int)fruitIndex {
    int rngName = arc4random() % 5;
    NSMutableArray *fruitRemove = [_fruitArray mutableCopy];
    [fruitRemove removeObjectAtIndex:fruitIndex];
    switch (rngName) {
        case 0:
            _anotherFruitName = fruitRemove[0];
            break;
        case 1:
            _anotherFruitName = fruitRemove[1];
            break;
        case 2:
            _anotherFruitName = fruitRemove[2];
            break;
        case 3:
            _anotherFruitName = fruitRemove[3];
            break;
        case 4:
            _anotherFruitName = fruitRemove[4];
            break;
    }
}

// 1. Generate random number from 0-1, 0 = answer on left, 1 = answer on right
// 2. Set labels on the buttons accordingly
- (void)setAnswer {
    int rngAnswer = arc4random() % 2;
    if (rngAnswer == 0) {
        _answerLeft = true;
        _left.title = _fruitName;
        _right.title = _anotherFruitName;
        [self setAnswerColor];
        [self setAnotherColor];
    } else {
        _answerLeft = false;
        _right.title = _fruitName;
        _left.title = _anotherFruitName;
        [self setAnswerColor];
        [self setAnotherColor];
    }
}

- (void)setAnswerColor {
    int rngColor = arc4random() % 6;
    if (_answerLeft) {
        if (0 <= rngColor && rngColor <= 1) {
            [_left setColor:[CCColor orangeColor]];
            [_left setLabelColor:[CCColor orangeColor] forState:CCControlStateHighlighted];
        } else if (2 <= rngColor && rngColor <= 3) {
            [_left setColor:[CCColor magentaColor]];
            [_left setLabelColor:[CCColor magentaColor] forState:CCControlStateHighlighted];
        } else if (rngColor == 4) {
            [_left setColor:_red];
            [_left setLabelColor:_red forState:CCControlStateHighlighted];
        } else {
            [_left setColor:[CCColor yellowColor]];
            [_left setLabelColor:[CCColor yellowColor] forState:CCControlStateHighlighted];
        }
    } else {
        if (0 <= rngColor && rngColor <= 1) {
            [_right setColor:[CCColor orangeColor]];
            [_right setLabelColor:[CCColor orangeColor] forState:CCControlStateHighlighted];
        } else if (2 <= rngColor && rngColor <= 3) {
            [_right setColor:[CCColor magentaColor]];
            [_right setLabelColor:[CCColor magentaColor] forState:CCControlStateHighlighted];
        } else if (rngColor == 4) {
            [_right setColor:_red];
            [_right setLabelColor:_red forState:CCControlStateHighlighted];
        } else {
            [_right setColor:[CCColor yellowColor]];
            [_right setLabelColor:[CCColor yellowColor] forState:CCControlStateHighlighted];
        }
    }
}

- (void)setAnotherColor {
    int rngColor = arc4random() % 6;
    if (_answerLeft) {
        if (0 <= rngColor && rngColor <= 1) {
            [_right setColor:[CCColor orangeColor]];
            [_right setLabelColor:[CCColor orangeColor] forState:CCControlStateHighlighted];
        } else if (2 <= rngColor && rngColor <= 3) {
            [_right setColor:[CCColor magentaColor]];
            [_right setLabelColor:[CCColor magentaColor] forState:CCControlStateHighlighted];
        } else if (rngColor == 4) {
            [_right setColor:_red];
            [_right setLabelColor:_red forState:CCControlStateHighlighted];
        } else {
            [_right setColor:[CCColor yellowColor]];
            [_right setLabelColor:[CCColor yellowColor] forState:CCControlStateHighlighted];
        }
    } else {
        if (0 <= rngColor && rngColor <= 1) {
            [_left setColor:[CCColor orangeColor]];
            [_left setLabelColor:[CCColor orangeColor] forState:CCControlStateHighlighted];
        } else if (2 <= rngColor && rngColor <= 3) {
            [_left setColor:[CCColor magentaColor]];
            [_left setLabelColor:[CCColor magentaColor] forState:CCControlStateHighlighted];
        } else if (rngColor == 4) {
            [_left setColor:_red];
            [_left setLabelColor:_red forState:CCControlStateHighlighted];
        } else {
            [_left setColor:[CCColor yellowColor]];
            [_left setLabelColor:[CCColor yellowColor] forState:CCControlStateHighlighted];
        }
    }
}

- (void)left {
    if (_answerLeft) {
        _score++;
        _scoreLabel.string = [NSString stringWithFormat:@"%i", _score];
    } else {
        [self loseLife];
    }
    if (_life == 0) {
        [self nextScene];
    } else {
        [self throwLeft];
        [self next];
    }
}

- (void)right {
    if (!_answerLeft) {
        _score++;
        _scoreLabel.string = [NSString stringWithFormat:@"%i", _score];
    } else {
        [self loseLife];
    }
    if (_life == 0) {
        [self nextScene];
    } else {
        [self throwRight];
        [self next];
    }
}

- (void)loseLife {
    _life--;
    CCActionFadeOut *fadeOut = [CCActionFadeOut actionWithDuration:0.15f];
    if (_life == 2) {
        [_lifeOne runAction:fadeOut];
    } else if (_life == 1) {
        [_lifeTwo runAction:fadeOut];
    }  else {
        [_lifeThree runAction:fadeOut];
    }
}

- (void)throwLeft {
    CCSprite *throw = [CCSprite spriteWithTexture:[_fruit texture]];
    throw.positionType = CCPositionTypeNormalized;
    throw.position = ccp(0.5,0.65);
    [self addChild:throw];
    CCActionMoveTo *move = [CCActionMoveTo actionWithDuration:0.2f position:ccp(throw.position.x - 1,throw.position.y)];
    [throw runAction:move];
    [_throwArray addObject:throw];
}

- (void)throwRight {
    CCSprite *throw = [CCSprite spriteWithTexture:[_fruit texture]];
    throw.positionType = CCPositionTypeNormalized;
    throw.position = ccp(0.5,0.65);
    [self addChild:throw];
    CCActionMoveTo *move = [CCActionMoveTo actionWithDuration:0.2f position:ccp(throw.position.x + 1,throw.position.y)];
    [throw runAction:move];
    [_throwArray addObject:throw];

}

- (void)nextScene {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"MainScene"];
    CCTransition *transition = [CCTransition transitionFadeWithDuration:0.8f];
    [[CCDirector sharedDirector] presentScene:gameplayScene withTransition:transition];
}

- (void)update:(CCTime)delta {
    for (CCSprite *throw in _throwArray) {
        if (throw.position.x < 0 || throw.position.x > 1) {
            [throw removeFromParentAndCleanup:TRUE];
        }
    }
}

- (void)timerUpdate {
    _time--;
    _timer.string = [NSString stringWithFormat:@"%i", _time];
    if (_time == 0) {
        CCScene *gameplayScene = [CCBReader loadAsScene:@"MainScene"];
        [[CCDirector sharedDirector] presentScene:gameplayScene];
    }
}

@end
