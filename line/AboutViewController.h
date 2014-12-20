//
//  AboutViewController.h
//  line
//
//  Created by Andrew on 3/11/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuBoard.h"

@interface AboutViewController : UIViewController {
    MenuBoard * lastBoard;
    MenuBoard * newBoard;
    NSTimer * timer;
    CATransition *transition;
}

@end
