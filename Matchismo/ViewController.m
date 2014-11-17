//
//  ViewController.m
//  Matchismo
//
//  Created by joyzh on 14/11/15.
//  Copyright (c) 2014年 USTC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//weak is a great use
@property (weak, nonatomic) IBOutlet UILabel *flipsLable;
@property (nonatomic) int flipCount;
@property (strong,nonatomic) Deck *myDeck;
@property (weak, nonatomic) IBOutlet UIButton *cardButton;

@end

@implementation ViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self touchCardButton:self.cardButton];
}

-(Deck *)myDeck
{
    if (!_myDeck) {
         _myDeck = [[PlayingDeck alloc]init];
    }
    return _myDeck;
}

//use setters and getters to keep things in sync!UI update!
- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLable.text = [NSString stringWithFormat:@"Total:%d",self.flipCount];
}

//IBAction:typedof void
- (IBAction)touchCardButton:(UIButton *)sender {
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    }
    else{
        Card *myCard = [self.myDeck drawRandomCard];
        if (myCard) {
            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
            [sender setTitle:[myCard contents] forState:UIControlStateNormal];
        }
        else{
             [sender removeFromSuperview];
        }
    }
    self.flipCount++;//both call setter and getter
}



@end
