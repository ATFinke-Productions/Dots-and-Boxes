//
//  MenuBoard.m
//  dot
//
//  Created by Andrew on 4/5/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "MenuBoard.h"

@implementation MenuBoard

-(void)setNeedsDisplay{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * imageViewArray = [[NSMutableArray alloc]init];
    
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
    
    for (UIImageView * imageView in self.subviews) {
        if (imageView.tag>=200 && imageView.tag < 220) {
            [imageViewArray addObject:imageView];
        }
    }
    
    for (int im = 0; im < [imageViewArray count]; im++) {
        int playerForSquare = (arc4random() % 4)+1;
        UIImageView * imageInArray = imageViewArray[im];
        imageInArray.image = [[UIColorForString sharedInstance]imageForColorWithString:[defaults valueForKey:[NSString stringWithFormat:@"userP%dColor",playerForSquare]] forType:nil];
    }

}

@end
