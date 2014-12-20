//
//  4PlayerMultiplayerViewController.m
//  dot
//
//  Created by Andrew on 4/1/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "GameViewController.h"

#define notificationTime .5
#define errorMessage @"Looks like the following error occured when trying to send that move to Game Center:"
@interface GameViewController ()

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self navigationSetUp];
    [Flurry logEvent:@"Enter Multiplayer View"];
    defaults = [NSUserDefaults standardUserDefaults];
    userBoardColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userBoardColor"]];
    userLineColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userLineColor"]];
    self.navigationController.navigationBar.tintColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userViewColor"]];
    [self makeThingsLookPretty];
    [self configSquares];
    
    [GCTurnBasedMatchHelper sharedInstance].delegate = self;

    linesToAddToGrid = [NSMutableArray array];
    squaresForPlayer1 = [NSMutableArray array];
    squaresForPlayer2 = [NSMutableArray array];
    squaresForPlayer3 = [NSMutableArray array];
    squaresForPlayer4 = [NSMutableArray array];
    if ([[UIScreen mainScreen] bounds].size.height == 1024) {
        for (UIImageView *item in self.view.subviews) {
            if (item.tag != 10000) {
                item.frame = CGRectOffset(item.frame, [[UIScreen mainScreen] bounds].size.width/3.5, [[UIScreen mainScreen] bounds].size.height/4);
                if (self.interfaceOrientation == 4 || self.interfaceOrientation == 3) {
                    item.frame = CGRectOffset(item.frame, 130, -130);
                }
            }
        }
    }
}

