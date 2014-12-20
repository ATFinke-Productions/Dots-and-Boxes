//
//  MultiplayerViewController.m
//  line
//
//  Created by Andrew on 3/27/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "MultiplayerViewController.h"


#define notificationTime 1.5
@interface MultiplayerViewController ()

@end

@implementation MultiplayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpBackground];

    
    
    player1ScoreLabel.text = [NSString stringWithFormat:@"Player 1's Score: %lld",player1Score];
    player2ScoreLabel.text = [NSString stringWithFormat:@"Player 2's Score: %lld",player2Score];
    
    isCurrentTurnView.hidden = NO;
    
    [GCTurnBasedMatchHelper sharedInstance].delegate = self;

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
    squaresForPlayer1 = [NSMutableArray array];
    squaresForPlayer2 = [NSMutableArray array];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:.5];
    [animation setType:kCATransitionFade];
    [animation setSubtype:kCATransitionFromTop];
    [animation setSpeed:.2];
    [[self.view layer] addAnimation:animation forKey:nil];
    
    
    GKTurnBasedMatch *currentMatch = [[GCTurnBasedMatchHelper sharedInstance] currentMatch];
    NSMutableArray *currentMatchParticipents = [NSMutableArray arrayWithArray:currentMatch.participants];
    if ([currentMatchParticipents count]>0) {
        GKPlayer * checkPlayer = [currentMatchParticipents objectAtIndex:0];
        if ([checkPlayer.playerID isEqual:[GKLocalPlayer localPlayer].playerID]) {
            isPlayer1 = YES;
            NSLog(@"11");
        }
        else {
            isPlayer1 = NO;
            NSLog(@"22  %@  %@",[currentMatchParticipents objectAtIndex:0],[GKLocalPlayer localPlayer]);
            
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)menuButtonNavigtion{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)myNewSquareFillerAndIsPlayer1:(BOOL)player1 isRecving:(BOOL)reciving{
    if (player1) {
        player1Score = 0;
        for (NSString *squareNumbers in squaresForPlayer1) {
            player1Score ++;
            if ([squareNumbers isEqual:@"1"]) {
                square01Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"2"]) {
                square02Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"3"]) {
                square03Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"4"]) {
                square04Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"5"]) {
                square05Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"6"]) {
                square06Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"7"]) {
                square07Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"8"]) {
                square08Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"9"]) {
                square09Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"10"]) {
                square10Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"11"]) {
                square11Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"12"]) {
                square12Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"13"]) {
                square13Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"14"]) {
                square14Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"15"]) {
                square15Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"16"]) {
                square16Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"17"]) {
                square17Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"18"]) {
                square18Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"19"]) {
                square19Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"20"]) {
                square20Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"21"]) {
                square21Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"22"]) {
                square22Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"23"]) {
                square23Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"24"]) {
                square24Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"25"]) {
                square25Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"26"]) {
                square26Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"27"]) {
                square27Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"28"]) {
                square28Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"29"]) {
                square29Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"30"]) {
                square30Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"31"]) {
                square31Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"32"]) {
                square32Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"33"]) {
                square33Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"34"]) {
                square34Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"35"]) {
                square35Image.image = [self imageForPlayer:1];
            }
            else if ([squareNumbers isEqual:@"36"]) {
                square36Image.image = [self imageForPlayer:1];
            }
            else{
                NSLog(@"ERROR WITH SQUARE %@",squareNumbers);
            }
        }
        
        if ([squaresForPlayer1 count] > 0 && isPlayer1 && !reciving) {
            HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:HUD];
            HUD.mode = MBProgressHUDModeText;
            HUD.labelText = @"Square Taken";
            [HUD show:YES];
            [HUD hide:YES afterDelay:.5];
        }
    }
    else if (!player1) {
        player2Score = 0;
        for (NSString *squareNumbers in squaresForPlayer2) {
            player2Score ++;
            if ([squareNumbers isEqual:@"1"]) {
                square01Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"2"]) {
                square02Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"3"]) {
                square03Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"4"]) {
                square04Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"5"]) {
                square05Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"6"]) {
                square06Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"7"]) {
                square07Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"8"]) {
                square08Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"9"]) {
                square09Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"10"]) {
                square10Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"11"]) {
                square11Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"12"]) {
                square12Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"13"]) {
                square13Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"14"]) {
                square14Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"15"]) {
                square15Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"16"]) {
                square16Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"17"]) {
                square17Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"18"]) {
                square18Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"19"]) {
                square19Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"20"]) {
                square20Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"21"]) {
                square21Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"22"]) {
                square22Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"23"]) {
                square23Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"24"]) {
                square24Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"25"]) {
                square25Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"26"]) {
                square26Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"27"]) {
                square27Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"28"]) {
                square28Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"29"]) {
                square29Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"30"]) {
                square30Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"31"]) {
                square31Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"32"]) {
                square32Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"33"]) {
                square33Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"34"]) {
                square34Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"35"]) {
                square35Image.image = [self imageForPlayer:2];
            }
            else if ([squareNumbers isEqual:@"36"]) {
                square36Image.image = [self imageForPlayer:2];
            }
            else{
                NSLog(@"ERROR WITH SQUARE %@",squareNumbers);
            }
        }
        
        if ([squaresForPlayer2 count] > 0 && !player1 && !reciving) {
            
            HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:HUD];
            HUD.mode = MBProgressHUDModeText;
            HUD.labelText = @"Square Taken";
            [HUD show:YES];
            [HUD hide:YES afterDelay:1];
        }
    }
    
    player1ScoreLabel.text = [NSString stringWithFormat:@"Player 1's Score: %lld",player1Score];
    player2ScoreLabel.text = [NSString stringWithFormat:@"Player 2's Score: %lld",player2Score];

    if (!reciving){
        
        GKTurnBasedMatch *currentMatch = [[GCTurnBasedMatchHelper sharedInstance] currentMatch];
        NSUInteger currentIndex = [currentMatch.participants indexOfObject:currentMatch.currentParticipant];
        
        NSMutableArray *nextParticipants = [NSMutableArray array];
        for (int i = 0; i < [currentMatch.participants count]; i++) {
            int indx = (i + currentIndex + 1) % [currentMatch.participants count];
            GKTurnBasedParticipant *participant = [currentMatch.participants objectAtIndex:indx];
            //1
            if (participant.matchOutcome == GKTurnBasedMatchOutcomeNone) {
                [nextParticipants addObject:participant];
            }
            
        }
        
        if (!justTookSquare && player2Score+player1Score < 36) {
            
            [currentMatch endTurnWithNextParticipants:nextParticipants turnTimeout:36000 matchData:[self convertArraysToData] completionHandler: ^(NSError *error) {
                if (error) {
                    NSLog(@"%@", error);
                    //self.statusLabel.text = @"Oops, there was a problem. Try that again.";
                } else {
                    isCurrentTurnView.hidden = NO;
                    playerLabel.text = [NSString stringWithFormat:@"Player %d's Turn", [currentMatch.participants indexOfObject:currentMatch.currentParticipant] + 1];
                    // self.statusLabel.text = @"Your turn is over.";
                    // self.textInputField.enabled = NO;
                }
            }];
        }
        else if (justTookSquare && player2Score+player1Score < 36){
            [currentMatch saveCurrentTurnWithMatchData:[self convertArraysToData] completionHandler:^(NSError *error) {
                if (error) {
                    NSLog(@"%@", error);
                    //self.statusLabel.text = @"Oops, there was a problem. Try that again.";
                }
            }];
        }
        else if (player1Score+player2Score>=36){
            [currentMatch endMatchInTurnWithMatchData:[self convertArraysToData] completionHandler:^(NSError *error) {
                isCurrentTurnView.hidden = NO;
                if (error) {
                    NSLog(@"%@", error);
                    //self.statusLabel.text = @"Oops, there was a problem. Try that again.";
                }
            }];
        }
        else {
            isCurrentTurnView.hidden = YES;
            playerLabel.text = [NSString stringWithFormat:@"Player %d's Turn (that's you)", [currentMatch.participants indexOfObject:currentMatch.currentParticipant] + 1 ];
        }
        justTookSquare = NO;
    }
    
    else {
        isCurrentTurnView.hidden = YES;
    }
    
    if (player1Score+player2Score >= 36) {
        NSLog(@"gameover");
        GKTurnBasedMatch *currentMatch = [[GCTurnBasedMatchHelper sharedInstance] currentMatch];
        
        if (player1Score > player2Score) {
            [self didPlayer1Win:YES orTie:NO inMatch:currentMatch];
        }
        else if (player1Score < player2Score) {
            [self didPlayer1Win:NO orTie:NO inMatch:currentMatch];
        }
        else if (player1Score == player2Score) {
            [self didPlayer1Win:YES orTie:YES inMatch:currentMatch];
        }
    }
    }
