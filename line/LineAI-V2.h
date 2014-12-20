//
//  LineAI-V2.h
//  Boxes
//
//  Created by Andrew on 4/21/13.
//  Copyright (c) 2013 ATFinke Productions Incorporated. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBHUDView.h"

@interface LineAI_V2 : NSObject

+ (LineAI_V2 *) sharedInstance;
- (NSString *) lineForSquares:(NSMutableArray *)squares;
@end