-(void)navigationSetUp{
     shareButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
     matchPresent = [[UIBarButtonItem alloc]initWithTitle:@"Matches" style:UIBarButtonItemStylePlain target:self action:@selector(showGCView)];
    if ([[UIScreen mainScreen] bounds].size.height != 1024) {
        self.navigationItem.rightBarButtonItems = @[matchPresent,shareButton];
    }
    else {
        self.navigationItem.rightBarButtonItems = @[matchPresent];
    }
}



                                      
-(void)share{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(320, 310), YES, 1.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    imageLayer.contents = (id) img.CGImage;
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = 30;
    imageLayer.borderWidth = 4;
    imageLayer.borderColor = [UIColor blackColor].CGColor;
    UIGraphicsBeginImageContext(img.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [Flurry logEvent:@"Share"];
    
    
    UIActivityViewController * vc = [[UIActivityViewController alloc]initWithActivityItems:@[roundedImage,@"Check out my board for my current match in Dots and Boxes on the App Store: http://bit.ly/10vrZrk"] applicationActivities:nil];
    vc.excludedActivityTypes = @[UIActivityTypeMessage];
    [self presentViewController:vc animated:YES completion:^{
        [AudioPlayer playSound:@"Share" ofType:@"caf"];
    }];
}
                                      
- (void)showGCView {
    isShowingResults = NO;
    [[GCTurnBasedMatchHelper sharedInstance] findMatchWithMinPlayers:2 maxPlayers:4 viewController:self];
}
                                      
-(void)configSquares{
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
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setScoreFromMatch:(BOOL)reciving{
    NSMutableArray * squaresTakenArray = [NSMutableArray arrayWithObjects:squaresForPlayer1,squaresForPlayer2,squaresForPlayer3,squaresForPlayer4, nil];

    player1Score = [squaresForPlayer1 count];
    player2Score = [squaresForPlayer2 count];
    player3Score = [squaresForPlayer3 count];
    player4Score = [squaresForPlayer4 count];
    
    
    for (int player = 0; player < [[GCTurnBasedMatchHelper sharedInstance].currentMatch.participants count]; player++) {
        for (NSString *squareNumbers in squaresTakenArray[player]) {
            for (UIImageView * imageView in self.view.subviews) {
                if (240 > imageView.tag && 200 < imageView.tag) {
                    if (imageView.tag - 200 == [squareNumbers intValue]) {
                        imageView.image = [[UIColorForString sharedInstance] imageForColorWithString:[defaults valueForKey:[NSString stringWithFormat:@"userP%dColor",player + 1]] forType:nil];
                        if (!reciving) {
                            [Flurry logEvent:@"Took Square"];
                        }
                    }
                }
            }
        }
    }
    
    [self setMatchScoreForMatch:[GCTurnBasedMatchHelper sharedInstance].currentMatch andMessage:!reciving];
    
    if (!reciving){
        
        if (!justTookSquare) {
            playerLabel.text = @"Sending Turn...";
            [MBAlertView dismissCurrentHUD];
            [MBHUDView dismissCurrentHUD];
            [MBHUDView hudWithBody:@"Loading..." type:MBAlertViewHUDTypeActivityIndicator hidesAfter:3600 show:YES];
        }
        
        
        GKTurnBasedMatch *currentMatch = [[GCTurnBasedMatchHelper sharedInstance] currentMatch];
        NSUInteger currentIndex = [currentMatch.participants indexOfObject:currentMatch.currentParticipant];
        
        NSMutableArray *nextParticipants = [NSMutableArray array];
        for (int i = 0; i < [currentMatch.participants count]; i++) {
            int indx = (i + currentIndex + 1) % [currentMatch.participants count];
            GKTurnBasedParticipant *participant = (currentMatch.participants)[indx];
            //1
            if (participant.matchOutcome == GKTurnBasedMatchOutcomeNone) {
                [nextParticipants addObject:participant];
            }
            
        }
        
        if (player2Score+player1Score+player3Score+player4Score>=36){
            for (GKTurnBasedParticipant * particpent in currentMatch.participants) {
                particpent.matchOutcome = GKTurnBasedMatchStatusEnded;
            }
            if (currentMatch.status != GKTurnBasedMatchStatusEnded) {
                [currentMatch endMatchInTurnWithMatchData:[self convertArraysToData] completionHandler:^(NSError *error) {
                    [self dismissHUD];
                    if (error) {
                        MBAlertView * alert = [MBAlertView errorWithBody:[NSString stringWithFormat:@"%@\n\n %@\n\n Please try again later.",errorMessage,[error localizedDescription]] cancelTitle:@"Ok" cancelBlock:nil];
                        [alert addButtonWithText:@"Report Error" type:MBAlertViewItemTypeDestructive block:^{
                            [Flurry logError:@"GC" message:@"end" error:error];
                        }];
                        [alert addToDisplayQueue];
                    }
                }];
            }
            [self showEndAlert];
        }
        
        else if (!justTookSquare) {
            [self areYourSureDialog];
        }
        justTookSquare = NO;
    }
}
-(void)dismissHUD{
    [MBAlertView dismissCurrentHUD];
    [MBHUDView dismissCurrentHUD];
}




-(void)resetDataArrays{
    [linesToAddToGrid removeAllObjects];
    [squaresForPlayer1 removeAllObjects];
    [squaresForPlayer2 removeAllObjects];
    [squaresForPlayer3 removeAllObjects];
    [squaresForPlayer4 removeAllObjects];
}
-(void)convertMatchDataToArrays:(GKTurnBasedMatch *)match{
    if ([match.matchData bytes]) {
        [arrayWithData removeAllObjects];
        [self resetDataArrays];
        arrayWithData = [NSKeyedUnarchiver unarchiveObjectWithData:match.matchData];
        BOOL square1ArraySet = false;
        BOOL square2ArraySet = false;
        BOOL square3ArraySet = false;
        BOOL square4ArraySet = false;
        BOOL linesArraySet = false;
        int arraysInData = 0;
        for (NSMutableArray *matchDataArrays in arrayWithData) {
            arraysInData++;
            if (!linesArraySet) {
                linesToAddToGrid = [NSMutableArray arrayWithArray:matchDataArrays];
                linesArraySet = true;
            }
            else if (!square1ArraySet) {
                squaresForPlayer1 = [NSMutableArray arrayWithArray:matchDataArrays];
                square1ArraySet = true;
            }
            else if (!square2ArraySet) {
                squaresForPlayer2 = [NSMutableArray arrayWithArray:matchDataArrays];
                square2ArraySet = true;
            }
            else if (!square3ArraySet) {
                squaresForPlayer3 = [NSMutableArray arrayWithArray:matchDataArrays];
                square3ArraySet = true;
            }
            else if (!square4ArraySet) {
                squaresForPlayer4 = [NSMutableArray arrayWithArray:matchDataArrays];
                square4ArraySet = true;
            }
        }
        [self removeSpaceForLineisReciving:YES];
        [self setScoreFromMatch:YES];
    }
}

-(NSData *)convertArraysToData{
    
    [arrayWithData removeAllObjects];
    arrayWithData = [NSMutableArray arrayWithObjects:linesToAddToGrid,squaresForPlayer1,squaresForPlayer2,squaresForPlayer3,squaresForPlayer4, nil];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrayWithData];
    return data;
}


-(IBAction)tappedSquare:(id)sender{
    if ([[GCTurnBasedMatchHelper sharedInstance].currentMatch.currentParticipant.playerID isEqualToString:[GKLocalPlayer localPlayer].playerID] && !lastConfirm) {
        lastButtonTag = [sender tag];
        
        for (int i = 0; i < [linesToAddToGrid count]; i++) {
            if ([[NSString stringWithFormat:@"%d",lastButtonTag]isEqual:linesToAddToGrid[i]]) {
                playerLabel.text = @"Space Taken. Try another";
                return;
            }
        }
        playerLabel.text = [NSString stringWithFormat:@"Player %d's Turn (that's you)", playerNumber];
        [self buttonWithName:lastButtonTag];
        [linesToAddToGrid addObject:[NSString stringWithFormat:@"%d",lastButtonTag]];
        [self removeSpaceForLineisReciving:NO];
    }
    else if (lastConfirm){
        
    }
    else {
        [MBAlertView dismissCurrentHUD];
        [MBHUDView dismissCurrentHUD];
        MBAlertView * alert = [MBAlertView errorWithBody:@"It is not your turn to make a move in this match." cancelTitle:@"Ok" cancelBlock:nil];
        [alert addButtonWithText:@"New Match" type:MBAlertViewItemTypePositive block:^{
            [self showGCView];
        }];
        [alert addToDisplayQueue];
    }
}

-(void)cancel{
    [self configSquares];
    [self dismissConfirm];
    [self setMatchScoreForMatch:[GCTurnBasedMatchHelper sharedInstance].currentMatch andMessage:YES];
    for (UIButton * lineButton in self.view.subviews) {
        if (85 > lineButton.tag) {
            [lineButton setImage:[[UIColorForString sharedInstance] imageForColor:userBoardColor forType:nil] forState:UIControlStateNormal];
        }
    }
    for (UIImageView * blockView in self.view.subviews) {
        if (240 > blockView.tag && 200 < blockView.tag) {
            blockView.image = [[UIColorForString sharedInstance] imageForColor:userBoardColor forType:nil];
        }
    }
    
    playerLabel.text = [NSString stringWithFormat:@"Player %d's Turn (that's you)", playerNumber];
    [self convertMatchDataToArrays:[GCTurnBasedMatchHelper sharedInstance].currentMatch];
}

-(void)dismissConfirm{
    [UIView beginAnimations:@"animate" context:NULL];
    lastConfirm.frame = CGRectOffset(lastConfirm.frame,0, lastConfirm.bounds.size.height);
    [UIView commitAnimations];
    [NSTimer scheduledTimerWithTimeInterval:.3 target:self selector:@selector(removeConfirm) userInfo:nil repeats:NO];
}

-(void)removeConfirm{
    [lastConfirm removeFromSuperview];
    lastConfirm = nil;
}

-(void)areYourSureDialog{
    
    CATransition * transition = [CATransition animation];
    transition.duration = .2;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    
    lastConfirm = [[[NSBundle mainBundle] loadNibNamed:@"Confirm" owner:self options:nil] lastObject];
    lastConfirm.delegate = self;
    lastConfirm.tag = 1000;
    if ([[UIScreen mainScreen] bounds].size.height == 1024) {
        lastConfirm.center = CGPointMake([[UIScreen mainScreen] bounds].size.height/2, [[UIScreen mainScreen] bounds].size.width-lastConfirm.bounds.size.height);
    }
    else {
       lastConfirm.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height-lastConfirm.bounds.size.height); 
    }
    
    [lastConfirm.layer setMasksToBounds:YES];
    [lastConfirm.layer setBorderColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.8].CGColor];
    [lastConfirm.layer setBorderWidth:2];
    lastConfirm.layer.shadowPath = [UIBezierPath bezierPathWithRect:lastConfirm.bounds].CGPath;
    [lastConfirm.layer addAnimation:transition forKey:nil];
    
    [self.view addSubview:lastConfirm];
}

