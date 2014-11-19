//
//  ViewController.m
//  Matchismo
//
//  Created by joyzh on 14/11/15.
//  Copyright (c) 2014年 USTC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSelector;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipDescription;
- (IBAction)startNewGame:(id)sender;
- (IBAction)changeModeSelector:(UISegmentedControl *)sender;
- (IBAction)touchDealButton:(id)sender;


@end

@implementation ViewController

-(CardMatchingGame *)game
{
    if (!_game){
         _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count] usingDeck:[self creatDeck]];
        [self changeModeSelector:self.modeSelector];
    }
    return _game;
}

-(Deck *)creatDeck
{
    return [[PlayingDeck alloc]init];
}

//IBAction:typedof void
- (IBAction)touchCardButton:(UIButton *)sender
{
    self.modeSelector.enabled = NO;
    NSUInteger chosenButtonIndex =[self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    
}

-(void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];
    }
    
    if (self.game) {
        NSString *description = @"";
        if ([self.game.lastChosenCards count]) {
            NSMutableArray *cardContents = [NSMutableArray array];
            for (Card *card in self.game.lastChosenCards) {
                [cardContents addObject:card.contents];
            }
            description = [cardContents componentsJoinedByString:@" "];
        }
        if (self.game.lastScore > 0) {
            description = [NSString stringWithFormat:@"Matched %@ for %d points.", description, (int)self.game.lastScore];
        } else if (self.game.lastScore < 0) {
            description = [NSString stringWithFormat:@"%@ don’t match! %d point penalty!", description, (int)self.game.lastScore];
        }
        self.flipDescription.text = description;
    }
    
}

-(NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)startNewGame:(id)sender
{
    self.game = nil;
    [self.game startNewGame];
    [self updateUI];
}

- (IBAction)changeModeSelector:(UISegmentedControl *)sender
{
    self.game.maxMatchingCards = [[sender titleForSegmentAtIndex:sender.selectedSegmentIndex]integerValue];
}

- (IBAction)touchDealButton:(id)sender
{
    self.modeSelector.enabled = YES;
}








@end
