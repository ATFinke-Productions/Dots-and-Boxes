//
//  LocalViewController.m
//  dot
//
//  Created by Andrew on 4/6/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//


#import "oldlocal.h"
#import "PracticeInfoViewController.h"
#import "ComputerViewController.h"
#import "MBHUDView.h"
#import "LocalMatch.h"
#define notificationTime .5
#define computerDelay 1.5

@interface oldlocal ()

@end

@implementation oldlocal

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self navigationSetUp];
    [Flurry logEvent:@"Enter Practice View"];
    playerLabel.text = @"Tap Space To Begin Match";
    defaults = [NSUserDefaults standardUserDefaults];
    isPlayer1Turn = YES;
    gameOver = NO;
    player1Score = 0;
    player2Score = 0;
    userBoardColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userBoardColor"]];
    userLineColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userLineColor"]];
    self.navigationController.navigationBar.tintColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userViewColor"]];
    
    [self.backgroundImageView.layer setMasksToBounds:YES];
    [self.backgroundImageView.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.backgroundImageView.layer setBorderWidth:5.0];
    [self.backgroundImageView.layer setCornerRadius:12];
    
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
    
    [self configSquares];
     
    linesToAddToGrid = [NSMutableArray array];
    playersWithAlias = [NSMutableArray array];
    squaresForPlayer1 = [NSMutableArray array];
    squaresForPlayer2 = [NSMutableArray array];

    if ([[UIScreen mainScreen] bounds].size.height == 1024) {
        for (UIImageView *item in self.view.subviews) {
            if (10000 != item.tag) {
                item.frame = CGRectOffset(item.frame, [[UIScreen mainScreen] bounds].size.width/3.5, [[UIScreen mainScreen] bounds].size.height/4);
            }
        }
    }
    
    
    textChange = [CATransition animation];
    textChange.duration = 1.0;
    textChange.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    textChange.type = kCATransitionFade;
    textChange.subtype = kCATransitionFromBottom;
}