-(void)confirm{
    [lastTouchView removeFromSuperview];
    [Flurry logEvent:@"Send Turn"];
    [MBHUDView hudWithBody:@"Loading..." type:MBAlertViewHUDTypeActivityIndicator hidesAfter:3600 show:YES];
    GKTurnBasedMatch *currentMatch = [[GCTurnBasedMatchHelper sharedInstance] currentMatch];
    NSUInteger currentIndex = [currentMatch.participants indexOfObject:currentMatch.currentParticipant];
    
    NSMutableArray *nextParticipants = [NSMutableArray array];
    for (int i = 0; i < [currentMatch.participants count]; i++) {
        int indx = (i + currentIndex + 1) % [currentMatch.participants count];
        GKTurnBasedParticipant *participant = (currentMatch.participants)[indx];
        //1
        if (participant.matchOutcome == GKTurnBasedMatchOutcomeNone) {
            [nextParticipants addObject:participant];
        }
        
    }
    [currentMatch endTurnWithNextParticipants:nextParticipants turnTimeout:36000 matchData:[self convertArraysToData] completionHandler: ^(NSError *error) {
        [self dismissHUD];
        if (error) {
            MBAlertView * alert = [MBAlertView errorWithBody:[NSString stringWithFormat:@"%@\n\n %@\n\n Please try again later.",errorMessage,[error localizedDescription]] cancelTitle:@"Ok" cancelBlock:nil];
            [alert addButtonWithText:@"Report Error" type:MBAlertViewItemTypeDestructive block:^{
                [Flurry logError:@"GC" message:@"turn" error:error];
            }];
            [alert addToDisplayQueue];
        } else {
            [AudioPlayer playSound:@"SubmitMove" ofType:@"caf"];
            playerLabel.text = [NSString stringWithFormat:@"Player %d's Turn", [currentMatch.participants indexOfObject:currentMatch.currentParticipant] + 1];
        }
    }];
    [self dismissConfirm];
}