-(void)didPlayer1Win:(BOOL)play1Win orTie:(BOOL)tie inMatch:(GKTurnBasedMatch*)currentMatch{
    
    NSMutableArray *currentMatchParticipents = [NSMutableArray arrayWithArray:currentMatch.participants];
    NSLog(@"DONE");
    if (tie) {
        for (GKTurnBasedParticipant *part in currentMatchParticipents){
            part.matchOutcome = GKTurnBasedMatchOutcomeTied;
        }
        return;
    }
    if (play1Win) {
        GKTurnBasedParticipant *part = [currentMatchParticipents objectAtIndex:0];
        part.matchOutcome = GKTurnBasedMatchOutcomeWon;
        GKTurnBasedParticipant *part2 = [currentMatchParticipents objectAtIndex:1];
        part2.matchOutcome = GKTurnBasedMatchOutcomeLost;
    }
    else {
        GKTurnBasedParticipant *part = [currentMatchParticipents objectAtIndex:0];
        part.matchOutcome = GKTurnBasedMatchOutcomeLost;
        GKTurnBasedParticipant *part2 = [currentMatchParticipents objectAtIndex:1];
        part2.matchOutcome = GKTurnBasedMatchOutcomeWon;
    }
}
-(UIImage *)imageForPlayer:(int)player{
    UIImage *playerImage;
    if (player == 1) {
        playerImage =  [self imageWithColor:[UIColor yellowColor]];
    }
    else if (player == 2) {
        playerImage =  [self imageWithColor:[UIColor blueColor]];
    }
    else if (player == 3) {
        playerImage =  [self imageWithColor:[UIColor greenColor]];
    }
    else if (player == 4) {
        playerImage =  [self imageWithColor:[UIColor grayColor]];
    }
    return playerImage;
}


