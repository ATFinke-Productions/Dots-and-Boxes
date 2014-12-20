//
//  NewLocalViewController.m
//  Boxes
//
//  Created by Andrew on 4/19/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "LocalViewController.h"
#import "LocalMatch.h"
#import "LineAI-V2.h"

#define notificationTime .5

@interface LocalViewController ()

@end

@implementation LocalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self navigationSetUp];
    [Flurry logEvent:@"Enter Local View"];
    defaults = [NSUserDefaults standardUserDefaults];
    userBoardColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userBoardColor"]];
    userLineColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userLineColor"]];
    self.navigationController.navigationBar.tintColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userViewColor"]];
    [self makeThingsLookPretty];
    [self configSquares];

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
    matchPresent = [[UIBarButtonItem alloc]initWithTitle:@"Matches" style:UIBarButtonItemStylePlain target:self action:@selector(loadMatch)];
    if ([[UIScreen mainScreen] bounds].size.height != 1024) {
        self.navigationItem.rightBarButtonItems = @[matchPresent,shareButton];
    }
    else {
        self.navigationItem.rightBarButtonItems = @[matchPresent];
    }
}

-(void) loadMatch{
    [self performSegueWithIdentifier:@"showMatch" sender:self];
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
    NSMutableArray * squaresTakenArray = [NSMutableArray arrayWithObjects:[LocalMatch sharedInstance].squaresForPlayer1,[LocalMatch sharedInstance].squaresForPlayer2,[LocalMatch sharedInstance].squaresForPlayer3,[LocalMatch sharedInstance].squaresForPlayer4, nil];
    
    player1Score = [[LocalMatch sharedInstance].squaresForPlayer1 count];
    player2Score = [[LocalMatch sharedInstance].squaresForPlayer2 count];
    player3Score = [[LocalMatch sharedInstance].squaresForPlayer3 count];
    player4Score = [[LocalMatch sharedInstance].squaresForPlayer4 count];

    for (int player = 1; player <= [[LocalMatch sharedInstance].participants count]; player++) {
        for (NSString *squareNumbers in squaresTakenArray[player-1]) {
            for (UIImageView * imageView in self.view.subviews) {
                if (240 > imageView.tag && 200 < imageView.tag) {
                    if (imageView.tag - 200 == [squareNumbers intValue]) {
                        imageView.image = [[UIColorForString sharedInstance] imageForColorWithString:[defaults valueForKey:[NSString stringWithFormat:@"userP%dColor",player]] forType:nil];
                    }
                }
            }
        }
    }
    
    [self setMatchScoreLabel];
    
    if (!reciving){
        
       if (justTookSquare && isPlayerAI) {
           [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(computerMove) userInfo:nil repeats:NO];
       }
        
        if (!justTookSquare) {
            [MBAlertView dismissCurrentHUD];
            [MBHUDView dismissCurrentHUD];
        }

        
        if (player2Score+player1Score+player3Score+player4Score>=36){
            [[LocalMatch sharedInstance]advanceTurnForGameOver:YES];
            [AudioPlayer playSound:@"Win" ofType:@"caf"];
            [self showEndAlert];
        }
        
        if (!justTookSquare) {
            if (!isPlayerAI) {
                [self areYourSureDialog];
            }
            else {
                [self confirm];
            }
        }
        justTookSquare = NO;
    }
}

-(void)convertMatchDataToArrays{

    [self removeSpaceForLineisReciving:YES];
    [self setScoreFromMatch:YES];
}


-(IBAction)tappedSquare:(id)sender{
    if (player1Score+player2Score+player3Score+player4Score < 36 && !isPlayerAI && [LocalMatch sharedInstance].currentMatchID &&!lastConfirm) {
    lastButtonTag = [sender tag];
    
    for (int i = 0; i < [[LocalMatch sharedInstance].linesToAddToGrid count]; i++) {
        if ([[NSString stringWithFormat:@"%d",lastButtonTag]isEqual:[LocalMatch sharedInstance].linesToAddToGrid[i]]) {
            playerLabel.text = @"Space Taken. Try another";
            return;
        }
    }
    playerLabel.text = [NSString stringWithFormat:@"%@'s Turn", currentPlayerString];
    [self buttonWithName:lastButtonTag];
    [[LocalMatch sharedInstance].linesToAddToGrid addObject:[NSString stringWithFormat:@"%d",lastButtonTag]];
    [self removeSpaceForLineisReciving:NO];
    }
}

