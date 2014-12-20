//
//  UpdatingMenuBoard.m
//  dot
//
//  Created by Andrew on 4/6/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "UpdatingMenuBoard.h"
#import "lineAI.h"

#define transitionDuration .5;
#define notificationTime .5
#define computerDelay .1

@implementation UpdatingMenuBoard

-(void)setNeedsDisplay{
    [self configSquares];

    defaults = [NSUserDefaults standardUserDefaults];
    allSquares = [NSMutableArray array];
    linesToAddToGrid = [NSMutableArray array];
    squaresForPlayer1 = [NSMutableArray array];
    squaresForPlayer2 = [NSMutableArray array];
    squaresForPlayer3 = [NSMutableArray array];
    squaresForPlayer4 = [NSMutableArray array];
    
    transition = [CATransition animation];
    transition.delegate = self;
    transition.duration = transitionDuration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromBottom;
    
    playerNumberTurn = 1;
    [self computerMoveAndChangeTurn:NO];
}

-(void)configSquares{
    square01 = [NSMutableArray arrayWithObjects:@"1", @"5", @"21", @"22", nil];
    square02 = [NSMutableArray arrayWithObjects:@"2", @"6", @"22", @"23", nil];
    square03 = [NSMutableArray arrayWithObjects:@"3", @"7", @"23", @"24", nil];
    square04 = [NSMutableArray arrayWithObjects:@"4", @"8", @"24", @"25", nil];
    
    square05 = [NSMutableArray arrayWithObjects:@"5", @"9", @"26", @"27", nil];
    square06 = [NSMutableArray arrayWithObjects:@"6", @"10", @"27", @"28", nil];
    square07 = [NSMutableArray arrayWithObjects:@"7", @"11", @"28", @"29", nil];
    square08 = [NSMutableArray arrayWithObjects:@"8", @"12", @"29", @"30", nil];
    
    
    square09 = [NSMutableArray arrayWithObjects:@"9", @"13", @"31", @"32", nil];
    square10 = [NSMutableArray arrayWithObjects:@"10", @"14", @"32", @"33", nil];
    square11 = [NSMutableArray arrayWithObjects:@"11", @"15", @"33", @"34", nil];
    square12 = [NSMutableArray arrayWithObjects:@"12", @"16", @"34", @"35", nil];
    
    square13 = [NSMutableArray arrayWithObjects:@"13", @"17", @"36", @"37", nil];
    square14 = [NSMutableArray arrayWithObjects:@"14", @"18", @"37", @"38", nil];
    square15 = [NSMutableArray arrayWithObjects:@"15", @"19", @"38", @"39", nil];
    square16 = [NSMutableArray arrayWithObjects:@"16", @"20", @"39", @"40", nil];
}


-(void)updateView{
    [self reloadSquareArray];
    NSMutableArray * squaresTakenArray = [NSMutableArray arrayWithObjects:squaresForPlayer1,squaresForPlayer2,squaresForPlayer3,squaresForPlayer4, nil];

    for (int player = 0; player < 4; player++) {
        for (NSString *squareNumbers in squaresTakenArray[player]) {
            for (UIImageView * imageView in self.subviews) {
                if (240 > imageView.tag && 200 < imageView.tag) {
                    if (imageView.tag - 200 == [squareNumbers intValue]) {
                        imageView.image = [[UIColorForString sharedInstance] imageForColorWithString:[defaults valueForKey:[NSString stringWithFormat:@"userP%dColor",player + 1]] forType:nil];
                    }
                }
            }
        }
    }
    [self computerMoveAndChangeTurn:!justTookSquare];
}


-(void)computerMoveAndChangeTurn:(BOOL)changeTurn{
    justTookSquare = NO;
    if (changeTurn && playerNumberTurn < 4) {
        playerNumberTurn++;
    }
    else if (changeTurn && playerNumberTurn == 4) {
        playerNumberTurn = 1;
    }
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(move) userInfo:nil repeats:NO];
}
-(void)move{
    [self reloadSquareArray];
    NSString * potienalLine = [[lineAI sharedInstance] moveForSpaceWithSquares:allSquares];
    if (![potienalLine isEqual:@"GAME"]) {
        [linesToAddToGrid addObject:potienalLine];
        [self removeSpaceForLine];
    }
    else {
        NSLog(@"done");
    }
}


