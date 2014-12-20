//
//  AudioPlayer.h
//  Boxes
//
//  Created by Andrew on 4/23/13.
//  Copyright (c) 2013 ATFinke Productions Incorporated. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface AudioPlayer : NSObject
+(void) playSound:(NSString *)soundFile ofType:(NSString *)type;
@end