-(void)cancel{
    [[LocalMatch sharedInstance]setArraysToPreviousTurn];
    [self configSquares];
    [self dismissConfirm];
    [self setMatchScoreLabel];
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
    
    playerLabel.text = [NSString stringWithFormat:@"%@'s Turn", currentPlayerString];
    [self convertMatchDataToArrays];
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
    for (UIButton * button in lastConfirm.subviews) {
        if ([button.titleLabel.text isEqual:@"Send Move"]) {
            [button setTitle:@"Save Move" forState:UIControlStateNormal];
        }
    }
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
    [Flurry logEvent:@"Send Turn"];
    if (!isPlayerAI) {
        [AudioPlayer playSound:@"SubmitMove" ofType:@"caf"];
    }
    [[LocalMatch sharedInstance]advanceTurnForGameOver:NO];
    [self reloadBoardInfo];
    [self dismissConfirm];
}


-(void)viewWillDisappear:(BOOL)animated {
    isViewVisible = NO;
    isViewVisibleForAlert = NO;
}
-(void)setAlert{
    isViewVisibleForAlert = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    isViewVisible = YES;
    [self removeConfirm];
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
    [self reloadBoardInfo];
    
}

-(void)reloadBoardInfo{
    int currentPlayerIndex = [LocalMatch sharedInstance].currentParticipantIndex;
    NSString * noCap = [LocalMatch sharedInstance].participants[currentPlayerIndex];
    currentPlayerString = [noCap capitalizedString];
    
    playerNumber = currentPlayerIndex++;
    [self setMatchScoreLabel];
    [self convertMatchDataToArrays];
    isPlayerAI = NO;
    for (NSString *aiIndex in [LocalMatch sharedInstance].indexOfAIParticepents) {
        if ([aiIndex intValue] == currentPlayerIndex -1 && isViewVisible) {
            isPlayerAI = YES;
            currentPlayerString = [NSString stringWithFormat:@"%@ (AI)",currentPlayerString];
            if (!isHudOn && [LocalMatch sharedInstance].indexOfAIParticepents.count != [LocalMatch sharedInstance].participants.count) {
                isHudOn = YES;
                [MBHUDView hudWithBody:@"AI Thinking..." type:MBAlertViewHUDTypeActivityIndicator hidesAfter:1000 show:YES];
            }
            [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(computerMove) userInfo:nil repeats:NO];
        }
    }
    if (!isPlayerAI) {
        [MBHUDView dismissCurrentHUD];
        isHudOn = NO;
    }
    playerLabel.text = [NSString stringWithFormat:@"%@'s Turn", currentPlayerString];
    
    if (!isPlayerAI && [LocalMatch sharedInstance].currentMatchID && isViewVisibleForAlert) {
        MBAlertView * alert = [MBAlertView alertWithBody:playerLabel.text cancelTitle:@"OK" cancelBlock:nil];
        [alert addToDisplayQueue];
    }
    [self showEndAlert];
}

-(void)computerMove{
    if (isViewVisible) {
    NSString * potienalLine = [[LineAI_V2 sharedInstance] lineForSquares:[self allSquaresArray]];
    if (![potienalLine isEqual:@"GAME"]) {
        [[LocalMatch sharedInstance].linesToAddToGrid addObject:potienalLine];
        [self removeSpaceForLineisReciving:NO];
    }
    }
}
-(NSMutableArray *)allSquaresArray{
    NSMutableArray * allSquares = [[NSMutableArray alloc]init];
    [allSquares removeAllObjects];
    allSquares = [NSMutableArray arrayWithObjects:square01,square02,square03,square04,square05,square06,square07,square08,square09,square10,square11,square12,square13,square14,square15,square16,square17,square18,square19,square20,square21,square22,square23,square24,square25,square26,square27,square28,square29,square30,square31,square32,square33,square34,square35,square36, nil];
    return allSquares;
}
-(void)viewDidAppear:(BOOL)animated{
    canShowAlert = YES;
    if (![defaults boolForKey:@"practiceNotice"]) {
        [[LocalMatch sharedInstance]setInitalMatch];
        PracticeInfoViewController *vc = [[PracticeInfoViewController alloc] initWithNibName:@"PracticeInfoViewController" bundle:nil];
        [self presentViewController:vc animated:YES completion:nil];
        [defaults setBool:YES forKey:@"practiceNotice"];
        [defaults synchronize];
    }
    else if (![LocalMatch sharedInstance].currentMatchID) {
        playerLabel.text = @"No Match Active";
    }
    else {
        [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(setAlert) userInfo:nil repeats:YES];
    }
}



