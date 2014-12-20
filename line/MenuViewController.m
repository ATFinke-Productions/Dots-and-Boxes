//
//  MenuViewController.m
//  dot
//
//  Created by Andrew on 4/1/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "MenuViewController.h"
#import "GCTurnBasedMatchHelper.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

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
    [self.navigationController setNavigationBarHidden:NO animated:NO];
     self.navigationItem.hidesBackButton=YES;
    transition = [CATransition animation];
    transition.delegate = self;
    transition.duration = 2;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    self.navigationController.navigationBar.tintColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userViewColor"]];
    self.view.backgroundColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userViewColor"]];
}

-(void)insertNewBoard{
    newBoard = [[[NSBundle mainBundle] loadNibNamed:@"MenuBoard" owner:self options:nil]lastObject];
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        newBoard.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, 140);
    }
    else if ([[UIScreen mainScreen] bounds].size.height == 1024) {
        newBoard.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height*.25);
        load.hidden = YES;
        if (self.interfaceOrientation == 4 || self.interfaceOrientation == 3) {
            newBoard.center = CGPointMake([[UIScreen mainScreen] bounds].size.height/2, [[UIScreen mainScreen] bounds].size.width*.25+10);
        }
    }
    else {
        newBoard.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, 110);
    }
    [newBoard.layer setMasksToBounds:YES];
    [newBoard.layer setBorderColor:[UIColor blackColor].CGColor];
    [newBoard.layer setBorderWidth:5.0];
    [newBoard.layer setCornerRadius:20];
    newBoard.layer.shadowPath = [UIBezierPath bezierPathWithRect:newBoard.bounds].CGPath;
    [self.view addSubview:newBoard];

    [newBoard.layer addAnimation:transition forKey:kCATransition];
}


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (lastBoard != newBoard) {
        [lastBoard removeFromSuperview];
        lastBoard = newBoard;
    }
}


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.tintColor = [[UIColorForString sharedInstance] colorForString:[[NSUserDefaults standardUserDefaults] valueForKey:@"userViewColor"]];
    self.view.backgroundColor = [[UIColorForString sharedInstance] colorForString:[[NSUserDefaults standardUserDefaults] valueForKey:@"userViewColor"]];
    [self insertNewBoard];
    timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(insertNewBoard) userInfo:nil repeats:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    if (!buttonSet) {
        for (UIButton * button in self.view.subviews) {
            if (button.tag == 10) {
                float radius = 20.0f;
                button.hidden = NO;
                [button.layer setMasksToBounds:YES];
                [button.layer setBorderColor:[UIColor darkTextColor].CGColor];
                [button.layer setBorderWidth:3.0];
                [button.layer setCornerRadius:radius];
                button.layer.shadowPath = [UIBezierPath bezierPathWithRect:button.bounds].CGPath;
                [[button layer]addAnimation:transition forKey:kCATransition];
            }
        }
        buttonSet = YES;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [timer invalidate];
}
-(IBAction)showGame:(id)sender{
    if ([[GCTurnBasedMatchHelper sharedInstance] isAuthenticated]){
        [self performSegueWithIdentifier:@"showGame" sender:self];
    }
    else {
        MBAlertView * alert = [MBAlertView errorWithBody:@"You need to beed signed into Game Center." cancelTitle:@"Ok" cancelBlock:nil];
        [alert addToDisplayQueue];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
