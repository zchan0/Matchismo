//
//  Deck.m
//  Matchismo
//
//  Created by joyzh on 14/11/16.
//  Copyright (c) 2014年 USTC. All rights reserved.
//

#import "Deck.h"

//private declaration:a deck
@interface Deck()
@property (strong,nonatomic) NSMutableArray *cards;

@end

@implementation Deck

//为cards分配空间并初始化，oc中变量默认初始化为0
-(NSMutableArray *) cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

-(void)addCard:(Card *)card atTop:(BOOL)atTop
{
    //在牌堆的上方放上一张牌
    if (atTop) {
        //- (void)insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes;
        //NSMutableArray Only,将元素插入到数组指定下标处,下标0表示在顶端，嗯，我们会这么定义的
        [self.cards insertObjects:card atIndexes:0];
    }
    else{
        //- (void)addObject:(id)anObject;
        //NSMutableArray Only,将元素添加到数组末尾
        [self.cards addObject:card];
    }
}

-(void)addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}

//随机从牌堆中取出一张牌
//返回一张牌card
-(Card *) drawRandomCard
{
    Card *randomCard = nil;
    
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end