-(void)enterNewGame:(GKTurnBasedMatch *)match {
    [self resetDataArrays];
    [self removeConfirm];
    match.message = @"1 Player";
    [self configSquares];
    for (UIButton * lineButton in self.view.subviews) {
        if (85 > lineButton.tag) {
            [lineButton setImage:[[UIColorForString sharedInstance] imageForColor:userBoardColor forType:nil] forState:UIControlStateNormal];
        }
    }
    for (UIImageView * blockView in self.view.subviews) {
        if (240 > blockView.tag && 200 < blockView.tag) {
            blockView.image = [[UIColorForString sharedInstance] imageForColor:userBoardColor forType:nil];
        }
    }
    player1Score = 0;
    player2Score = 0;
    player3Score = 0;
    player4Score = 0;
    NSMutableArray *currentMatchParticipents = [NSMutableArray arrayWithArray:match.participants];
    if ([currentMatchParticipents count]>0) {
        for (int potPlay = 0; potPlay < [currentMatchParticipents count]; potPlay++) {
            GKPlayer * checkPlayer = currentMatchParticipents[potPlay];
            if ([checkPlayer.playerID isEqual:[GKLocalPlayer localPlayer].playerID]) {
                playerNumber = potPlay + 1;
            }
        }
    }
    playerLabel.text = [NSString stringWithFormat:@"Player %d's Turn (that's you)", [match.participants indexOfObject:match.currentParticipant] + 1];
}