-(void)convertMatchDataToArrays:(GKTurnBasedMatch *)match{
    NSLog(@"converting to arrays");
    if ([match.matchData bytes]) {
        [arrayWithData removeAllObjects];
        arrayWithData = [NSKeyedUnarchiver unarchiveObjectWithData:match.matchData];
        BOOL square1ArraySet = false;
        BOOL square2ArraySet = false;
        BOOL linesArraySet = false;
        for (NSMutableArray *matchDataArrays in arrayWithData) {
            if (!linesArraySet) {
                [linesToAddToGrid removeAllObjects];
                linesToAddToGrid = [NSMutableArray arrayWithArray:matchDataArrays];
                linesArraySet = true;
                NSLog(@"\n%@\n LINES FOR GRID",linesToAddToGrid);
            }
            else if (!square1ArraySet) {
                [squaresForPlayer1 removeAllObjects];
                squaresForPlayer1 = [NSMutableArray arrayWithArray:matchDataArrays];
                square1ArraySet = true;
                NSLog(@"\n%@\n SQUARES FOR 1",squaresForPlayer1);
            }
            else if (!square2ArraySet) {
                [squaresForPlayer2 removeAllObjects];
                squaresForPlayer2 = [NSMutableArray arrayWithArray:matchDataArrays];
                square2ArraySet = true;
                NSLog(@"\n%@\n SQUARES FOR 2",squaresForPlayer2);
            }
        }
        [self removeSpaceForLineisReciving:YES];
        [self myNewSquareFillerAndIsPlayer1:YES isRecving:YES];
        [self myNewSquareFillerAndIsPlayer1:NO isRecving:YES];
        //self.mainTextController.text = storySoFar;
    }
}

