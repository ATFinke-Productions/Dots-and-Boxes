//
//  MultiplayerViewController.h
//  line
//
//  Created by Andrew on 3/27/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>
#import "GCTurnBasedMatchHelper.h"

@interface MultiplayerViewController : UIViewController <UIAlertViewDelegate,GCTurnBasedMatchHelperDelegate> {
    
    IBOutlet UIView *isCurrentTurnView;
    MBProgressHUD *HUD;
    
    IBOutlet UILabel *playerLabel;
    IBOutlet UILabel *player1ScoreLabel;
    int64_t player1Score;
    IBOutlet UILabel *player2ScoreLabel;
    int64_t player2Score;
    
    BOOL isPlayer1;
    BOOL justTookSquare;
    BOOL recivingSquareTaken;
    
    int tag;
    
    NSMutableArray *linesToAddToGrid;
    NSMutableArray *squaresForPlayer1;
    NSMutableArray *squaresForPlayer2;

    NSMutableArray *arrayWithData;
    
    
    //
    //
    //  LINES 1&2
    //
    //
    
    BOOL s01D;
    BOOL s02D;
    BOOL s03D;
    BOOL s04D;
    BOOL s05D;
    BOOL s06D;
    BOOL s07D;
    BOOL s08D;
    BOOL s09D;
    BOOL s10D;
    BOOL s11D;
    BOOL s12D;
    
    IBOutlet UIButton *s01;
    IBOutlet UIButton *s02;
    IBOutlet UIButton *s03;
    IBOutlet UIButton *s04;
    IBOutlet UIButton *s05;
    IBOutlet UIButton *s06;
    IBOutlet UIButton *s07;
    IBOutlet UIButton *s08;
    IBOutlet UIButton *s09;
    IBOutlet UIButton *s10;
    IBOutlet UIButton *s11;
    IBOutlet UIButton *s12;
    IBOutlet UIButton *s13;
    IBOutlet UIButton *s14;
    IBOutlet UIButton *s15;
    IBOutlet UIButton *s16;
    IBOutlet UIButton *s17;
    IBOutlet UIButton *s18;
    IBOutlet UIButton *s19;
    IBOutlet UIButton *s20;
    IBOutlet UIButton *s21;
    IBOutlet UIButton *s22;
    IBOutlet UIButton *s23;
    IBOutlet UIButton *s24;
    IBOutlet UIButton *s25;
    IBOutlet UIButton *s26;
    IBOutlet UIButton *s27;
    IBOutlet UIButton *s28;
    IBOutlet UIButton *s29;
    IBOutlet UIButton *s30;
    IBOutlet UIButton *s31;
    IBOutlet UIButton *s32;
    
    NSMutableArray *square01;
    IBOutlet UIImageView *square01Image;
    
    NSMutableArray *square02;
    IBOutlet UIImageView *square02Image;
    
    NSMutableArray *square03;
    IBOutlet UIImageView *square03Image;
    
    NSMutableArray *square04;
    IBOutlet UIImageView *square04Image;
    
    NSMutableArray *square05;
    IBOutlet UIImageView *square05Image;
    
    NSMutableArray *square06;
    IBOutlet UIImageView *square06Image;
    
    NSMutableArray *square07;
    IBOutlet UIImageView *square07Image;
    
    NSMutableArray *square08;
    IBOutlet UIImageView *square08Image;
    
    NSMutableArray *square09;
    IBOutlet UIImageView *square09Image;
    
    NSMutableArray *square10;
    IBOutlet UIImageView *square10Image;
    
    NSMutableArray *square11;
    IBOutlet UIImageView *square11Image;
    
    NSMutableArray *square12;
    IBOutlet UIImageView *square12Image;
    
    
    //
    //
    //  LINES 3&4
    //
    //
    
    BOOL s13D;
    BOOL s14D;
    BOOL s15D;
    BOOL s16D;
    BOOL s17D;
    BOOL s18D;
    BOOL s19D;
    BOOL s20D;
    BOOL s21D;
    BOOL s22D;
    BOOL s23D;
    BOOL s24D;
    
