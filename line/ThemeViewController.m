//
//  ThemeViewController.m
//  dot
//
//  Created by Andrew on 4/3/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "ThemeViewController.h"
#import "ColorViewController.h"

@interface ThemeViewController ()

@end

@implementation ThemeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    colorForP1.text = [defaults valueForKey:@"userP1Color"];
    colorForP2.text = [defaults valueForKey:@"userP2Color"];
    colorForP3.text = [defaults valueForKey:@"userP3Color"];
    colorForP4.text = [defaults valueForKey:@"userP4Color"];
    
    colorForBoard.text = [defaults valueForKey:@"userBoardColor"];
    colorForLine.text = [defaults valueForKey:@"userLineColor"];
    colorForView.text = [defaults valueForKey:@"userViewColor"];
    
    self.navigationController.navigationBar.tintColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userViewColor"]];
    self.view.backgroundColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userViewColor"]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [Flurry logEvent:@"Enter Theme View"];
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    colorForP1.text = [defaults valueForKey:@"userP1Color"];
    colorForP2.text = [defaults valueForKey:@"userP2Color"];
    colorForP3.text = [defaults valueForKey:@"userP3Color"];
    colorForP4.text = [defaults valueForKey:@"userP4Color"];
    
    colorForBoard.text = [defaults valueForKey:@"userBoardColor"];
    colorForLine.text = [defaults valueForKey:@"userLineColor"];
    colorForView.text = [defaults valueForKey:@"userViewColor"];
    
    self.navigationController.navigationBar.tintColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userViewColor"]];
    self.view.backgroundColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userViewColor"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)playerBoard:(id)sender{
    [MBAlertView dismissCurrentHUD];
    MBAlertView * alert = [MBAlertView errorWithBody:@"Would you like to change the board to a custom image or just change the color of the board?" cancelTitle:@"Image" cancelBlock:^{
        PhotoOptionsViewController *detailViewController = [[PhotoOptionsViewController alloc] initWithNibName:@"PhotoOptionsViewController" bundle:nil];
        [self presentViewController:detailViewController animated:YES completion:nil];
    }];
    [alert addButtonWithText:@"Color" type:MBAlertViewItemTypeDefault block:^{
        [self performSegueWithIdentifier:@"showColors" sender:@"board"];
    }];
    [alert addToDisplayQueue];
}
-(IBAction)playerLines:(id)sender{
    [self performSegueWithIdentifier:@"showColors" sender:@"lines"];
}
-(IBAction)playerSquare1:(id)sender{
    [self performSegueWithIdentifier:@"showColors" sender:@"P1Box"];
}
-(IBAction)playerSquare2:(id)sender{
    [self performSegueWithIdentifier:@"showColors" sender:@"P2Box"];
}
-(IBAction)playerSquare3:(id)sender{
    [self performSegueWithIdentifier:@"showColors" sender:@"P3Box"];
}
-(IBAction)playerSquare4:(id)sender{
    [self performSegueWithIdentifier:@"showColors" sender:@"P4Box"];
}
-(IBAction)playerBackground:(id)sender {
    [self performSegueWithIdentifier:@"showColors" sender:@"view"];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showColors"]) {
        //ColorViewController *destViewController = segue.destinationViewController;
        [[segue destinationViewController] setThemeItem:sender];
    }
}

@end
