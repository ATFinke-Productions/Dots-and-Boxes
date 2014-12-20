//
//  CreateMatchViewController.h
//  Boxes
//
//  Created by Andrew on 4/19/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateMatchViewController : UITableViewController <UITextFieldDelegate>{
    IBOutlet UIButton * saveButton;
    IBOutlet UILabel * prompt;
    IBOutlet UITextField * matchName;
    IBOutlet UIView * bottomView;
}

-(IBAction)save:(id)sender;
-(IBAction)dismissKeyboard:(id)sender;
@end
