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
}

// When Entering onto the scene
// 1. Randomly load 1 fruit onto the scene
// 2. Set fruitName (answer) to that fruit
// 3. Set anotherChoiceName (false answer)
- (void)onEnter {
    [super onEnter];
    _left.visible = false;
    _right.visible = false;
    _score = 0;
    _fruitArray = [NSArray arrayWithObjects:@"apple",@"orange",@"banana",@"lemon",@"grapes",@"cherry", nil];
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
        if (0 <= rngColor <= 1) {
            _left.label.color = [CCColor orangeColor];
        } else if (2 <= rngColor <= 3) {
            _left.label.color = [CCColor purpleColor];
        } else if (rngColor == 4) {
            _left.label.color = [CCColor redColor];
        } else {
            _left.label.color = [CCColor yellowColor];
        }
    } else {
        if (0 <= rngColor <= 1) {
            _right.label.color = [CCColor orangeColor];
        } else if (2 <= rngColor <= 3) {
            _right.label.color = [CCColor purpleColor];
        } else if (rngColor == 4) {
            _right.label.color = [CCColor redColor];
        } else {
            _right.label.color = [CCColor yellowColor];
        }
    }
}

- (void)setAnotherColor {
    int rngColor = arc4random() % 6;
    if (_answerLeft) {
        if (0 <= rngColor <= 1) {
            _right.label.color = [CCColor redColor];
        } else if (2 <= rngColor <= 3) {
            _right.label.color = [CCColor yellowColor];
        } else if (rngColor == 4) {
            _right.label.color = [CCColor orangeColor];
        } else {
            _right.label.color = [CCColor purpleColor];
        }
    } else {
        if (0 <= rngColor <= 1) {
            _left.label.color = [CCColor redColor];
        } else if (2 <= rngColor <= 3) {
            _left.label.color = [CCColor yellowColor];
        } else if (rngColor == 4) {
            _left.label.color = [CCColor orangeColor];
        } else {
            _left.label.color = [CCColor purpleColor];
        }
    }
}

- (void)left {
    if (_answerLeft) {
        _score++;
        _scoreLabel.string = [NSString stringWithFormat:@"%i", _score];
        [self next];
    } else {
        NSLog(@"You lose!");
        CCScene *gameplayScene = [CCBReader loadAsScene:@"MainScene"];
        CCTransition *transition = [CCTransition transitionFadeWithDuration:0.8f];
        [[CCDirector sharedDirector] presentScene:gameplayScene withTransition:transition];
    }
}

- (void)right {
    if (!_answerLeft) {
        _score++;
        _scoreLabel.string = [NSString stringWithFormat:@"%i", _score];
        [self next];
    } else {
        NSLog(@"You lose!");
        CCScene *gameplayScene = [CCBReader loadAsScene:@"MainScene"];
        CCTransition *transition = [CCTransition transitionFadeWithDuration:0.8f];
        [[CCDirector sharedDirector] presentScene:gameplayScene withTransition:transition];
    }
}

@end