-(void)turnAlert{
    [MBAlertView dismissCurrentHUD];
    [MBHUDView dismissCurrentHUD];
    
    if (canShowAlert) {
        MBHUDView * hud = [MBHUDView hudWithBody:@"It is your turn." type:MBAlertViewHUDTypeExclamationMark hidesAfter:.75 show:YES];
        [AudioPlayer playSound:@"TurnAlert" ofType:@"caf"];
        [hud addToDisplayQueue];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    canShowAlert = YES;
    if (![defaults boolForKey:@"hasPlayedMulti"]) {
        MultiplayerInfoViewController *vc = [[MultiplayerInfoViewController alloc] initWithNibName:@"MultiplayerInfoViewController" bundle:nil];
        [self presentViewController:vc animated:YES completion:nil];
        [defaults setBool:YES forKey:@"hasPlayedMulti"];
        [defaults synchronize];
    }
    else if (![GCTurnBasedMatchHelper sharedInstance].currentMatch){
        playerLabel.text = @"No Match Active";
    }
}
-(void)viewDidDisappear:(BOOL)animated{
    canShowAlert = NO;
    [GCTurnBasedMatchHelper sharedInstance].currentMatch = nil;
}
-(void)takeTurn:(GKTurnBasedMatch *)match {
    [lastTouchView removeFromSuperview];
    [self removeConfirm];
    [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(turnAlert) userInfo:nil repeats:NO];
    [self configSquares];
    [self setMatchScoreForMatch:match andMessage:YES];
    for (UIButton * lineButton in self.view.subviews) {
        if (85 > lineButton.tag) {
            [lineButton setImage:[[UIColorForString sharedInstance] imageForColor:userBoardColor forType:nil] forState:UIControlStateNormal];
        }
    }
    for (UIImageView * blockView in self.view.subviews) {
        if (240 > blockView.tag && 200 < blockView.tag) {
            blockView.image = [[UIColorForString sharedInstance] imageForColor:userBoardColor forType:nil];
        }
    }
    NSMutableArray *currentMatchParticipents = [NSMutableArray arrayWithArray:match.participants];
    if ([currentMatchParticipents count]>0) {
        for (int potPlay = 0; potPlay < [currentMatchParticipents count]; potPlay++) {
            GKPlayer * checkPlayer = currentMatchParticipents[potPlay];
            if ([checkPlayer.playerID isEqual:[GKLocalPlayer localPlayer].playerID]) {
                playerNumber = potPlay + 1;
            }
        }
    }

    playerLabel.text = [NSString stringWithFormat:@"Player %d's Turn (that's you)", playerNumber];
    [self convertMatchDataToArrays:match];
    
    
    for (UIButton * button in self.view.subviews) {
        if ([[NSString stringWithFormat:@"%d",button.tag] isEqual:[linesToAddToGrid lastObject]]) {
            [lastTouchView removeFromSuperview];
            UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"touch"]];
            imageView.tag = 1000;
            lastTouchView = imageView;
            imageView.center = button.center;
            [self.view addSubview:imageView];
        }
    }
    
    
    
    
}


-(void)layoutMatch:(GKTurnBasedMatch *)match {
    [lastTouchView removeFromSuperview];
    [self removeConfirm];
    [self configSquares];
    [self setMatchScoreForMatch:match andMessage:NO];
    for (UIButton * lineButton in self.view.subviews) {
        if (85 > lineButton.tag) {
            [lineButton setImage:[[UIColorForString sharedInstance] imageForColor:userBoardColor forType:nil] forState:UIControlStateNormal];
        }
    }
    for (UIImageView * blockView in self.view.subviews) {
        if (240 > blockView.tag && 200 < blockView.tag) {
            blockView.image = [[UIColorForString sharedInstance] imageForColor:userBoardColor forType:nil];
        }
    }
    NSMutableArray *currentMatchParticipents = [NSMutableArray arrayWithArray:match.participants];
    if ([currentMatchParticipents count]>0) {
        for (int potPlay = 0; potPlay < [currentMatchParticipents count]; potPlay++) {
            GKPlayer * checkPlayer = currentMatchParticipents[potPlay];
            if ([checkPlayer.playerID isEqual:[GKLocalPlayer localPlayer].playerID]) {
                playerNumber = potPlay + 1;
            }
        }
    }
    NSString *statusString;
    
    if (match.status == GKTurnBasedMatchStatusEnded) {
        statusString = @"Match Ended";
    } else {
        int playerNum = [match.participants indexOfObject:match.currentParticipant] + 1;
        statusString = [NSString stringWithFormat:@"Player %d's Turn", playerNum];
    }
    
    playerLabel.text = statusString;
    [self convertMatchDataToArrays:match];
    [self showEndAlert];
}

