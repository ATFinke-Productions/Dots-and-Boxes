//
//  LoadingMenu.m
//  dot
//
//  Created by Andrew on 4/6/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "LoadingMenu.h"
@implementation LoadingMenu


-(void)setNeedsDisplay{
    
    for (UIButton * button in self.subviews) {
        if (button.tag == 100) {
            [button setImage:[[UIColorForString sharedInstance] imageForColor:[UIColor blackColor] forType:@"horizontial"] forState:UIControlStateNormal];
        }
    }
    
    for (UIButton * button in self.subviews) {
        if (button.tag == 110) {
            [button setImage:[[UIColorForString sharedInstance] imageForColor:[UIColor blackColor] forType:@"vertical"] forState:UIControlStateNormal];
        }
    }
    
    imageViewArray = [[NSMutableArray alloc]init];
    for (UIImageView * imageView in self.subviews) {
        if (imageView.tag>=200 && imageView.tag < 220) {
            [imageViewArray addObject:imageView];
        }
    }
    NSLog(@"!!!");
    transition.duration = 2.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateView) userInfo:nil repeats:YES];
}

-(void)updateView{
    NSLog(@"!");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];    
    for (int i = 0; i < [imageViewArray count]; i++) {
        int playerForSquare = (arc4random() % 4)+1;
        UIImageView * imageInArray = [imageViewArray objectAtIndex:i];
        imageInArray.image = [[UIColorForString sharedInstance]imageForColorWithString:[defaults valueForKey:[NSString stringWithFormat:@"userP%dColor",playerForSquare]] forType:nil];
        [[imageInArray layer]addAnimation:transition forKey:kCATransition];
    }
}

@end
