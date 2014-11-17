//
//  Deck.h
//  Matchismo
//
//  Created by joyzh on 14/11/16.
//  Copyright (c) 2014年 USTC. All rights reserved.
//

#ifndef Matchismo_Deck_h
#define Matchismo_Deck_h

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(void)addCard:(Card *)card;

-(Card *)drawRandomCard;



@end

#endif