-(NSData *)convertArraysToData{
    
    [arrayWithData removeAllObjects];
    arrayWithData = [NSMutableArray arrayWithObjects:linesToAddToGrid,squaresForPlayer1,squaresForPlayer2, nil];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrayWithData];
    return data;
}

-(IBAction)tappedSquare:(id)sender{
    isCurrentTurnView.hidden = YES;
    tag = [sender tag];
    
    for (int i = 0; i < [linesToAddToGrid count]; i++) {
        if ([[NSString stringWithFormat:@"%d",tag]isEqual:[linesToAddToGrid objectAtIndex:i]]) {
            HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:HUD];
            HUD.mode = MBProgressHUDModeText;
            HUD.labelText = @"Space Taken";
            HUD.detailsLabelText = @"Please try a different space";
            [HUD show:YES];
            [HUD hide:YES afterDelay:notificationTime];
            return;
        }
    }
    
    [linesToAddToGrid addObject:[NSString stringWithFormat:@"%d",tag]];
    
    [self removeSpaceForLineisReciving:NO];
    
}


- (IBAction)presentGCTurnViewController:(id)sender {
    [[GCTurnBasedMatchHelper sharedInstance] findMatchWithMinPlayers:2 maxPlayers:2 viewController:self];
}

-(void)enterNewGame:(GKTurnBasedMatch *)match {
    NSLog(@"Entering new game...");
    match.message = @"2 Player Game";
    for (UIButton * lineButton in self.view.subviews) {
        if (lineButton.tag != 100 && lineButton.tag != 1000) {
            [lineButton setImage:[UIImage imageNamed:@"t.png"] forState:UIControlStateNormal];
        }
    }
    for (UIImageView * blockView in self.view.subviews) {
        if (blockView.tag == 100) {
            blockView.image = [UIImage imageNamed:@"guy.png"];
        }
    }
    player1Score = 0;
    player2Score = 0;
    [self viewDidLoad];
    int playerNum = [match.participants indexOfObject:match.currentParticipant] + 1;
    playerLabel.text = [NSString stringWithFormat:@"Player %d's Turn (that's you)", playerNum];
    //match.message = [NSString stringWithFormat:@"Player %d's Turn", playerNum];
    isCurrentTurnView.hidden = YES;
    //self.textInputField.enabled = YES;
    //self.mainTextController.text = @"Once upon a time";
}

-(void)takeTurn:(GKTurnBasedMatch *)match {
    NSLog(@"Taking turn for existing game...");
    for (UIButton * lineButton in self.view.subviews) {
        if (lineButton.tag != 100 && lineButton.tag != 1000) {
            [lineButton setImage:[UIImage imageNamed:@"t.png"] forState:UIControlStateNormal];
        }
    }
    for (UIImageView * blockView in self.view.subviews) {
        if (blockView.tag == 100) {
            blockView.image = [UIImage imageNamed:@"guy.png"];
        }
    }
    [self viewDidLoad];
    int playerNum = [match.participants indexOfObject:match.currentParticipant] + 1;
    
    NSString *statusString = [NSString stringWithFormat:@"Player %d's Turn (that's you)", playerNum];
    isCurrentTurnView.hidden = YES;
    playerLabel.text = statusString;
   // self.textInputField.enabled = YES;
    [self convertMatchDataToArrays:match];
    if (player1Score+player2Score >= 36) {
        NSLog(@"gameover");
        GKTurnBasedMatch *currentMatch = [[GCTurnBasedMatchHelper sharedInstance] currentMatch];
        
        if (player1Score > player2Score) {
            [self didPlayer1Win:YES orTie:NO inMatch:currentMatch];
        }
        else if (player1Score < player2Score) {
            [self didPlayer1Win:NO orTie:NO inMatch:currentMatch];
        }
        else if (player1Score == player2Score) {
            [self didPlayer1Win:YES orTie:YES inMatch:currentMatch];
        }
    }
}


