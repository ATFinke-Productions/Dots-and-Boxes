//
//  MenuViewController.h
//  dot
//
//  Created by Andrew on 4/1/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuBoard.h"
@interface MenuViewController : UIViewController {
    IBOutlet UILabel * load;
    MenuBoard * lastBoard;
    MenuBoard * newBoard;
    NSTimer * timer;
    CATransition *transition;
    BOOL buttonSet;
}
-(IBAction)showGame:(id)sender;

@end