-(void)recieveEndGame:(GKTurnBasedMatch *)match {
    [self layoutMatch:match];
}

-(void)showEndAlert{
    if (player1Score+player2Score+player3Score+player4Score >= 36) {
        
        for (int playerAtIndex = 0; playerAtIndex < [[GCTurnBasedMatchHelper sharedInstance].currentMatch.participants count]; playerAtIndex++) {
            GKTurnBasedParticipant * part = [GCTurnBasedMatchHelper sharedInstance].currentMatch.participants[playerAtIndex];
            if ([part.playerID isEqualToString:[GKLocalPlayer localPlayer].playerID]) {
                playerNumber = playerAtIndex+1;
            }
        }
        
        NSMutableArray * scores = [[NSMutableArray alloc]init];
        switch (playerNumber) {
            case 2:
                [scores addObject:[NSNumber numberWithInt:player1Score]];
                [scores addObject:[NSNumber numberWithInt:player2Score]];
                break;
            case 3:
                [scores addObject:[NSNumber numberWithInt:player1Score]];
                [scores addObject:[NSNumber numberWithInt:player2Score]];
                [scores addObject:[NSNumber numberWithInt:player3Score]];
                break;
            case 4:
                [scores addObject:[NSNumber numberWithInt:player1Score]];
                [scores addObject:[NSNumber numberWithInt:player2Score]];
                [scores addObject:[NSNumber numberWithInt:player3Score]];
                [scores addObject:[NSNumber numberWithInt:player4Score]];
                break;
            default:
                break;
        }
        localScore = 0;
        
        switch (playerNumber) {
            case 1:
                localScore = player1Score;
                [scores removeObject:[NSNumber numberWithInt:player1Score]];
                break;
            case 2:
                localScore = player2Score;
                [scores removeObject:[NSNumber numberWithInt:player2Score]];
                break;
            case 3:
                localScore = player3Score;
                [scores removeObject:[NSNumber numberWithInt:player3Score]];
                break;
            case 4:
                localScore = player4Score;
                [scores removeObject:[NSNumber numberWithInt:player4Score]];
                break;
            default:
                break;
        }
        int place = [scores count] + 1;
        BOOL tied = NO;
        for (int scoreToBeat = 0; scoreToBeat < [scores count]; scoreToBeat++) {
            if (localScore > [scores[scoreToBeat] integerValue]) {
                place--;
            }
            else if (localScore == [scores[scoreToBeat] integerValue]){
                place--;
                tied = YES;
            }
        }
        NSString *outcomeText;
        
        if (tied) {
            switch (place) {
                case 1:
                    outcomeText = @"You tied for 1st.";
                    [self setMatchForFirst:YES];
                    break;
                case 2:
                    outcomeText = @"You tied for 2nd.";
                    [self setMatchForFirst:NO];
                    break;
                case 3:
                    outcomeText = @"You tied for 3rd.";
                    [self setMatchForFirst:NO];
                    break;
                case 4:
                    outcomeText = @"You tied for 4th.";
                    [self setMatchForFirst:NO];
                    break;
                default:
                    break;
            }
        }
        else {
            switch (place) {
                case 1:
                    outcomeText = @"You came in 1st.";
                    [self setMatchForFirst:YES];
                    break;
                case 2:
                    outcomeText = @"You came in 2nd.";
                    [self setMatchForFirst:NO];
                    break;
                case 3:
                    outcomeText = @"You came in 3rd.";
                    [self setMatchForFirst:NO];
                    break;
                case 4:
                    outcomeText = @"You came in 4th.";
                    [self setMatchForFirst:NO];
                    break;
                default:
                    break;
            }
        }
        playerLabel.text = outcomeText;
    }
}

