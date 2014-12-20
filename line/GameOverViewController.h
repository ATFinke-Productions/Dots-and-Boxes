//
//  GameOverViewController.h
//  line
//
//  Created by Andrew on 3/11/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameOverViewController : UIViewController {
    IBOutlet UILabel *player1ScoreLabel;
    IBOutlet UILabel *player2ScoreLabel;
    IBOutlet UILabel *victoryLabel;
}
-(IBAction)newGame:(id)sender;

@end
