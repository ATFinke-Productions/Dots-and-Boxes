//
//  Confirm.m
//  Boxes
//
//  Created by Andrew on 4/11/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "Confirm.h"

@implementation Confirm
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)setNeedsDisplay{
    self.backgroundColor = [[UIColorForString sharedInstance] colorForString:[[NSUserDefaults standardUserDefaults] valueForKey:@"userViewColor"]];
    for (UIButton * button in self.subviews) {
        if (button.tag == 10) {
            float radius = 20.0f;
            button.hidden = NO;
            [button.layer setMasksToBounds:YES];
            [button.layer setBorderColor:[UIColor darkTextColor].CGColor];
            [button.layer setBorderWidth:3.0];
            [button.layer setCornerRadius:radius];
            button.layer.shadowPath = [UIBezierPath bezierPathWithRect:button.bounds].CGPath;
        }
    }
}
-(IBAction)confirm:(id)sender{
    [self.delegate confirm];
}

-(IBAction)cancel:(id)sender{
    [self.delegate cancel];
}


@end