-(NSString *)partAtIndex:(int)index{
    return [[LocalMatch sharedInstance]participantsForMatchWithID:[NSString stringWithFormat:@"%d",[LocalMatch sharedInstance].currentMatchID] atIndex:index];
}
-(void)showEndAlert{
    if (player1Score+player2Score+player3Score+player4Score >= 36) {

        NSMutableArray * scores = [[NSMutableArray alloc]init];
        switch ([[LocalMatch sharedInstance] playerCountForMatchWithID:[NSString stringWithFormat:@"%d",[LocalMatch sharedInstance].currentMatchID]]) {
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
        NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
        [scores sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
        NSString * outcomeText;
        
        if ([[NSNumber numberWithInt:player1Score] isEqualToNumber:scores[0]]) {
            if (player1Score == player2Score) {
                outcomeText = [NSString stringWithFormat:@"%@ and %@ Tied",[self partAtIndex:0],[self partAtIndex:1]];
            }
            else if (player1Score == player3Score) {
                outcomeText = [NSString stringWithFormat:@"%@ and %@ Tied",[self partAtIndex:0],[self partAtIndex:2]];
            }
            else if (player1Score == player4Score) {
                outcomeText = [NSString stringWithFormat:@"%@ and %@ Tied",[self partAtIndex:0],[self partAtIndex:3]];
            }
            else {
                outcomeText = [NSString stringWithFormat:@"%@ Won",[self partAtIndex:0]];
            }
        }
        else if ([[NSNumber numberWithInt:player2Score] isEqualToNumber:scores[0]]) {
            if (player2Score == player3Score) {
                outcomeText = [NSString stringWithFormat:@"%@ and %@ Tied",[self partAtIndex:1],[self partAtIndex:2]];
            }
            else if (player2Score == player4Score) {
                outcomeText = [NSString stringWithFormat:@"%@ and %@ Tied",[self partAtIndex:1],[self partAtIndex:3]];
            }
            else {
                outcomeText = [NSString stringWithFormat:@"%@ Won",[self partAtIndex:1]];
            }
        }
        else if ([[NSNumber numberWithInt:player3Score] isEqualToNumber:scores[0]]) {
            if (player3Score == player4Score) {
                outcomeText = [NSString stringWithFormat:@"%@ and %@ Tied",[self partAtIndex:2],[self partAtIndex:3]];
            }
            else {
                outcomeText = [NSString stringWithFormat:@"%@ Won",[self partAtIndex:2]];
            }
        }
        else if ([[NSNumber numberWithInt:player4Score] isEqualToNumber:scores[0]]) {
            outcomeText = [NSString stringWithFormat:@"%@ Won",[self partAtIndex:3]];
        }
        playerLabel.text = outcomeText;
        [MBHUDView dismissCurrentHUD];
    }
    else {
        [lastTouchView removeFromSuperview];
        for (UIButton * button in self.view.subviews) {
            if ([[NSString stringWithFormat:@"%d",button.tag] isEqual:[[LocalMatch sharedInstance].linesToAddToGrid lastObject]]) {
                [lastTouchView removeFromSuperview];
                UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"touch"]];
                imageView.tag = 1000;
                lastTouchView = imageView;
                imageView.center = button.center;
                [self.view addSubview:imageView];
            }
        }
    }
}

