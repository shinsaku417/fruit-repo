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
    
    // Buttons on the scene
    CCButton *_left;
    CCButton *_right;
}

- (void)onEnter {
    [super onEnter];
    _score = 0;
    _fruitArray = [NSArray arrayWithObjects:@"apple",@"orange",@"banana",@"lemon",@"grapes",@"cherry", nil];
    [self generateFruit];
}

// Generate new fruit onto the scene
- (void)generateFruit {
    // random number from 0-5 for displaying random fruit
    int rngDisplay = arc4random() % 6;
    switch(rngDisplay) {
        case 0:
            [_fruit setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"image/apple.png"]];
            _fruitName = _fruitArray[0];
            [self setAnotherChoice:0];
            [self setAnswer];
            break;
        case 1:
            [_fruit setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"image/orange.png"]];
            _fruitName = _fruitArray[1];
            [self setAnotherChoice:1];
            [self setAnswer];
            break;
        case 2:
            [_fruit setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"image/banana.png"]];
            _fruitName = _fruitArray[2];
            [self setAnotherChoice:2];
            [self setAnswer];
            break;
        case 3:
            [_fruit setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"image/lemon.png"]];
            _fruitName = _fruitArray[3];
            [self setAnotherChoice:3];
            [self setAnswer];
            break;
        case 4:
            [_fruit setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"image/grapes.png"]];
            _fruitName = _fruitArray[4];
            [self setAnotherChoice:4];
            [self setAnswer];
            break;
        default:
            [_fruit setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"image/cherry.png"]];
            _fruitName = _fruitArray[5];
            [self setAnotherChoice:5];
            [self setAnswer];
    }
}

- (void)setAnotherChoice:(int)fruitIndex {
    // random number from 0-4 for displaying random another choice
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

- (void)setAnswer {
    // random number from 0-1 on which one contains a right answer
    int rngAnswer = arc4random() % 2;
    if (rngAnswer == 0) {
        _answerLeft = true;
        _left.title = _fruitName;
        _right.title = _anotherFruitName;
    } else {
        _answerLeft = false;
        _right.title = _fruitName;
        _left.title = _anotherFruitName;
    }
}

- (void)left {
    if (_answerLeft) {
        _score++;
        _scoreLabel.string = [NSString stringWithFormat:@"%i", _score];
    } else {
        NSLog(@"You lose!");
    }
    [self generateFruit];
}

- (void)right {
    if (!_answerLeft) {
        _score++;
        _scoreLabel.string = [NSString stringWithFormat:@"%i", _score];
    } else {
        NSLog(@"You lose!");
    }
    [self generateFruit];
}

@end
