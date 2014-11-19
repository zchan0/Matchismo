//
//  NSObject+CardMatingGame.m
//  Matchismo
//
//  Created by joyzh on 14/11/18.
//  Copyright (c) 2014年 USTC. All rights reserved.
//

#import "NSObject+CardMatingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;//of card:the array may contain objects which are not *card
@property (nonatomic ,readwrite) NSInteger lastScore;
@property (nonatomic ,strong, readwrite) NSArray *lastChosenCards;
@end

@implementation CardMatchingGame

-(NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];//super's designated initializaer
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            //adding nil to NSMutableArray will crash the program
            if (card) {
                [self.cards addObject:card];
                NSLog(@"card: %@",card.contents);
            }else{
                self = nil;
                break;
            }
        }
    }
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    //always make sure that argument is not out of bound
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

-(void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card =[self cardAtIndex:index];//current chosen card
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        }else{
            //match against other chosen card
            NSMutableArray *cardsToMatch = [NSMutableArray array];
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched)
                    [cardsToMatch addObject:otherCard];
            }
            
            self.lastScore = 0;
            self.lastChosenCards = [cardsToMatch arrayByAddingObject:card];
            if ([cardsToMatch count] +1 == self.maxMatchingCards) {
                int matchScore = [card match:cardsToMatch];
                if (matchScore) {
                    self.lastScore = matchScore*MATCH_BONUS;
                    //self.score += matchScore*MATCH_BONUS;
                    card.matched = YES;
                    for (Card *otherCard in cardsToMatch) {
                        otherCard.matched = YES;
                    }
                }else{
                    self.lastScore = -MISMATCH_PENALTY;
                    //self.score -= MISMATCH_PENALTY;
                    for (Card *otherCard in cardsToMatch) {
                        otherCard.chosen = NO;
                    }
                }
            }
            
            self.score += self.lastScore - COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

-(void)startNewGame
{
    self.score = 0;
}

@end
