//
//  PracticeInfoViewController.h
//  dot
//
//  Created by Andrew on 4/6/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MenuBoard.h"
@interface PracticeInfoViewController : UIViewController {
    MenuBoard * lastBoard;
    MenuBoard * newBoard;
    NSTimer * timer;
    CATransition *transition;
}
@end
