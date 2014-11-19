//
//  NSObject+CardMatingGame.h
//  Matchismo
//
//  Created by joyzh on 14/11/18.
//  Copyright (c) 2014年 USTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame:NSObject

//designated initializer
-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

-(void)chooseCardAtIndex:(NSUInteger)index;

-(Card *)cardAtIndex:(NSUInteger)index;

-(void)startNewGame;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger maxMatchingCards;
@property (nonatomic, readonly) NSInteger lastScore;
@property (nonatomic, readonly) NSArray * lastChosenCards;

@end
