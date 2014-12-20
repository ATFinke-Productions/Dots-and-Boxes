//
//  GameOverViewController.m
//  line
//
//  Created by Andrew on 3/11/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "GameOverViewController.h"

@interface GameOverViewController ()

@end

@implementation GameOverViewController

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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    player1ScoreLabel.text = [NSString stringWithFormat:@"Player 1's Score: %ld",(long)[defaults integerForKey:@"player1Score"]];
    player2ScoreLabel.text = [NSString stringWithFormat:@"Player 2's Score: %ld",(long)[defaults integerForKey:@"player2Score"]];
    
    if ([defaults integerForKey:@"player1Score"]>[defaults integerForKey:@"player2Score"]) {
        victoryLabel.text = @"Player 1 Won";
    }
    else if ([defaults integerForKey:@"player1Score"]<[defaults integerForKey:@"player2Score"]) {
        victoryLabel.text = @"Player 2 Won";
    }
    else {
        victoryLabel.text = @"Tie";
    }
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)newGame:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
