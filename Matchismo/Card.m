//
//  Card.m
//  Matchismo
//
//  Created by joyzh on 14/11/16.
//  Copyright (c) 2014年 USTC. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

-(int)match:(NSArray *) otherCards 
{
    int score = 0;
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}



@end