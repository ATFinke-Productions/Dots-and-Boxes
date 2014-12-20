//
//  ComputerViewController.m
//  dot
//
//  Created by Andrew on 4/7/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "ComputerViewController.h"
#import "lineAI.h"

#define transitionDuration 2;

@implementation ComputerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)close:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configSquares];
    [Flurry logEvent:@"Enter Computer View"];
    computerDelay = 1;
    defaults = [NSUserDefaults standardUserDefaults];
    userBoardColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userBoardColor"]];
    userLineColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userLineColor"]];
    bar.tintColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userViewColor"]];
    segSwitch.tintColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userViewColor"]];
    
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
    
    if ([[UIScreen mainScreen] bounds].size.height == 1024) {
        for (UIImageView *item in self.view.subviews) {
            if (item.tag != 10000) {
                item.frame = CGRectOffset(item.frame, [[UIScreen mainScreen] bounds].size.width/3.5, [[UIScreen mainScreen] bounds].size.height/4);
            }
        }
    }
    //NONONONONONONONONONONONO
    playerNumberTurn = 1;
    [self computerMoveAndChangeTurn:NO];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateView{
    [self reloadSquareArray];
    player1Score = [squaresForPlayer1 count];
    player2Score = [squaresForPlayer2 count];
    player3Score = [squaresForPlayer3 count];
    player4Score = [squaresForPlayer4 count];
    playersScoreLabel.text = [NSString stringWithFormat:@"P1: %lld      P2: %lld      P3: %lld      P4: %lld",player1Score,player2Score,player3Score,player4Score];
    NSMutableArray * squaresTakenArray = [NSMutableArray arrayWithObjects:squaresForPlayer1,squaresForPlayer2,squaresForPlayer3,squaresForPlayer4, nil];
    
    for (int player = 0; player < 4; player++) {
        for (NSString *squareNumbers in squaresTakenArray[player]) {
            for (UIImageView * imageView in self.view.subviews) {
                if (240 > imageView.tag && 200 < imageView.tag) {
                    if (imageView.tag - 200 == [squareNumbers intValue]) {
                        imageView.image = [[UIColorForString sharedInstance] imageForColorWithString:[defaults valueForKey:[NSString stringWithFormat:@"userP%dColor",player + 1]] forType:nil];
                        [[imageView layer]addAnimation:transition forKey:kCATransition];
                    }
                }
            }
        }
    }
    if (player1Score+player2Score+player3Score+player4Score>=36 && !hasClosed) {
        MBAlertView * alert = [MBAlertView errorWithBody:@"Game Over." cancelTitle:@"Ok" cancelBlock:nil];
        [alert addToDisplayQueue];
    }
    [self computerMoveAndChangeTurn:!justTookSquare];
}

-(void)viewWillDisappear:(BOOL)animated{
    hasClosed = YES;
}
-(void)computerMoveAndChangeTurn:(BOOL)changeTurn{
    justTookSquare = NO;
    if (changeTurn && playerNumberTurn < 4) {
        playerNumberTurn++;
    }
    else if (changeTurn && playerNumberTurn == 4) {
        playerNumberTurn = 1;
    }
    [NSTimer scheduledTimerWithTimeInterval:computerDelay target:self selector:@selector(move) userInfo:nil repeats:NO];
}
-(void)move{
    [self reloadSquareArray];
    NSString * potienalLine = [[lineAI sharedInstance] moveForSpaceWithSquares:allSquares];
    if (![potienalLine isEqual:@"GAME"]) {
        [linesToAddToGrid addObject:potienalLine];
        [self removeSpaceForLine];
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
        [self updateView];
    }
    else {
        justTookSquare = NO;
        [self computerMoveAndChangeTurn:YES];
    }
}


-(void)buttonWithName:(int)buttonName {
    NSMutableArray * horizontalLines = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"14",@"15",@"16",@"17",@"18",@"19",@"27",@"28",@"29",@"30",@"31",@"32",@"40",@"41",@"42",@"43",@"44",@"45",@"53",@"54",@"55",@"56",@"57",@"58",@"66",@"67",@"68",@"69",@"70",@"71",@"79",@"80",@"81",@"82",@"83",@"84", nil];
    NSMutableArray * verticalLines = [NSMutableArray arrayWithObjects:@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"59",@"60",@"61",@"62",@"63",@"64",@"65",@"72",@"73",@"74",@"75",@"76",@"77",@"78", nil];
    for (UIButton * button in self.view.subviews) {
        if (100 > button.tag > 0) {
            for (NSString * line in horizontalLines) {
                if (button.tag == [line intValue] && buttonName == button.tag) {
                    [button.layer addAnimation:transition forKey:kCATransition];
                    [button setImage:[[UIColorForString sharedInstance]imageForColor:userLineColor forType:@"horizontial"] forState:UIControlStateNormal];
                    
                    [lastTouchView removeFromSuperview];
                    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"touch"]];
                    lastTouchView = imageView;
                    imageView.center = button.center;
                    [self.view addSubview:imageView];
                    
                    return;
                }
            }
            for (NSString * line in verticalLines) {
                if (button.tag == [line intValue] && buttonName == button.tag) {
                    [button.layer addAnimation:transition forKey:kCATransition];
                    [button setImage:[[UIColorForString sharedInstance]imageForColor:userLineColor forType:@"vertical"] forState:UIControlStateNormal];
                    
                    [lastTouchView removeFromSuperview];
                    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"touch"]];
                    lastTouchView = imageView;
                    imageView.center = button.center;
                    [self.view addSubview:imageView];
                    
                    return;
                }
            }
        }
    }
}
-(IBAction)changeSpeed:(id)sender{
    if (segSwitch.selectedSegmentIndex == 0) {
        computerDelay = 2;
    }
    else if (segSwitch.selectedSegmentIndex == 1) {
        computerDelay = 1;
    }
    else if (segSwitch.selectedSegmentIndex == 2) {
        computerDelay = .5;
    }
    else if (segSwitch.selectedSegmentIndex == 3) {
        computerDelay = .1;
    }
}

@end
