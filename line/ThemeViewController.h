//
//  ThemeViewController.h
//  dot
//
//  Created by Andrew on 4/3/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoOptionsViewController.h"

@interface ThemeViewController : UIViewController {
    IBOutlet UILabel * colorForP1;
    IBOutlet UILabel * colorForP2;
    IBOutlet UILabel * colorForP3;
    IBOutlet UILabel * colorForP4;
    IBOutlet UILabel * colorForBoard;
    IBOutlet UILabel * colorForLine;
    IBOutlet UILabel * colorForView;
}

-(IBAction)playerSquare1:(id)sender;
-(IBAction)playerSquare2:(id)sender;
-(IBAction)playerSquare3:(id)sender;
-(IBAction)playerSquare4:(id)sender;

-(IBAction)playerBoard:(id)sender;
-(IBAction)playerLines:(id)sender;
-(IBAction)playerBackground:(id)sender;

@end
