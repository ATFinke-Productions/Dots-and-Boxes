//
//  FeedbackViewController.h
//  Boxes
//
//  Created by Andrew on 4/18/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackViewController : UIViewController <UITextViewDelegate>{
    IBOutlet UITextView * textView;
    IBOutlet UIBarButtonItem *feed;
    BOOL placeHolderVisible;
}

-(IBAction)submit:(id)sender;

@end