-(void)navigationSetUp{
    UIBarButtonItem * shareButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
    UIBarButtonItem * modePresent = [[UIBarButtonItem alloc]initWithTitle:@"Mode" style:UIBarButtonItemStylePlain target:self action:@selector(mode)];
    if ([[UIScreen mainScreen] bounds].size.height != 1024) {
        self.navigationItem.rightBarButtonItems = @[modePresent,shareButton];
    }
    else {
        self.navigationItem.rightBarButtonItems = @[modePresent];
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
    [self presentViewController:vc animated:YES completion:nil];
}



-(void)viewDidAppear:(BOOL)animated{
    if (![defaults boolForKey:@"practiceNotice"]) {
        PracticeInfoViewController *vc = [[PracticeInfoViewController alloc] initWithNibName:@"PracticeInfoViewController" bundle:nil];
        [self presentViewController:vc animated:YES completion:nil];
        [defaults setBool:YES forKey:@"practiceNotice"];
        [defaults synchronize];
    }
    else if (!hasShowAlert){
        MBAlertView * alert = [MBAlertView alertWithBody:@"Would you like to watch the computer play itself to learn strategy or play against the computer?" cancelTitle:@"Watch" cancelBlock:^{
        ComputerViewController *vc = [[ComputerViewController alloc] initWithNibName:@"ComputerViewController" bundle:nil];
        [self presentViewController:vc animated:YES completion:nil];
        }];
        [alert addButtonWithText:@"Play" type:MBAlertViewItemTypePositive block:nil];
        [alert addToDisplayQueue];
        hasShowAlert = YES;
    }

}

-(void)mode{
    [self performSegueWithIdentifier:@"showMatch" sender:nil];
    /*
    MBAlertView * alert = [MBAlertView alertWithBody:@"Would you like to watch the computer play itself to learn strategy or play against the computer?" cancelTitle:@"Watch" cancelBlock:^{
        ComputerViewController *vc = [[ComputerViewController alloc] initWithNibName:@"ComputerViewController" bundle:nil];
        [self presentViewController:vc animated:YES completion:nil];
    }];
    [alert addButtonWithText:@"Play" type:MBAlertViewItemTypePositive block:nil];
    [alert addToDisplayQueue];*/
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

-(void)setScoreForPlayer:(BOOL)isPlayer{
    [self reloadSquareArray];
    player1Score = [squaresForPlayer1 count];
    player2Score = [squaresForPlayer2 count];
    
    playersScoreLabel.text = [NSString stringWithFormat:@"You: %lld      AI: %lld",player1Score,player2Score];
    [self showEndAlert];
    for (NSString *squareNumbers in squaresForPlayer1) {
        for (UIImageView * imageView in self.view.subviews) {
            if (240 > imageView.tag && 200 < imageView.tag) {
                if (imageView.tag - 200 == [squareNumbers intValue]) {
                    imageView.image = [[UIColorForString sharedInstance]imageForColorWithString:[defaults valueForKey:@"userP1Color"] forType:nil];
                }
            }
        }
    }
    for (NSString *squareNumbers in squaresForPlayer2) {
        for (UIImageView * imageView in self.view.subviews) {
            if (240 > imageView.tag && 200 < imageView.tag) {
                if (imageView.tag - 200 == [squareNumbers intValue]) {
                    CATransition *transition = [CATransition animation];
                    transition.delegate = self;
                    transition.duration = 1;
                    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                    transition.type = kCATransitionFade;
                    transition.subtype = kCATransitionFromBottom;
                    
                    [imageView.layer addAnimation:transition forKey:kCATransition];
                    imageView.image = [[UIColorForString sharedInstance]imageForColorWithString:[defaults valueForKey:@"userP2Color"] forType:nil];
                }
            }
        }
    }
    
    if (justTookSquare && !isPlayer) {
        if (player1Score+player1Score<36) {
            playerLabel.text = @"AI's Turn";
            [NSTimer scheduledTimerWithTimeInterval:computerDelay target:self selector:@selector(computerMove) userInfo:nil repeats:NO];
        }
    }
    
    if (isPlayer && !justTookSquare) {
        isPlayer1Turn = NO;
        playerLabel.text = @"AI's Turn";
        [NSTimer scheduledTimerWithTimeInterval:computerDelay target:self selector:@selector(computerMove) userInfo:nil repeats:NO];
    }
    else if (!isPlayer && !justTookSquare){
        isPlayer1Turn = YES;
        playerLabel.text = @"Your Turn";
        [[playerLabel layer] addAnimation:textChange forKey:kCATransition];
    }
    justTookSquare = NO;
}

-(void)computerMove{
    NSString * potienalLine = [[lineAI sharedInstance] moveForSpaceWithSquares:allSquares];
    if (![potienalLine isEqual:@"GAME"]) {
        [linesToAddToGrid addObject:potienalLine];
        [self removeSpaceForLine];
    }
}



-(IBAction)tappedSquare:(id)sender{
    if (isPlayer1Turn && !gameOver&& !lastConfirm) {
        
        lastButtonTag = [sender tag];
        for (int i = 0; i < [linesToAddToGrid count]; i++) {
            if ([[NSString stringWithFormat:@"%d",lastButtonTag]isEqual:linesToAddToGrid[i]]) {
                playerLabel.text = @"Space Taken. Try another";
                return;
            }
        }
        [self areYourSureDialog];
    }
    else if (lastConfirm){
        
    }
    else if (!gameOver){
        MBHUDView * hud = [MBHUDView hudWithBody:@"It is not your turn" type:MBAlertViewHUDTypeExclamationMark hidesAfter:2 show:YES];
        [hud addToDisplayQueue];
    }
}


-(void)confirm{
    [Flurry logEvent:@"Took Line"];
    [linesToAddToGrid addObject:[NSString stringWithFormat:@"%d",lastButtonTag]];
    [self removeSpaceForLine];
    [self dismissConfirm];
}
-(void)cancel{
    [self buttonWithName:lastButtonTag andIsRemoving:YES];
    [self dismissConfirm];
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
    
    [self buttonWithName:lastButtonTag andIsRemoving:NO];
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
    lastConfirm.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height-lastConfirm.bounds.size.height);
    [lastConfirm.layer setMasksToBounds:YES];
    [lastConfirm.layer setBorderColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.8].CGColor];
    [lastConfirm.layer setBorderWidth:2];
    lastConfirm.layer.shadowPath = [UIBezierPath bezierPathWithRect:lastConfirm.bounds].CGPath;
    [lastConfirm.layer addAnimation:transition forKey:nil];
    
    [self.view addSubview:lastConfirm];
}