-(void)layoutMatch:(GKTurnBasedMatch *)match {
    for (UIButton * lineButton in self.view.subviews) {
        if (lineButton.tag != 100 && lineButton.tag != 1000) {
            [lineButton setImage:[UIImage imageNamed:@"t.png"] forState:UIControlStateNormal];
        }
    }
    for (UIImageView * blockView in self.view.subviews) {
        if (blockView.tag == 100) {
            blockView.image = [UIImage imageNamed:@"guy.png"];
        }
    }
 
    [self viewDidLoad];
    NSLog(@"Viewing match where it's not our turn...");

    isCurrentTurnView.hidden = NO;
    NSString *statusString;
    
    if (match.status == GKTurnBasedMatchStatusEnded) {
        statusString = @"Match Ended";
    } else {
        int playerNum = [match.participants indexOfObject:match.currentParticipant] + 1;
        statusString = [NSString stringWithFormat:@"Player %d's Turn", playerNum];
    }
    
    playerLabel.text = statusString;
    //self.textInputField.enabled = NO;
    [self convertMatchDataToArrays:match];
    if (player1Score+player2Score >= 36) {
        NSLog(@"gameover");
        GKTurnBasedMatch *currentMatch = [[GCTurnBasedMatchHelper sharedInstance] currentMatch];
        
        if (player1Score > player2Score) {
            [self didPlayer1Win:YES orTie:NO inMatch:currentMatch];
        }
        else if (player1Score < player2Score) {
            [self didPlayer1Win:NO orTie:NO inMatch:currentMatch];
        }
        else if (player1Score == player2Score) {
            [self didPlayer1Win:YES orTie:YES inMatch:currentMatch];
        }
    }
}