-(void)setMatchForFirst:(BOOL)first{
    BOOL hasGotMatch = NO;
    NSMutableArray * previousMatches = [NSMutableArray arrayWithArray:[defaults valueForKey:@"matchesWon"]];
    for (NSString * matchID in previousMatches) {
        if ([matchID isEqual:[GCTurnBasedMatchHelper sharedInstance].currentMatch.matchID]) {
            hasGotMatch = YES;
        }
    }
    if (!hasGotMatch) {
        if (first) {
            [AudioPlayer playSound:@"Win" ofType:@"caf"];
            [Flurry logEvent:@"Game Over"];
            int won = [defaults integerForKey:@"won"];
            won ++;
            [[GCTurnBasedMatchHelper sharedInstance] submitScore:won];
            [HelperMethods reportAchievementsForWins:won];
            if (localScore > 25) {
                [HelperMethods report20Square];
            }
            [defaults setInteger:won forKey:@"won"];
        }
        [HelperMethods reportParticipation];
        [previousMatches addObject:[GCTurnBasedMatchHelper sharedInstance].currentMatch.matchID];
        [defaults setObject:previousMatches forKey:@"matchesWon"];
        [defaults synchronize];
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
    for (NSString * squaresInPlayer3 in squaresForPlayer3) {
        if ([squaresInPlayer3 intValue] == square) {
            return NO;
        }
    }
    for (NSString * squaresInPlayer4 in squaresForPlayer4) {
        if ([squaresInPlayer4 intValue] == square) {
            return NO;
        }
    }
    return YES;
}

-(void)removeSpaceForLineisReciving:(BOOL)reciving{
    BOOL shouldUpdateSquares = NO;
    NSMutableArray *allSquares = [NSMutableArray arrayWithObjects:square01,square02,square03,square04,square05,square06,square07,square08,square09,square10,square11,square12,square13,square14,square15,square16,square17,square18,square19,square20,square21,square22,square23,square24,square25,square26,square27,square28,square29,square30,square31,square32,square33,square34,square35,square36, nil];
    
    for (int i = 0; i < [linesToAddToGrid count]; i++) {
        int squareNumber = 0;
        for (NSMutableArray * squareArray in allSquares) {
            squareNumber++;
            [squareArray removeObject:[NSString  stringWithFormat:@"%@",linesToAddToGrid[i]]];
            if ([squareArray count] == 0) {
                if ([self isSquareAlreadyTaken:squareNumber]&&!reciving) {
                    shouldUpdateSquares = YES;
                    if (playerNumber == 1) {
                        [squaresForPlayer1 addObject:[NSString stringWithFormat:@"%d",squareNumber]];
                    }
                    else if (playerNumber == 2) {
                        [squaresForPlayer2 addObject:[NSString stringWithFormat:@"%d",squareNumber]];
                    }
                    else if (playerNumber == 3) {
                        [squaresForPlayer3 addObject:[NSString stringWithFormat:@"%d",squareNumber]];
                    }
                    else if (playerNumber == 4) {
                        [squaresForPlayer4 addObject:[NSString stringWithFormat:@"%d",squareNumber]];
                    }
                }
            }
        }
        [self buttonWithName:[[NSString stringWithFormat:@"%@",linesToAddToGrid[i]]intValue]];
    }
    if (shouldUpdateSquares) {
        justTookSquare = YES;
        [self setScoreFromMatch:reciving];
    }
    else {
        justTookSquare = NO;
        if (!reciving){
            if (!justTookSquare) {
                playerLabel.text = @"Sending Turn..."; 
                [self areYourSureDialog];
            }
            else {
                GKTurnBasedMatch *currentMatch = [[GCTurnBasedMatchHelper sharedInstance] currentMatch];
                NSUInteger currentIndex = [currentMatch.participants indexOfObject:currentMatch.currentParticipant];
                
                NSMutableArray *nextParticipants = [NSMutableArray array];
                for (int i = 0; i < [currentMatch.participants count]; i++) {
                    int indx = (i + currentIndex + 1) % [currentMatch.participants count];
                    GKTurnBasedParticipant *participant = (currentMatch.participants)[indx];
                    //1
                    if (participant.matchOutcome == GKTurnBasedMatchOutcomeNone) {
                        [nextParticipants addObject:participant];
                    }
                    
                }
                playerLabel.text = [NSString stringWithFormat:@"Player %d's Turn (that's you)", [currentMatch.participants indexOfObject:currentMatch.currentParticipant] + 1 ];
            }
            justTookSquare = NO;
        }
    }
}


-(void)buttonWithName:(int)buttonName{
    NSMutableArray * horizontalLines = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"14",@"15",@"16",@"17",@"18",@"19",@"27",@"28",@"29",@"30",@"31",@"32",@"40",@"41",@"42",@"43",@"44",@"45",@"53",@"54",@"55",@"56",@"57",@"58",@"66",@"67",@"68",@"69",@"70",@"71",@"79",@"80",@"81",@"82",@"83",@"84", nil];
    NSMutableArray * verticalLines = [NSMutableArray arrayWithObjects:@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"59",@"60",@"61",@"62",@"63",@"64",@"65",@"72",@"73",@"74",@"75",@"76",@"77",@"78", nil];
    for (UIButton * button in self.view.subviews) {
        if (100 > button.tag > 0) {
                for (NSString * line in horizontalLines) {
                if (button.tag == [line intValue] && buttonName == button.tag) {
                    [button setImage:[[UIColorForString sharedInstance] imageForColor:userLineColor forType:@"horizontial"] forState:UIControlStateNormal];
                    return;
                }
            }
            for (NSString * line in verticalLines) {
                if (button.tag == [line intValue] && buttonName == button.tag) {
                    [button setImage:[[UIColorForString sharedInstance] imageForColor:userLineColor     forType:@"vertical"] forState:UIControlStateNormal];
                    return;
                }
            }
        }
    }
}

