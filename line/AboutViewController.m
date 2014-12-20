//
//  AboutViewController.m
//  line
//
//  Created by Andrew on 3/11/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "AboutViewController.h"
@interface AboutViewController ()

@end

@implementation AboutViewController

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
    [Flurry logEvent:@"Enter About View"];
    for (UIButton * button in self.view.subviews) {
        if (button.tag == 10) {
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
        newBoard.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, 170);
    }
    else if ([[UIScreen mainScreen] bounds].size.height == 1024) {
        newBoard.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height*.25);
        if (self.interfaceOrientation == 4 || self.interfaceOrientation == 3) {
            newBoard.center = CGPointMake([[UIScreen mainScreen] bounds].size.height/2, [[UIScreen mainScreen] bounds].size.width*.25+10);
        }
    }
    else {
        newBoard.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, 145);
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)more:(id)sender{
    //[ATFinke show];
}
-(IBAction)web:(id)sender{
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"http://www.atfinkeproductions.com"]];
}


@end