-(BOOL)isSquareAlreadyTaken:(int)square{
    for (NSString * squaresInPlayer1 in squaresForPlayer1) {
        if ([squaresInPlayer1 intValue] == square) {
            return NO;
        }
    }
    for (NSString * squaresInPlayer2 in squaresForPlayer2) {
        if ([squaresInPlayer2 intValue] == square) {
            return NO;
        }
    }
    for (NSString * squaresInPlayer4 in squaresForPlayer4) {
        if ([squaresInPlayer4 intValue] == square) {
            return NO;
        }
    }
    for (NSString * squaresInPlayer3 in squaresForPlayer3) {
        if ([squaresInPlayer3 intValue] == square) {
            return NO;
        }
    }
    return YES;
}

-(void)reloadSquareArray{
    [allSquares removeAllObjects];
    allSquares = [NSMutableArray arrayWithObjects:square01,square02,square03,square04,square05,square06,square07,square08,square09,square10,square11,square12,square13,square14,square15,square16, nil];
}


-(void)removeSpaceForLine{
    BOOL shouldUpdateSquares = NO;
    [self reloadSquareArray];
    
    
    for (int i = 0; i < [linesToAddToGrid count]; i++) {
        int squareNumber = 0;
        for (NSMutableArray * squareArray in allSquares) {
            squareNumber++;
            [squareArray removeObject:[NSString  stringWithFormat:@"%@",linesToAddToGrid[i]]];
            if ([squareArray count] == 0) {
                if ([self isSquareAlreadyTaken:squareNumber]) {
                    shouldUpdateSquares = YES;
                    NSLog(@"%d",playerNumberTurn);
                    switch (playerNumberTurn) {
                        case 1:
                            [squaresForPlayer1 addObject:[NSString stringWithFormat:@"%d",squareNumber]];
                            break;
                        case 2:
                            [squaresForPlayer2 addObject:[NSString stringWithFormat:@"%d",squareNumber]];
                            break;
                        case 3:
                            [squaresForPlayer3 addObject:[NSString stringWithFormat:@"%d",squareNumber]];
                            break;
                        case 4:
                            [squaresForPlayer4 addObject:[NSString stringWithFormat:@"%d",squareNumber]];
                            break;
                            
                        default:
                            break;
                    }
                }
            }
        }
        [self buttonWithName:[[NSString stringWithFormat:@"%@",linesToAddToGrid[i]]intValue]];
    }
    if (shouldUpdateSquares) {
        justTookSquare = YES;
        NSLog(@"Sq");
        [self updateView];
    }
    else {
        justTookSquare = NO;
        [self computerMoveAndChangeTurn:YES];
    }
}


-(void)buttonWithName:(int)buttonName {
    NSMutableArray * horizontalLines = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20", nil];
    NSMutableArray * verticalLines = [NSMutableArray arrayWithObjects:@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40", nil];
    
    for (UIButton * button in self.subviews) {
        if (100 > button.tag > 0) {
            for (NSString * line in horizontalLines) {
                if (button.tag == [line intValue] && buttonName == button.tag) {
                    [button.layer addAnimation:transition forKey:kCATransition];
                    [button setImage:[[UIColorForString sharedInstance]imageForColor:[UIColor blackColor] forType:@"horizontial"] forState:UIControlStateNormal];
                    return;
                }
            }
            for (NSString * line in verticalLines) {
                if (button.tag == [line intValue] && buttonName == button.tag) {
                    [button.layer addAnimation:transition forKey:kCATransition];
                    [button setImage:[[UIColorForString sharedInstance]imageForColor:[UIColor blackColor] forType:@"vertical"] forState:UIControlStateNormal];
                    return;
                }
            }
        }
    }
}
@end