-(void)recieveEndGame:(GKTurnBasedMatch *)match {
    
    if (player1Score>player2Score) {
        MBAlertView *alert = [MBAlertView alertWithBody:@"Results\n\n1st:  Player 1\n\n2nd: Player 2\n\n" cancelTitle:@"Menu" cancelBlock:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        alert.size = CGSizeMake(280, 180);
        [alert addToDisplayQueue];
    }
    else if (player1Score>player2Score) {
        MBAlertView *alert = [MBAlertView alertWithBody:@"Results\n\n1st:  Player 2\n\n2nd: Player 1\n\n" cancelTitle:@"Menu" cancelBlock:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        alert.size = CGSizeMake(280, 180);
        [alert addToDisplayQueue];
    }
    else {
        MBAlertView *alert = [MBAlertView alertWithBody:@"Results\n\nTIE" cancelTitle:@"Menu" cancelBlock:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        alert.size = CGSizeMake(280, 120);
        [alert addToDisplayQueue];
    }
    
    [self layoutMatch:match];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 1:
            [[GCTurnBasedMatchHelper sharedInstance] setCurrentMatch:[GCTurnBasedMatchHelper sharedInstance].alternateMatch];
            
            if ([[GCTurnBasedMatchHelper sharedInstance].currentMatch.currentParticipant.playerID isEqualToString:[GKLocalPlayer localPlayer].playerID]) {
                
                [self takeTurn:[GCTurnBasedMatchHelper sharedInstance].currentMatch];
            } else {
                [self layoutMatch:[GCTurnBasedMatchHelper sharedInstance].currentMatch];
            }
            break;
        case 2:
            [self performSegueWithIdentifier:@"PresentCustomGUI" sender:nil];
            break;
        default:
            break;
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
    return YES;
}

-(void)removeSpaceForLineisReciving:(BOOL)reciving{
    //NSLog(@"%@ FROM REMOVE SPACE",linesToAddToGrid);
    BOOL shouldUpdateSquares = NO;
    for (int i = 0; i < [linesToAddToGrid count]; i++) {
        
        [square01 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square01 count] == 0) {
            if ([self isSquareAlreadyTaken:1]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"1"];
                }
                else {
                    [squaresForPlayer2 addObject:@"1"];
                }
            }
        }

        [square02 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square02 count] == 0) {
            
            if ([self isSquareAlreadyTaken:2]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"2"];
                }
                else {
                    [squaresForPlayer2 addObject:@"2"];
                }
            }
        }
        
        [square03 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square03 count] == 0) {
            
            if ([self isSquareAlreadyTaken:3]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"3"];
                }
                else {
                    [squaresForPlayer2 addObject:@"3"];
                }
            }
        }
        
        [square04 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square04 count] == 0) {
            
            if ([self isSquareAlreadyTaken:4]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"4"];
                }
                else {
                    [squaresForPlayer2 addObject:@"4"];
                }
            }
        }
        [square05 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square05 count] == 0) {
            
            if ([self isSquareAlreadyTaken:5]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"5"];
                }
                else {
                    [squaresForPlayer2 addObject:@"5"];
                }
            }
        }
        [square06 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square06 count] == 0) {
            
            if ([self isSquareAlreadyTaken:6]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"6"];
                }
                else {
                    [squaresForPlayer2 addObject:@"6"];
                }
            }
        }
        [square07 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square07 count] == 0) {
            
            if ([self isSquareAlreadyTaken:7]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"7"];
                }
                else {
                    [squaresForPlayer2 addObject:@"7"];
                }
            }
        }
        [square08 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square08 count] == 0) {
            
            if ([self isSquareAlreadyTaken:8]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"8"];
                }
                else {
                    [squaresForPlayer2 addObject:@"8"];
                }
            }
        }
        [square09 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square09 count] == 0) {
            
            if ([self isSquareAlreadyTaken:9]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"9"];
                }
                else {
                    [squaresForPlayer2 addObject:@"9"];
                }
            }
        }
        [square10 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square10 count] == 0) {
            
            if ([self isSquareAlreadyTaken:10]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"10"];
                }
                else {
                    [squaresForPlayer2 addObject:@"10"];
                }
            }
        }
        [square11 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square11 count] == 0) {
            
            if ([self isSquareAlreadyTaken:11]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"11"];
                }
                else {
                    [squaresForPlayer2 addObject:@"11"];
                }
            }
        }
        [square12 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square12 count] == 0) {
            
            if ([self isSquareAlreadyTaken:12]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"12"];
                }
                else {
                    [squaresForPlayer2 addObject:@"12"];
                }
            }
        }
        [square13 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square13 count] == 0) {
            
            if ([self isSquareAlreadyTaken:13]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"13"];
                }
                else {
                    [squaresForPlayer2 addObject:@"13"];
                }
            }
        }
        [square14 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square14 count] == 0) {
            
            if ([self isSquareAlreadyTaken:14]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"14"];
                }
                else {
                    [squaresForPlayer2 addObject:@"14"];
                }
            }
        }
        [square15 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square15 count] == 0) {
            
            if ([self isSquareAlreadyTaken:15]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"15"];
                }
                else {
                    [squaresForPlayer2 addObject:@"15"];
                }
            }
        }
        [square16 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square16 count] == 0) {
            
            if ([self isSquareAlreadyTaken:16]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"16"];
                }
                else {
                    [squaresForPlayer2 addObject:@"16"];
                }
            }
        }
        [square17 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square17 count] == 0) {
            
            if ([self isSquareAlreadyTaken:17]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"17"];
                }
                else {
                    [squaresForPlayer2 addObject:@"17"];
                }
            }
        }
        [square18 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square18 count] == 0) {
            
            if ([self isSquareAlreadyTaken:18]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"18"];
                }
                else {
                    [squaresForPlayer2 addObject:@"18"];
                }
            }
        }
        [square19 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square19 count] == 0) {
            
            if ([self isSquareAlreadyTaken:19]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"19"];
                }
                else {
                    [squaresForPlayer2 addObject:@"19"];
                }
            }
        }
        [square20 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square20 count] == 0) {
            
            if ([self isSquareAlreadyTaken:20]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"20"];
                }
                else {
                    [squaresForPlayer2 addObject:@"20"];
                }
            }
        }
        [square21 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square21 count] == 0) {
            
            if ([self isSquareAlreadyTaken:21]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"21"];
                }
                else {
                    [squaresForPlayer2 addObject:@"21"];
                }
            }
        }
        [square22 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square22 count] == 0) {
            
            if ([self isSquareAlreadyTaken:22]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"22"];
                }
                else {
                    [squaresForPlayer2 addObject:@"22"];
                }
            }
        }
        [square23 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square23 count] == 0) {
            
            if ([self isSquareAlreadyTaken:23]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"23"];
                }
                else {
                    [squaresForPlayer2 addObject:@"23"];
                }
            }
        }
        [square24 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square24 count] == 0) {
            
            if ([self isSquareAlreadyTaken:24]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"24"];
                }
                else {
                    [squaresForPlayer2 addObject:@"24"];
                }
            }
        }
        [square25 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square25 count] == 0) {
            
            if ([self isSquareAlreadyTaken:25]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"25"];
                }
                else {
                    [squaresForPlayer2 addObject:@"25"];
                }
            }
        }
        [square26 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square26 count] == 0) {
            
            if ([self isSquareAlreadyTaken:26]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"26"];
                }
                else {
                    [squaresForPlayer2 addObject:@"26"];
                }
            }
        }
        [square27 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square27 count] == 0) {
            
            if ([self isSquareAlreadyTaken:27]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"27"];
                }
                else {
                    [squaresForPlayer2 addObject:@"27"];
                }
            }
        }
        [square28 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square28 count] == 0) {
            
            if ([self isSquareAlreadyTaken:28]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"28"];
                }
                else {
                    [squaresForPlayer2 addObject:@"28"];
                }
            }
        }
        [square29 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square29 count] == 0) {
            
            if ([self isSquareAlreadyTaken:29]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"29"];
                }
                else {
                    [squaresForPlayer2 addObject:@"29"];
                }
            }
        }
        [square30 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square30 count] == 0) {
            
            if ([self isSquareAlreadyTaken:30]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"30"];
                }
                else {
                    [squaresForPlayer2 addObject:@"30"];
                }
            }
        }
        [square31 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square31 count] == 0) {
            
            if ([self isSquareAlreadyTaken:31]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"31"];
                }
                else {
                    [squaresForPlayer2 addObject:@"31"];
                }
            }
        }
        [square32 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square32 count] == 0) {
            
            if ([self isSquareAlreadyTaken:32]&&!reciving) {
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"32"];
                }
                else {
                    [squaresForPlayer2 addObject:@"32"];
                }
            }
        }
        [square33 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square33 count] == 0) {
            
            if ([self isSquareAlreadyTaken:33]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"33"];
                }
                else {
                    [squaresForPlayer2 addObject:@"33"];
                }
            }
        }
        [square34 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square34 count] == 0) {
            
            if ([self isSquareAlreadyTaken:34]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"34"];
                }
                else {
                    [squaresForPlayer2 addObject:@"34"];
                }
            }
        }
        [square35 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square35 count] == 0) {
            
            if ([self isSquareAlreadyTaken:35]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"35"];
                }
                else {
                    [squaresForPlayer2 addObject:@"35"];
                }
            }
        }
        [square36 removeObject:[NSString  stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]];
        if ([square36 count] == 0) {
            
            if ([self isSquareAlreadyTaken:36]&&!reciving) {
                shouldUpdateSquares = YES;
                if (isPlayer1) {
                    [squaresForPlayer1 addObject:@"36"];
                }
                else {
                    [squaresForPlayer2 addObject:@"36"];
                }
            }
        }
        
        int buttonId = [[NSString stringWithFormat:@"%@",[linesToAddToGrid objectAtIndex:i]]intValue];
        
        [self buttonWithName:buttonId];
    }
    
    if (shouldUpdateSquares) {
        justTookSquare = YES;
        [self myNewSquareFillerAndIsPlayer1:isPlayer1 isRecving:reciving];
    }
    else {
        justTookSquare = NO;
        if (!reciving){
            
            GKTurnBasedMatch *currentMatch = [[GCTurnBasedMatchHelper sharedInstance] currentMatch];
            NSUInteger currentIndex = [currentMatch.participants indexOfObject:currentMatch.currentParticipant];
            
            NSMutableArray *nextParticipants = [NSMutableArray array];
            for (int i = 0; i < [currentMatch.participants count]; i++) {
                int indx = (i + currentIndex + 1) % [currentMatch.participants count];
                GKTurnBasedParticipant *participant = [currentMatch.participants objectAtIndex:indx];
                //1
                if (participant.matchOutcome == GKTurnBasedMatchOutcomeNone) {
                    [nextParticipants addObject:participant];
                }
                
            }
            
            if (!justTookSquare) {
                
                [currentMatch endTurnWithNextParticipants:nextParticipants turnTimeout:36000 matchData:[self convertArraysToData] completionHandler: ^(NSError *error) {
                    if (error) {
                        NSLog(@"%@", error);
                        //self.statusLabel.text = @"Oops, there was a problem. Try that again.";
                    } else {
                        isCurrentTurnView.hidden = NO;
                        playerLabel.text = [NSString stringWithFormat:@"Player %d's Turn", [currentMatch.participants indexOfObject:currentMatch.currentParticipant] + 1];
                        // self.statusLabel.text = @"Your turn is over.";
                        // self.textInputField.enabled = NO;
                    }
                }];
            }
            else {
                isCurrentTurnView.hidden = YES;
                playerLabel.text = [NSString stringWithFormat:@"Player %d's Turn (that's you)", [currentMatch.participants indexOfObject:currentMatch.currentParticipant] + 1 ];
            }
            
            
            justTookSquare = NO;
        }
        
        
        else {
            isCurrentTurnView.hidden = YES;
        }
    }
    
    
    /*
    if ([linesToAddToGrid count]>=84) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:player1Score forKey:@"player1Score"];
        [defaults setInteger:player2Score forKey:@"player2Score"];
        [defaults synchronize];
        [self performSegueWithIdentifier:@"gameOver" sender:self];
    }*/
    
    
}


