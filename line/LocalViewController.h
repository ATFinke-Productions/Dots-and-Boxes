//
//  NewLocalViewController.h
//  Boxes
//
//  Created by Andrew on 4/19/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBHUDView.h"
#import "LocalMatch.h"
#import "PracticeInfoViewController.h"

@interface LocalViewController : UIViewController <ConfirmDelegate,UIAlertViewDelegate> {
    
    IBOutlet UILabel *details;
    IBOutlet UILabel *playerLabel;
    IBOutlet UILabel *playersScoreLabel;
    NSString * currentPlayerString;
    UIImageView * lastTouchView;
    
    int64_t player1Score;
    int64_t player2Score;
    int64_t player3Score;
    int64_t player4Score;
    
    int playerNumber;
    int lastButtonTag;
    int localScore;
    
    BOOL isViewVisible;
    BOOL isViewVisibleForAlert;
    BOOL isHudOn;
    BOOL isPlayerAI;
    BOOL justTookSquare;
    BOOL recivingSquareTaken;
    BOOL isShowingResults;
    BOOL canShowAlert;
    UIColor * userBoardColor;
    UIColor * userLineColor;
    NSUserDefaults * defaults;
    
    UIBarButtonItem * matchPresent;
    UIBarButtonItem * shareButton;
    Confirm *lastConfirm;

    
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

-(IBAction)tappedSquare:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end