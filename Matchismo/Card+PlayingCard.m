//
//  Card+PlayingCard.m
//  Matchismo
//
//  Created by joyzh on 14/11/16.
//  Copyright (c) 2014年 USTC. All rights reserved.
//

#import "Card+PlayingCard.h"

@implementation PlayingCard

+(NSArray *) validSuits
{
    return @[@"♠️",@"♥️",@"♣️",@"♦️"];
}

+(NSArray *) rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

@synthesize suit = _suit;

-(void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

-(void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

-(NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    NSUInteger numOtherCards = [otherCards count];
    if (numOtherCards) {
        for (PlayingCard *otherCard in otherCards) {
            if (otherCard.rank == self.rank) {
                score += 4;
            }else if ([otherCard.suit isEqualToString:self.suit]){
                score += 1;
            }
            //If there are more than 3 cards to be matched, all cards in the otherCards should be matched in pairs.
            if (numOtherCards > 1) {
                score += [[otherCards firstObject] match:
                          [otherCards subarrayWithRange:NSMakeRange(1, numOtherCards - 1)]];
            }
        }
    }
    return score;
}


@end
