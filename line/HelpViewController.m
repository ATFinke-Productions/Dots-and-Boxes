//
//  HelpViewController.m
//  line
//
//  Created by Andrew on 3/11/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "HelpViewController.h"

#define transitionDuration 2;

@interface HelpViewController ()

@end

@implementation HelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [Flurry logEvent:@"Enter Help View"];
    defaults = [NSUserDefaults standardUserDefaults];
    self.navigationController.navigationBar.tintColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userViewColor"]];
    self.view.backgroundColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userViewColor"]];
    for (UIButton * button in self.view.subviews) {
        if (button.tag == 10000) {
            float radius = 20.0f;
            [button.layer setMasksToBounds:YES];
            [button.layer setBorderColor:[UIColor darkTextColor].CGColor];
            [button.layer setBorderWidth:3.0];
            [button.layer setCornerRadius:radius];
            button.layer.shadowPath = [UIBezierPath bezierPathWithRect:button.bounds].CGPath;
        }
    }

    transition = [CATransition animation];
    transition.delegate = self;
    transition.duration = transitionDuration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromBottom;
    
    [self.backgroundImageView.layer setMasksToBounds:YES];
    [self.backgroundImageView.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.backgroundImageView.layer setBorderWidth:3.0];
    [self.backgroundImageView.layer setCornerRadius:15];
    
    userBoardColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userBoardColor"]];
    userLineColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userLineColor"]];

    self.backgroundImageView.image = [[UIColorForString sharedInstance]imageForColor:userBoardColor forType:nil];
    self.view.backgroundColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userViewColor"]];
    
    if ([[UIScreen mainScreen] bounds].size.height == 1024) {
        for (UIImageView *item in self.view.subviews) {
            if (item.tag != 10000 && item.tag != 1000) {
                item.frame = CGRectOffset(item.frame, [[UIScreen mainScreen] bounds].size.width/3.5, [[UIScreen mainScreen] bounds].size.height/4);
                if (self.interfaceOrientation == 4 || self.interfaceOrientation == 3) {
                    item.frame = CGRectOffset(item.frame, 130, -130);
                }
            }
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)reset:(id)sender{
    MBAlertView * alert = [MBAlertView errorWithBody:@"Are you sure you wish to reset all game data?" cancelTitle:@"Cancel!" cancelBlock:nil];
    [alert addButtonWithText:@"Reset" type:MBAlertViewItemTypeDestructive block:^{
        NSDictionary *defaultsDictionary = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
        for (NSString *key in [defaultsDictionary allKeys]) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
        [defaults setValue:@"Red" forKey:@"userP1Color"];
        [defaults setValue:@"Blue" forKey:@"userP2Color"];
        [defaults setValue:@"Yellow" forKey:@"userP3Color"];
        [defaults setValue:@"Purple" forKey:@"userP4Color"];
        [defaults setValue:@"White" forKey:@"userBoardColor"];
        [defaults setValue:@"Black" forKey:@"userLineColor"];
        [defaults setValue:@"Dark Gray" forKey:@"userViewColor"];
        [defaults synchronize];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",documentsDirectory,@"background.JPEG"] error:nil];
    }];
    [alert addToDisplayQueue];
    
}





-(void)updateImageViewSquare:(int)tag forPlayer:(int)player{
    tag = tag + 200;
    for (UIImageView * imageView in self.view.subviews) {
        if (imageView.tag == tag) {
            imageView.image = [[UIColorForString sharedInstance] imageForColorWithString:[defaults valueForKey:[NSString stringWithFormat:@"userP%dColor",player + 1]] forType:nil];
            [[imageView layer]addAnimation:transition forKey:kCATransition];
        }
    }
}
 

-(void)changeTutorialState{
    tutorialState ++;
    NSString * tutorialInfoString;
    switch (tutorialState) {
        case 1:
            [Flurry logEvent:@"Tutorial Start"];
            [tutorialSwitch setTitle:@"Next Part Of Tutorial" forState:UIControlStateNormal];
            [self buttonWithName:1];
            tutorialInfoString = @"Now you will see how to capture a square.\nPart 1/11";
            break;
        case 2:
            [self buttonWithName:3];
            tutorialInfoString = @"In order to place a line, you have to tap on where you want it to go, as shown on the board.\nPart 2/11";
            break;
        case 3:
            [self buttonWithName:7];
            tutorialInfoString = @"See how that line made the box have only one line left to take? Avoid making a move that makes a square have one line left.\nPart 3/11";
            break;
        case 4:
            [self buttonWithName:8];
            tutorialInfoString = @"Because of the previous move by player 1, player 2 was able to claim the square, increasing his score, by taking the square's last available line.\nPart 4/11";
            [self updateImageViewSquare:1 forPlayer:2];
            break;
        case 5:
            tutorialInfoString = @"Lets start a new board with lines already placed. Now we will show you how to take multiple squares in one turn.\nPart 5/11";
            for (UIButton * lineButton in self.view.subviews) {
                if (13 > lineButton.tag) {
                    [lineButton setImage:[[UIColorForString sharedInstance] imageForColor:userBoardColor forType:nil] forState:UIControlStateNormal];
                    [[lineButton layer]addAnimation:transition forKey:kCATransition];
                }
            }
            for (UIImageView * blockView in self.view.subviews) {
                if (205 > blockView.tag && 200 < blockView.tag) {
                    blockView.image = [[UIColorForString sharedInstance] imageForColor:userBoardColor forType:nil];
                    [[blockView layer]addAnimation:transition forKey:kCATransition];
                }
            }
            [self buttonWithName:1];
            [self buttonWithName:2];
            [self buttonWithName:3];
            [self buttonWithName:5];
            [self buttonWithName:6];
            [self buttonWithName:9];
            [self buttonWithName:12];
            break;
        case 6:
            [self buttonWithName:7];
            tutorialInfoString = @"See how player 2 made the square have only one line left to take? Now player 1 can take the square.\nPart 6/11";
            break;
        case 7:
            [self buttonWithName:8];
            [self updateImageViewSquare:1 forPlayer:1];
            tutorialInfoString = @"Because of the previous move by player 2, player 1 was able to claim the square. However, when you claim a square, it is still your turn.\nPart 7/11";
            break;
        case 8:
            [self buttonWithName:4];
            [self updateImageViewSquare:2 forPlayer:1];
            tutorialInfoString = @"Since player 1 claimed a square, it was still his turn so he was then able to take another square becuase it had only one line left to draw.\nPart 8/11";
            break;
        case 9:
            [self buttonWithName:11];
            [self buttonWithName:10];
            [self updateImageViewSquare:4 forPlayer:1];
            [self updateImageViewSquare:3 forPlayer:1];
            tutorialInfoString = @"In the end player 1 was able to claim the rest of the squares becuase whenever he took a square, he made another square only have one last line to make.\nPart 9/11";
            break;
        case 10:
            for (UIButton * lineButton in self.view.subviews) {
                if (13 > lineButton.tag) {
                    [lineButton setImage:[[UIColorForString sharedInstance] imageForColor:userBoardColor forType:nil] forState:UIControlStateNormal];
                    [[lineButton layer]addAnimation:transition forKey:kCATransition];
                }
            }
            for (UIImageView * blockView in self.view.subviews) {
                if (205 > blockView.tag && 200 < blockView.tag) {
                    blockView.image = [[UIColorForString sharedInstance] imageForColor:userBoardColor forType:nil];
                    [[blockView layer]addAnimation:transition forKey:kCATransition];
                }
            }
            tutorialInfoString = @"When you play real games the board will not countain only four squares, it will have thrity-six. For additional help you can try out the local mode and play against the AI. \nPart 10/11";
            break;
        case 11:
            [Flurry logEvent:@"Tutorial End"];
            tutorialInfoString = @" When you are ready to play with others around the world, go to the multiplayer section. Good luck and thanks for downloading!\nPart 11/11";
            tutorialState = 0;
            [tutorialSwitch setTitle:@"Restart Tutorial" forState:UIControlStateNormal];
            [[tutorialSwitch layer]addAnimation:transition forKey:kCATransition];
            break;
        default:
            break;
    }
    tutorialLabel.text = tutorialInfoString;
    [[tutorialLabel layer]addAnimation:transition forKey:kCATransition];
}


-(void)buttonWithName:(int)buttonName {
    [lastTouchView removeFromSuperview];
    NSMutableArray * horizontalLines = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    NSMutableArray * verticalLines = [NSMutableArray arrayWithObjects:@"7",@"8",@"9",@"10",@"11",@"12", nil];
    for (UIButton * button in self.view.subviews) {
        if (100 > button.tag > 0) {
            for (NSString * line in horizontalLines) {
                if (button.tag == [line intValue] && buttonName == button.tag) {
                    [button.layer addAnimation:transition forKey:kCATransition];
                    [button setImage:[[UIColorForString sharedInstance]imageForColor:userLineColor forType:@"horizontial"] forState:UIControlStateNormal];
                    if (buttonName == 3) {
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
                    [button.layer addAnimation:transition forKey:kCATransition];
                    [button setImage:[[UIColorForString sharedInstance]imageForColor:userLineColor forType:@"vertical"] forState:UIControlStateNormal];
                    
                    return;
                }
            }
        }
    }
}
-(IBAction)tutorialChange:(id)sender{
    [self changeTutorialState];
}

@end