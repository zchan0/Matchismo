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
    return @[@"♣︎",@"♥︎",@"♦︎",@"♠︎"];
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

//返回牌的内容字符串
-(NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}


@end
