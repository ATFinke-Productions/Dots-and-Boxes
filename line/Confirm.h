//
//  Confirm.h
//  Boxes
//
//  Created by Andrew on 4/11/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
@class Confirm;
@protocol ConfirmDelegate
-(void)confirm;
-(void)cancel;

@end

@interface Confirm : UIView {
    IBOutlet UIButton *send;
}

@property (nonatomic, weak) IBOutlet id <ConfirmDelegate> delegate;

-(IBAction)confirm:(id)sender;
-(IBAction)cancel:(id)sender;

@end
