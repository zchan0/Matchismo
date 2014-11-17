//
//  Deck+PlayingDeck.m
//  Matchismo
//
//  Created by joyzh on 14/11/16.
//  Copyright (c) 2014年 USTC. All rights reserved.
//

#import "Deck+PlayingDeck.h"
#import "Card+PlayingCard.h"

@implementation PlayingDeck

-(instancetype)init
{
    //确保super类都已成功初始化，否则返回nil，应该总是这么做
    self = [super init];
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc]init];
                card.suit = suit;
                card.rank = rank;
                [self addCard:card];
            }
        }
    }
    
    return self;
}

@end
