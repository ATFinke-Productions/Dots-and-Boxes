//
//  MainViewController.m
//  line
//
//  Created by Andrew on 3/3/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "MainViewController.h"


#define notificationTime 1.5
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpBackground];

    isPlayer1 = YES;
    
    square01 = [NSMutableArray arrayWithObjects:@"1", @"7", @"8", @"14", nil];
    square02 = [NSMutableArray arrayWithObjects:@"2", @"8", @"9", @"15", nil];
    square03 = [NSMutableArray arrayWithObjects:@"3", @"9", @"10", @"16", nil];
    square04 = [NSMutableArray arrayWithObjects:@"4", @"10", @"11", @"17", nil];
    square05 = [NSMutableArray arrayWithObjects:@"5", @"11", @"12", @"18", nil];
    square06 = [NSMutableArray arrayWithObjects:@"6", @"12", @"13", @"19", nil];
    
    square07 = [NSMutableArray arrayWithObjects:@"14", @"20", @"21", @"27", nil];
    square08 = [NSMutableArray arrayWithObjects:@"15", @"21", @"22", @"28", nil];
    square09 = [NSMutableArray arrayWithObjects:@"16", @"22", @"23", @"29", nil];
    square10 = [NSMutableArray arrayWithObjects:@"17", @"23", @"24", @"30", nil];
    square11 = [NSMutableArray arrayWithObjects:@"18", @"24", @"25", @"31", nil];
    square12 = [NSMutableArray arrayWithObjects:@"19", @"25", @"26", @"32", nil];
    
    
    square13 = [NSMutableArray arrayWithObjects:@"27", @"33", @"34", @"40", nil];
    square14 = [NSMutableArray arrayWithObjects:@"28", @"34", @"35", @"41", nil];
    square15 = [NSMutableArray arrayWithObjects:@"29", @"35", @"36", @"42", nil];
    square16 = [NSMutableArray arrayWithObjects:@"30", @"36", @"37", @"43", nil];
    square17 = [NSMutableArray arrayWithObjects:@"31", @"37", @"38", @"44", nil];
    square18 = [NSMutableArray arrayWithObjects:@"32", @"38", @"39", @"45", nil];
    
    square19 = [NSMutableArray arrayWithObjects:@"40", @"46", @"47", @"53", nil];
    square20 = [NSMutableArray arrayWithObjects:@"41", @"47", @"48", @"54", nil];
    square21 = [NSMutableArray arrayWithObjects:@"42", @"48", @"49", @"55", nil];
    square22 = [NSMutableArray arrayWithObjects:@"43", @"49", @"50", @"56", nil];
    square23 = [NSMutableArray arrayWithObjects:@"44", @"50", @"51", @"57", nil];
    square24 = [NSMutableArray arrayWithObjects:@"45", @"51", @"52", @"58", nil];
    
    
    square25 = [NSMutableArray arrayWithObjects:@"53", @"59", @"60", @"66", nil];
    square26 = [NSMutableArray arrayWithObjects:@"54", @"60", @"61", @"67", nil];
    square27 = [NSMutableArray arrayWithObjects:@"55", @"61", @"62", @"68", nil];
    square28 = [NSMutableArray arrayWithObjects:@"56", @"62", @"63", @"69", nil];
    square29 = [NSMutableArray arrayWithObjects:@"57", @"63", @"64", @"70", nil];
    square30 = [NSMutableArray arrayWithObjects:@"58", @"64", @"65", @"71", nil];
    
    square31 = [NSMutableArray arrayWithObjects:@"66", @"72", @"73", @"79", nil];
    square32 = [NSMutableArray arrayWithObjects:@"67", @"73", @"74", @"80", nil];
    square33 = [NSMutableArray arrayWithObjects:@"68", @"74", @"75", @"81", nil];
    square34 = [NSMutableArray arrayWithObjects:@"69", @"75", @"76", @"82", nil];
    square35 = [NSMutableArray arrayWithObjects:@"70", @"76", @"77", @"83", nil];
    square36 = [NSMutableArray arrayWithObjects:@"71", @"77", @"78", @"84", nil];

    
    linesToAddToGrid = [NSMutableArray array];
    
   
    CATransition *animation = [CATransition animation];
    [animation setDuration:1.0];
    [animation setType:kCATransitionFade];
    [animation setSubtype:kCATransitionFromTop];
    [animation setSpeed:.5];
    [[self.view layer] addAnimation:animation forKey:nil];

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)tappedSquare:(id)sender{
    tag = [sender tag];

    for (int i = 0; i < [linesToAddToGrid count]; i++) {
        if ([[NSString stringWithFormat:@"%d",tag]isEqual:[linesToAddToGrid objectAtIndex:i]]) {
       /*     HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:HUD];
            HUD.mode = MBProgressHUDModeText;
            HUD.labelText = @"Bad Move";
            HUD.detailsLabelText = @"Please try a different space";
            [HUD show:YES];
            [HUD hide:YES afterDelay:notificationTime];*/
            return;
        }
    }
    
    [linesToAddToGrid addObject:[NSString stringWithFormat:@"%d",tag]];
    
    [self removeSpaceForLine];

}
-(void)removeSpaceForLine{
    for (int i = 0; i < [linesToAddToGrid count]; i++) {
        
    [square01 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
    if ([square01 count] == 0) {
        if (!s01D){
            if (isPlayer1) {
                square01Image.image = [UIImage imageNamed:@"p1.png"];
            }
            else {
                square01Image.image = [UIImage imageNamed:@"p2.png"];
            }
            s01D = YES;
            justTookSquare = YES;
            [self squareTaken];
        }
    }
    [square02 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
    if ([square02 count] == 0) {
        if (!s02D){
            if (isPlayer1) {
                square02Image.image = [UIImage imageNamed:@"p1.png"];
            }
            else {
                square02Image.image = [UIImage imageNamed:@"p2.png"];
            }
            s02D = YES;
            justTookSquare = YES;
            [self squareTaken];
        }
    }
    [square03 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
    if ([square03 count] == 0) {
        if (!s03D){
            if (isPlayer1) {
                square03Image.image = [UIImage imageNamed:@"p1.png"];
            }
            else {
                square03Image.image = [UIImage imageNamed:@"p2.png"];
            }
            s03D = YES;
            justTookSquare = YES;
            [self squareTaken];
        }
    }
    [square04 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
    if ([square04 count] == 0) {
        if (!s04D){
            if (isPlayer1) {
                square04Image.image = [UIImage imageNamed:@"p1.png"];
            }
            else {
                square04Image.image = [UIImage imageNamed:@"p2.png"];
            }
            s04D = YES;
            justTookSquare = YES;
            [self squareTaken];
        }
    }
    [square05 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
    if ([square05 count] == 0) {
        if (!s05D){
            if (isPlayer1) {
                square05Image.image = [UIImage imageNamed:@"p1.png"];
            }
            else {
                square05Image.image = [UIImage imageNamed:@"p2.png"];
            }
            s05D = YES;
            justTookSquare = YES;
            [self squareTaken];
        }
    }
    [square06 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
    if ([square06 count] == 0) {
        if (!s06D){
            if (isPlayer1) {
                square06Image.image = [UIImage imageNamed:@"p1.png"];
            }
            else {
                square06Image.image = [UIImage imageNamed:@"p2.png"];
            }
            s06D = YES;
            justTookSquare = YES;
            [self squareTaken];
        }
    }
    [square07 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
    if ([square07 count] == 0) {
        if (!s07D){
            if (isPlayer1) {
                square07Image.image = [UIImage imageNamed:@"p1.png"];
            }
            else {
                square07Image.image = [UIImage imageNamed:@"p2.png"];
            }
            s07D = YES;
            justTookSquare = YES;
            [self squareTaken];
        }
    }
    [square08 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
    if ([square08 count] == 0) {
        if (!s08D){
            if (isPlayer1) {
                square08Image.image = [UIImage imageNamed:@"p1.png"];
            }
            else {
                square08Image.image = [UIImage imageNamed:@"p2.png"];
            }
            s08D = YES;
            justTookSquare = YES;
            [self squareTaken];
        }
    }
    [square09 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
    if ([square09 count] == 0) {
        if (!s09D){
            if (isPlayer1) {
                square09Image.image = [UIImage imageNamed:@"p1.png"];
            }
            else {
                square09Image.image = [UIImage imageNamed:@"p2.png"];
            }
            s09D = YES;
            justTookSquare = YES;
            [self squareTaken];
        }
    }
    [square10 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
    if ([square10 count] == 0) {
        if (!s10D){
            if (isPlayer1) {
                square10Image.image = [UIImage imageNamed:@"p1.png"];
            }
            else {
                square10Image.image = [UIImage imageNamed:@"p2.png"];
            }
            s10D = YES;
            justTookSquare = YES;
            [self squareTaken];
        }
    }
    [square11 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
    if ([square11 count] == 0) {
        if (!s11D){
            if (isPlayer1) {
                square11Image.image = [UIImage imageNamed:@"p1.png"];
            }
            else {
                square11Image.image = [UIImage imageNamed:@"p2.png"];
            }
            s11D = YES;
            justTookSquare = YES;
            [self squareTaken];
        }
    }
    [square12 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
    if ([square12 count] == 0) {
        if (!s12D){
            if (isPlayer1) {
                square12Image.image = [UIImage imageNamed:@"p1.png"];
            }
            else {
                square12Image.image = [UIImage imageNamed:@"p2.png"];
            }
            s12D = YES;
            justTookSquare = YES;
            [self squareTaken];
        }
    }
        [square13 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square13 count] == 0) {
            if (!s13D){
                if (isPlayer1) {
                    square13Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square13Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s13D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square14 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square14 count] == 0) {
            if (!s14D){
                if (isPlayer1) {
                    square14Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square14Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s14D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square15 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square15 count] == 0) {
            if (!s15D){
                if (isPlayer1) {
                    square15Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square15Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s15D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square16 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square16 count] == 0) {
            if (!s16D){
                if (isPlayer1) {
                    square16Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square16Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s16D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square17 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square17 count] == 0) {
            if (!s17D){
                if (isPlayer1) {
                    square17Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square17Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s17D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square18 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square18 count] == 0) {
            if (!s18D){
                if (isPlayer1) {
                    square18Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square18Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s18D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square19 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square19 count] == 0) {
            if (!s19D){
                if (isPlayer1) {
                    square19Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square19Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s19D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square20 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square20 count] == 0) {
            if (!s20D){
                if (isPlayer1) {
                    square20Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square20Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s20D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square21 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square21 count] == 0) {
            if (!s21D){
                if (isPlayer1) {
                    square21Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square21Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s21D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square22 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square22 count] == 0) {
            if (!s22D){
                if (isPlayer1) {
                    square22Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square22Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s22D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square23 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square23 count] == 0) {
            if (!s23D){
                if (isPlayer1) {
                    square23Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square23Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s23D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square24 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square24 count] == 0) {
            if (!s24D){
                if (isPlayer1) {
                    square24Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square24Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s24D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square25 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square25 count] == 0) {
            if (!s25D){
                if (isPlayer1) {
                    square25Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square25Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s25D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square26 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square26 count] == 0) {
            if (!s26D){
                if (isPlayer1) {
                    square26Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square26Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s26D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square27 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square27 count] == 0) {
            if (!s27D){
                if (isPlayer1) {
                    square27Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square27Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s27D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square28 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square28 count] == 0) {
            if (!s28D){
                if (isPlayer1) {
                    square28Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square28Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s28D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square29 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square29 count] == 0) {
            if (!s29D){
                if (isPlayer1) {
                    square29Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square29Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s29D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square30 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square30 count] == 0) {
            if (!s30D){
                if (isPlayer1) {
                    square30Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square30Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s30D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square31 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square31 count] == 0) {
            if (!s31D){
                if (isPlayer1) {
                    square31Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square31Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s31D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square32 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square32 count] == 0) {
            if (!s32D){
                if (isPlayer1) {
                    square32Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square32Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s32D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square33 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square33 count] == 0) {
            if (!s33D){
                if (isPlayer1) {
                    square33Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square33Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s33D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square34 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square34 count] == 0) {
            if (!s34D){
                if (isPlayer1) {
                    square34Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square34Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s34D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square35 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square35 count] == 0) {
            if (!s35D){
                if (isPlayer1) {
                    square35Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square35Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s35D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        [square36 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square36 count] == 0) {
            if (!s36D){
                if (isPlayer1) {
                    square36Image.image = [UIImage imageNamed:@"p1.png"];
                }
                else {
                    square36Image.image = [UIImage imageNamed:@"p2.png"];
                }
                s36D = YES;
                justTookSquare = YES;
                [self squareTaken];
            }
        }
        
    
    int buttonId = [[NSString stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]intValue];

        
    [self buttonWithName:buttonId];
    }
    if (!justTookSquare) {
        if (isPlayer1) {
            isPlayer1 = NO;
            playerLabel.text = @"Player 2's Turn";
            
            /*HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:HUD];
            HUD.mode = MBProgressHUDModeText;
            HUD.labelText = @"Player 2's Turn";
            HUD.detailsLabelText = @"Please pass the device to the next player";
            [HUD show:YES];
            [HUD hide:YES afterDelay:notificationTime];*/
        }
        else {
            isPlayer1 = YES;
            playerLabel.text = @"Player 1's Turn";
            
            /*HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:HUD];
            HUD.mode = MBProgressHUDModeText;
            HUD.labelText = @"Player 1's Turn";
            HUD.detailsLabelText = @"Please pass the device to the next player";
            [HUD show:YES];
            [HUD hide:YES afterDelay:notificationTime];*/
        }
    }
    justTookSquare = NO;
    
    if ([linesToAddToGrid count]>=84) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:player1Score forKey:@"player1Score"];
        [defaults setInteger:player2Score forKey:@"player2Score"];
        [defaults synchronize];
        [self performSegueWithIdentifier:@"gameOver" sender:self];
    }
}


-(void)squareTaken{
    if (isPlayer1) {
        player1Score++;
        /*HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = @"Square Taken";
        HUD.detailsLabelText = @"It is still Player 1's Turn";
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];*/
    }
    else {
        player2Score++;
       /* HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = @"Square Taken";
        HUD.detailsLabelText = @"It is still Player 2's Turn";
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];*/
    }
    player1ScoreLabel.text = [NSString stringWithFormat:@"Player 1's Score: %lld",player1Score];
    player2ScoreLabel.text = [NSString stringWithFormat:@"Player 2's Score: %lld",player2Score];
}




-(void)buttonWithName:(int)buttonName {
    if (buttonName == 1 ) {
        [s01 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 2 ) {
        [s02 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 3 ) {
        [s03 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 4 ) {
        [s04 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 5 ) {
        [s05 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 6 ) {
        [s06 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 7 ) {
        [s07 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 8 ) {
        [s08 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 9 ) {
        [s09 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 10 ) {
        [s10 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 11 ) {
        [s11 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 12 ) {
        [s12 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 13 ) {
        [s13 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 14 ) {
        [s14 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 15 ) {
        [s15 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 16 ) {
        [s16 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 17 ) {
        [s17 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 18 ) {
        [s18 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 19 ) {
        [s19 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 20 ) {
        [s20 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 21 ) {
        [s21 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 22 ) {
        [s22 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 23 ) {
        [s23 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 24 ) {
        [s24 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 25 ) {
        [s25 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 26 ) {
        [s26 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 27 ) {
        [s27 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 28 ) {
        [s28 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 29 ) {
        [s29 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 30 ) {
        [s30 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 31 ) {
        [s31 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 32 ) {
        [s32 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 33 ) {
        [s33 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 34 ) {
        [s34 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 35 ) {
        [s35 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 36 ) {
        [s36 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 37 ) {
        [s37 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 38 ) {
        [s38 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 39 ) {
        [s39 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 40 ) {
        [s40 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 41 ) {
        [s41 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 42 ) {
        [s42 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 43 ) {
        [s43 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 44 ) {
        [s44 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 45 ) {
        [s45 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 46 ) {
        [s46 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 47 ) {
        [s47 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 48 ) {
        [s48 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 49 ) {
        [s49 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 50 ) {
        [s50 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 51 ) {
        [s51 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 52 ) {
        [s52 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 53 ) {
        [s53 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 54 ) {
        [s54 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 55 ) {
        [s55 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 56 ) {
        [s56 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 57 ) {
        [s57 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 58 ) {
        [s58 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 59 ) {
        [s59 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 60 ) {
        [s60 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 61 ) {
        [s61 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 62 ) {
        [s62 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 63 ) {
        [s63 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 64 ) {
        [s64 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 65 ) {
        [s65 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 66 ) {
        [s66 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 67 ) {
        [s67 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 68 ) {
        [s68 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 69 ) {
        [s69 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 70 ) {
        [s70 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 71 ) {
        [s71 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 72 ) {
        [s72 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 73 ) {
        [s73 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 74 ) {
        [s74 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 75 ) {
        [s75 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 76 ) {
        [s76 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 77 ) {
        [s77 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 78 ) {
        [s78 setImage:[self verticleLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 79 ) {
        [s79 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 80 ) {
        [s80 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 81 ) {
        [s81 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 82 ) {
        [s82 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 83 ) {
        [s83 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
    else if (buttonName == 84 ) {
        [s84 setImage:[self horizontialLineWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    }
}
/*
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
*/
- (UIImage *)horizontialLineWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 30.0f, 3.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
- (UIImage *)verticleLineWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 3.0f, 30.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (void)setUpBackground {
    float radius = 12.0;
    self.backgroundImageView.hidden = NO;
    [self.backgroundImageView.layer setMasksToBounds:YES];
    [self.backgroundImageView.layer setBorderColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.8].CGColor];
    [self.backgroundImageView.layer setBorderWidth:1.0];
    [self.backgroundImageView.layer setCornerRadius:radius];
}

-(IBAction)quit:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Are you sure?" message:@"If you quit, you will loose all progress in this game" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Quit", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


@end