-(void)showEndAlert{
    if (player1Score+player2Score>= 36) {
        playerLabel.text = @"Match Ended";
        NSString * outcome;
        gameOver = YES;
        if (player1Score>player2Score) {
            outcome = @"You Won!";
        }
        else if (player1Score<player2Score) {
            outcome = @"You Lost.";
        }
        else {
            outcome = @"You Tied.";
        }
        
        MBAlertView *alert = [MBAlertView alertWithBody:outcome cancelTitle:@"Ok" cancelBlock:nil];
        [alert addToDisplayQueue];
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

-(void)reloadSquareArray{
    [allSquares removeAllObjects];
    allSquares = [NSMutableArray arrayWithObjects:square01,square02,square03,square04,square05,square06,square07,square08,square09,square10,square11,square12,square13,square14,square15,square16,square17,square18,square19,square20,square21,square22,square23,square24,square25,square26,square27,square28,square29,square30,square31,square32,square33,square34,square35,square36, nil];
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
                    if (isPlayer1Turn == YES) {
                        [squaresForPlayer1 addObject:[NSString stringWithFormat:@"%d",squareNumber]];
                    }
                    else if (isPlayer1Turn == NO) {
                        [squaresForPlayer2 addObject:[NSString stringWithFormat:@"%d",squareNumber]];
                    }
                }
            }
        }
    [self buttonWithName:[[NSString stringWithFormat:@"%@",linesToAddToGrid[i]]intValue]andIsRemoving:NO];
    }
    if (shouldUpdateSquares) {
        justTookSquare = YES;
        [self setScoreForPlayer:isPlayer1Turn];
    }
    else {
        justTookSquare = NO;
        if (isPlayer1Turn) {
            isPlayer1Turn = NO;
            playerLabel.text = @"AI's Turn";
            [NSTimer scheduledTimerWithTimeInterval:computerDelay target:self selector:@selector(computerMove) userInfo:nil repeats:NO];
        }
        else {
            isPlayer1Turn = YES;
            playerLabel.text = @"Your Turn";
            [[playerLabel layer] addAnimation:textChange forKey:kCATransition];
        }
    }
}


-(void)buttonWithName:(int)buttonName andIsRemoving:(BOOL)removing{
    NSMutableArray * horizontalLines = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"14",@"15",@"16",@"17",@"18",@"19",@"27",@"28",@"29",@"30",@"31",@"32",@"40",@"41",@"42",@"43",@"44",@"45",@"53",@"54",@"55",@"56",@"57",@"58",@"66",@"67",@"68",@"69",@"70",@"71",@"79",@"80",@"81",@"82",@"83",@"84", nil];
    NSMutableArray * verticalLines = [NSMutableArray arrayWithObjects:@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"59",@"60",@"61",@"62",@"63",@"64",@"65",@"72",@"73",@"74",@"75",@"76",@"77",@"78", nil];
    for (UIButton * button in self.view.subviews) {
        if (100 > button.tag > 0) {
            if (removing) {
                for (NSString * line in horizontalLines) {
                    if (button.tag == [line intValue] && buttonName == button.tag) {
                        [button setImage:[[UIColorForString sharedInstance] imageForColor:userBoardColor forType:@"horizontial"] forState:UIControlStateNormal];
                        return;
                    }
                }
                for (NSString * line in verticalLines) {
                    if (button.tag == [line intValue] && buttonName == button.tag) {
                        [button setImage:[[UIColorForString sharedInstance] imageForColor:userBoardColor     forType:@"vertical"] forState:UIControlStateNormal];
                        return;
                    }
                }
            }
            else {
            for (NSString * line in horizontalLines) {
                if (button.tag == [line intValue] && buttonName == button.tag) {CATransition *transition = [CATransition animation];
                    transition.delegate = self;
                    transition.duration = .5;
                    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                    transition.type = kCATransitionFade;
                    transition.subtype = kCATransitionFromBottom;
                    
                    [button.layer addAnimation:transition forKey:kCATransition];
                    [button setImage:[[UIColorForString sharedInstance]imageForColor:userLineColor forType:@"horizontial"] forState:UIControlStateNormal];
                    [lastTouchView removeFromSuperview];
                    if (!isPlayer1Turn) {
                        UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"touch"]];
                        lastTouchView = imageView;
                        imageView.center = button.center;
                        [self.view addSubview:imageView];
                    }

                    return;
                }
            }
            for (NSString * line in verticalLines) {
                if (button.tag == [line intValue] && buttonName == button.tag) {
                    CATransition *transition = [CATransition animation];
                    transition.delegate = self;
                    transition.duration = .5;
                    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                    transition.type = kCATransitionFade;
                    transition.subtype = kCATransitionFromBottom;
                    
                    [button.layer addAnimation:transition forKey:kCATransition];
                    [button setImage:[[UIColorForString sharedInstance]imageForColor:userLineColor forType:@"vertical"] forState:UIControlStateNormal];
                    [lastTouchView removeFromSuperview];
                    if (!isPlayer1Turn) {
                        UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"touch"]];
                        lastTouchView = imageView;
                        imageView.center = button.center;
                        [self.view addSubview:imageView];
                    }
                    return;
                }
            }
            }
        }
    }
}

@end
