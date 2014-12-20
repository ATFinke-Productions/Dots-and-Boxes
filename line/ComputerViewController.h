//
//  ComputerViewController.h
//  dot
//
//  Created by Andrew on 4/7/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComputerViewController : UIViewController <UIAlertViewDelegate> {
    
    IBOutlet UILabel *details;
    IBOutlet UINavigationBar *bar;
    IBOutlet UILabel *playersScoreLabel;
    IBOutlet UISegmentedControl *segSwitch;
    UIImageView * lastTouchView;
    
    int64_t player1Score;
    int64_t player2Score;
    int64_t player3Score;
    int64_t player4Score;
    
    float computerDelay;
    int playerNumberTurn;
    BOOL justTookSquare;
    BOOL isShowingResults;
    BOOL hasClosed;
    
    NSUserDefaults * defaults;
    CATransition *transition;
    
    UIColor * userBoardColor;
    UIColor * userLineColor;
    
    CATransition * textChange;
    
    NSMutableArray *allSquares;
    NSMutableArray *playersWithAlias;
    NSMutableArray *arrayWithData;
    NSMutableArray *linesToAddToGrid;
    NSMutableArray *squaresForPlayer1;
    NSMutableArray *squaresForPlayer2;
    NSMutableArray *squaresForPlayer3;
    NSMutableArray *squaresForPlayer4;
    
    NSMutableArray *square01;
    NSMutableArray *square02;
    NSMutableArray *square03;
    NSMutableArray *square04;
    NSMutableArray *square05;
    NSMutableArray *square06;
    NSMutableArray *square07;
    NSMutableArray *square08;
    NSMutableArray *square09;
    NSMutableArray *square10;
    NSMutableArray *square11;
    NSMutableArray *square12;
    NSMutableArray *square13;
    NSMutableArray *square14;
    NSMutableArray *square15;
    NSMutableArray *square16;
    NSMutableArray *square17;
    NSMutableArray *square18;
    NSMutableArray *square19;
    NSMutableArray *square20;
    NSMutableArray *square21;
    NSMutableArray *square22;
    NSMutableArray *square23;
    NSMutableArray *square24;
    NSMutableArray *square25;
    NSMutableArray *square26;
    NSMutableArray *square27;
    NSMutableArray *square28;
    NSMutableArray *square29;
    NSMutableArray *square30;
    NSMutableArray *square31;
    NSMutableArray *square32;
    NSMutableArray *square33;
    NSMutableArray *square34;
    NSMutableArray *square35;
    NSMutableArray *square36;
}
-(IBAction)changeSpeed:(id)sender;
-(IBAction)close:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end