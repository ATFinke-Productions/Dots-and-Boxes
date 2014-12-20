//
//  MultiplayerInfoViewController.h
//  Boxes
//
//  Created by Andrew on 4/20/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuBoard.h"

@interface MultiplayerInfoViewController : UIViewController{
    MenuBoard * lastBoard;
    MenuBoard * newBoard;
    NSTimer * timer;
    CATransition *transition;
}

@end