    IBOutlet UIButton *s33;
    IBOutlet UIButton *s34;
    IBOutlet UIButton *s35;
    IBOutlet UIButton *s36;
    IBOutlet UIButton *s37;
    IBOutlet UIButton *s38;
    IBOutlet UIButton *s39;
    IBOutlet UIButton *s40;
    IBOutlet UIButton *s41;
    IBOutlet UIButton *s42;
    IBOutlet UIButton *s43;
    IBOutlet UIButton *s44;
    IBOutlet UIButton *s45;
    IBOutlet UIButton *s46;
    IBOutlet UIButton *s47;
    IBOutlet UIButton *s48;
    IBOutlet UIButton *s49;
    IBOutlet UIButton *s50;
    IBOutlet UIButton *s51;
    IBOutlet UIButton *s52;
    IBOutlet UIButton *s53;
    IBOutlet UIButton *s54;
    IBOutlet UIButton *s55;
    IBOutlet UIButton *s56;
    IBOutlet UIButton *s57;
    IBOutlet UIButton *s58;
    
    NSMutableArray *square13;
    IBOutlet UIImageView *square13Image;
    
    NSMutableArray *square14;
    IBOutlet UIImageView *square14Image;
    
    NSMutableArray *square15;
    IBOutlet UIImageView *square15Image;
    
    NSMutableArray *square16;
    IBOutlet UIImageView *square16Image;
    
    NSMutableArray *square17;
    IBOutlet UIImageView *square17Image;
    
    NSMutableArray *square18;
    IBOutlet UIImageView *square18Image;
    
    NSMutableArray *square19;
    IBOutlet UIImageView *square19Image;
    
    NSMutableArray *square20;
    IBOutlet UIImageView *square20Image;
    
    NSMutableArray *square21;
    IBOutlet UIImageView *square21Image;
    
    NSMutableArray *square22;
    IBOutlet UIImageView *square22Image;
    
    NSMutableArray *square23;
    IBOutlet UIImageView *square23Image;
    
    NSMutableArray *square24;
    IBOutlet UIImageView *square24Image;
    
    //
    //
    //  LINES 5&6
    //
    //
    
    BOOL s25D;
    BOOL s26D;
    BOOL s27D;
    BOOL s28D;
    BOOL s29D;
    BOOL s30D;
    BOOL s31D;
    BOOL s32D;
    BOOL s33D;
    BOOL s34D;
    BOOL s35D;
    BOOL s36D;
    
    IBOutlet UIButton *s59;
    IBOutlet UIButton *s60;
    IBOutlet UIButton *s61;
    IBOutlet UIButton *s62;
    IBOutlet UIButton *s63;
    IBOutlet UIButton *s64;
    IBOutlet UIButton *s65;
    IBOutlet UIButton *s66;
    IBOutlet UIButton *s67;
    IBOutlet UIButton *s68;
    IBOutlet UIButton *s69;
    IBOutlet UIButton *s70;
    IBOutlet UIButton *s71;
    IBOutlet UIButton *s72;
    IBOutlet UIButton *s73;
    IBOutlet UIButton *s74;
    IBOutlet UIButton *s75;
    IBOutlet UIButton *s76;
    IBOutlet UIButton *s77;
    IBOutlet UIButton *s78;
    IBOutlet UIButton *s79;
    IBOutlet UIButton *s80;
    IBOutlet UIButton *s81;
    IBOutlet UIButton *s82;
    IBOutlet UIButton *s83;
    IBOutlet UIButton *s84;
    
    NSMutableArray *square25;
    IBOutlet UIImageView *square25Image;
    
    NSMutableArray *square26;
    IBOutlet UIImageView *square26Image;
    
    NSMutableArray *square27;
    IBOutlet UIImageView *square27Image;
    
    NSMutableArray *square28;
    IBOutlet UIImageView *square28Image;
    
    NSMutableArray *square29;
    IBOutlet UIImageView *square29Image;
    
    NSMutableArray *square30;
    IBOutlet UIImageView *square30Image;
    
    NSMutableArray *square31;
    IBOutlet UIImageView *square31Image;
    
    NSMutableArray *square32;
    IBOutlet UIImageView *square32Image;
    
    NSMutableArray *square33;
    IBOutlet UIImageView *square33Image;
    
    NSMutableArray *square34;
    IBOutlet UIImageView *square34Image;
    
    NSMutableArray *square35;
    IBOutlet UIImageView *square35Image;
    
    NSMutableArray *square36;
    IBOutlet UIImageView *square36Image;
    
}

-(IBAction)tappedSquare:(id)sender;
-(IBAction)quit:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end