-(void)buttonWithName:(int)buttonName {
    if (buttonName == 1 ) {
        [s01 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 2 ) {
        [s02 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 3 ) {
        [s03 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 4 ) {
        [s04 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 5 ) {
        [s05 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 6 ) {
        [s06 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
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
        [s14 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 15 ) {
        [s15 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 16 ) {
        [s16 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 17 ) {
        [s17 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 18 ) {
        [s18 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 19 ) {
        [s19 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
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
        [s27 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 28 ) {
        [s28 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 29 ) {
        [s29 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 30 ) {
        [s30 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 31 ) {
        [s31 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 32 ) {
        [s32 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
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
        [s40 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 41 ) {
        [s41 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 42 ) {
        [s42 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 43 ) {
        [s43 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 44 ) {
        [s44 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 45 ) {
        [s45 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
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
        [s53 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 54 ) {
        [s54 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 55 ) {
        [s55 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 56 ) {
        [s56 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 57 ) {
        [s57 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 58 ) {
        [s58 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
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
        [s66 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 67 ) {
        [s67 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 68 ) {
        [s68 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 69 ) {
        [s69 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 70 ) {
        [s70 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 71 ) {
        [s71 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
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
        [s79 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 80 ) {
        [s80 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 81 ) {
        [s81 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 82 ) {
        [s82 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 83 ) {
        [s83 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
    else if (buttonName == 84 ) {
        [s84 setImage:[UIImage imageNamed:@"tt2.png"] forState:UIControlStateNormal];
    }
}

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
 /*
 -(void)squareTakenImageUpdate:(UIImageView*)square{
 
 square.image = [self imageWithColor:[UIColor blackColor]];
 }*/


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
