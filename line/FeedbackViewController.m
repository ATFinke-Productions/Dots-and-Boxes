//
//  FeedbackViewController.m
//  Boxes
//
//  Created by Andrew on 4/18/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "FeedbackViewController.h"
#import "MBHUDView.h"
@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    placeHolderVisible = YES;
    feed.enabled = NO;
    self.navigationController.navigationBar.tintColor = [[UIColorForString sharedInstance] colorForString:[[NSUserDefaults standardUserDefaults] valueForKey:@"userViewColor"]];
    self.view.backgroundColor = [[UIColorForString sharedInstance] colorForString:[[NSUserDefaults standardUserDefaults] valueForKey:@"userViewColor"]];
    textView.delegate = self;

	// Do any additional setup after loading the view.
}

-(void)textViewDidBeginEditing:(UITextView *)textViewEdit{
    if (placeHolderVisible) {
        textViewEdit.text = @"";
        placeHolderVisible = NO;
    }
    feed.enabled = YES;
}
- (BOOL)textView:(UITextView *)textViewEdit shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textViewEdit resignFirstResponder];
        if (feed.enabled == YES) {
            MBAlertView * alert = [MBAlertView errorWithBody:@"Would you like to send your feedback?" cancelTitle:@"No" cancelBlock:nil];
            [alert addButtonWithText:@"Yes" type:MBAlertViewItemTypePositive block:^{
                [self submit:nil];
            }];
            
            [alert addToDisplayQueue];
        }
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)submit:(id)sender{
    feed.enabled = NO;
    [MBHUDView hudWithBody:@"Sent" type:MBAlertViewHUDTypeCheckmark hidesAfter:1.5 show:YES];
    [Flurry logEvent:@"Feedback" withParameters:@{@"Response": textView.text}];
}

@end
