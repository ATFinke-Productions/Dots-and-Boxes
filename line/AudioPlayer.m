//
//  AudioPlayer.m
//  Boxes
//
//  Created by Andrew on 4/23/13.
//  Copyright (c) 2013 ATFinke Productions Incorporated. All rights reserved.
//

#import "AudioPlayer.h"

@implementation AudioPlayer


+(void) playSound:(NSString *)soundFile ofType:(NSString *)type{
    SystemSoundID soundEffect;
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:soundFile ofType:type];
	NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
	AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, & soundEffect);
    AudioServicesPlaySystemSound(soundEffect);
}

@end