-(void)setMatchScoreForMatch:(GKTurnBasedMatch *)match andMessage:(BOOL)message{
    if (message) {
        if ([match.participants count] == 2) {
            match.message = @"2 Player Match";
        }
        else if ([match.participants count] == 3) {
            match.message = @"3 Player Match";
        }
        else if ([match.participants count] == 4) {
            match.message = @"4 Player Match";
        }
    }
    if ([match.message isEqualToString:@"2 Player Match"]) {
        playersScoreLabel.text = [NSString stringWithFormat:@"P1: %lld      P2: %lld",player1Score,player2Score];
    }
    else if ([match.message isEqualToString:@"3 Player Match"]) {
        playersScoreLabel.text = [NSString stringWithFormat:@"P1: %lld      P2: %lld      P3: %lld",player1Score,player2Score,player3Score];
    }
    else if ([match.message isEqualToString:@"4 Player Match"]) {
        playersScoreLabel.text = [NSString stringWithFormat:@"P1: %lld      P2: %lld      P3: %lld      P4: %lld",player1Score,player2Score,player3Score,player4Score];
    }
    else {
        playersScoreLabel.text = @"";
    }
}

-(void)makeThingsLookPretty{
    float radius = 12.0;
    
    [self.backgroundImageView.layer setMasksToBounds:YES];
    [self.backgroundImageView.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.backgroundImageView.layer setBorderWidth:5.0];
    [self.backgroundImageView.layer setCornerRadius:radius];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:@"background.JPEG"];
    
    
    if ([UIImage imageWithContentsOfFile:getImagePath]) {
        self.backgroundImageView.image = [UIImage imageWithContentsOfFile:getImagePath];
        userBoardColor = [UIColor clearColor];
    }
    else if (![UIImage imageWithContentsOfFile:getImagePath]) {
        self.backgroundImageView.image = [[UIColorForString sharedInstance]imageForColor:userBoardColor forType:nil];
    }
    
    self.view.backgroundColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userViewColor"]];
    
    
    for (UIButton * lineButton in self.view.subviews) {
        if (85 > lineButton.tag) {
            [lineButton setImage:[[UIColorForString sharedInstance] imageForColor:userBoardColor forType:nil] forState:UIControlStateNormal];
        }
    }
    for (UIImageView * blockView in self.view.subviews) {
        if (240 > blockView.tag && 200 < blockView.tag) {
            blockView.image = [[UIColorForString sharedInstance] imageForColor:userBoardColor forType:nil];
        }
    }
}


-(void)sendNotice:(NSString *)notice forMatch:(GKTurnBasedMatch *)match{
    [MBAlertView dismissCurrentHUD];
    [MBHUDView dismissCurrentHUD];
    MBAlertView *alert = [MBAlertView alertWithBody:notice cancelTitle:@"OK" cancelBlock:nil];
    [alert addToDisplayQueue];
}

@end