-(BOOL)isSquareAlreadyTaken:(int)square{
    for (NSString * squaresInPlayer1 in [LocalMatch sharedInstance].squaresForPlayer1) {
        if ([squaresInPlayer1 intValue] == square) {
            return NO;
        }
    }
    for (NSString * squaresInPlayer2 in [LocalMatch sharedInstance].squaresForPlayer2) {
        if ([squaresInPlayer2 intValue] == square) {
            return NO;
        }
    }
    for (NSString * squaresInPlayer3 in [LocalMatch sharedInstance].squaresForPlayer3) {
        if ([squaresInPlayer3 intValue] == square) {
            return NO;
        }
    }
    for (NSString * squaresInPlayer4 in [LocalMatch sharedInstance].squaresForPlayer4) {
        if ([squaresInPlayer4 intValue] == square) {
            return NO;
        }
    }
    return YES;
}

-(void)removeSpaceForLineisReciving:(BOOL)reciving{
    playerNumber = [LocalMatch sharedInstance].currentParticipantIndex+1;
    BOOL shouldUpdateSquares = NO;
    NSMutableArray *allSquares = [NSMutableArray arrayWithObjects:square01,square02,square03,square04,square05,square06,square07,square08,square09,square10,square11,square12,square13,square14,square15,square16,square17,square18,square19,square20,square21,square22,square23,square24,square25,square26,square27,square28,square29,square30,square31,square32,square33,square34,square35,square36, nil];
    
    for (int i = 0; i < [[LocalMatch sharedInstance].linesToAddToGrid count]; i++) {
        int squareNumber = 0;
        for (NSMutableArray * squareArray in allSquares) {
            squareNumber++;
            [squareArray removeObject:[NSString  stringWithFormat:@"%@",[LocalMatch sharedInstance].linesToAddToGrid[i]]];
            if ([squareArray count] == 0) {
                if ([self isSquareAlreadyTaken:squareNumber]&&!reciving) {
                    shouldUpdateSquares = YES;
                    if (playerNumber == 1) {
                        [[LocalMatch sharedInstance].squaresForPlayer1 addObject:[NSString stringWithFormat:@"%d",squareNumber]];
                    }
                    else if (playerNumber == 2) {
                        [[LocalMatch sharedInstance].squaresForPlayer2 addObject:[NSString stringWithFormat:@"%d",squareNumber]];
                    }
                    else if (playerNumber == 3) {
                        [[LocalMatch sharedInstance].squaresForPlayer3 addObject:[NSString stringWithFormat:@"%d",squareNumber]];
                    }
                    else if (playerNumber == 4) {
                        [[LocalMatch sharedInstance].squaresForPlayer4 addObject:[NSString stringWithFormat:@"%d",squareNumber]];
                    }
                }
            }
        }
        [self buttonWithName:[[NSString stringWithFormat:@"%@",[LocalMatch sharedInstance].linesToAddToGrid[i]]intValue]];
    }
    if (shouldUpdateSquares) {
        justTookSquare = YES;
        [self setScoreFromMatch:reciving];
    }
    else {
        justTookSquare = NO;
        if (!reciving){
            if (!justTookSquare) {
                if (!isPlayerAI) {
                    [self areYourSureDialog];
                }
                else {
                    [self confirm];
                }
            }
            else {
                playerLabel.text = [NSString stringWithFormat:@"%@'s Turn", currentPlayerString];
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

-(void)setMatchScoreLabel{
    switch ([[LocalMatch sharedInstance]playerCountForMatchWithID:[NSString stringWithFormat:@"%d",[LocalMatch sharedInstance].currentMatchID]]) {
        case 2:
            playersScoreLabel.text = [NSString stringWithFormat:@"P1: %lld      P2: %lld",player1Score,player2Score];
            break;
        case 3:
            playersScoreLabel.text = [NSString stringWithFormat:@"P1: %lld      P2: %lld      P3: %lld",player1Score,player2Score,player3Score];
            break;
        case 4:
            playersScoreLabel.text = [NSString stringWithFormat:@"P1: %lld      P2: %lld      P3: %lld      P4: %lld",player1Score,player2Score,player3Score,player4Score];
            break;
            
        default:
            break;
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



@end
