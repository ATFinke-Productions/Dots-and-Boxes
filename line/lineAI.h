//
//  lineAI.h
//  dot
//
//  Created by Andrew on 4/5/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBHUDView.h"
@interface lineAI : NSObject

+ (lineAI *)sharedInstance;
-(NSString *)moveForSpaceWithSquares:(NSMutableArray *)squares;
@end
