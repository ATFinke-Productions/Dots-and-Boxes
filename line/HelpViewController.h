//
//  HelpViewController.h
//  line
//
//  Created by Andrew on 3/11/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpViewController : UIViewController {
    int tutorialState;
    
    NSUserDefaults * defaults;
    CATransition *transition;
    
    UIColor * userBoardColor;
    UIColor * userLineColor;
    
    IBOutlet UILabel * tutorialLabel;
    IBOutlet UIButton * tutorialSwitch;
    
    
    UIImageView * lastTouchView;
}

-(IBAction)reset:(id)sender;
-(IBAction)tutorialChange:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end
