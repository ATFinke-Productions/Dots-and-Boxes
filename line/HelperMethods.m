//
//  HelperMethods.m
//  MonkeyJump
//
//  Created by Fahim Farook on 18/8/12.
//
//

#import "HelperMethods.h"
#import "GameConstants.h"
#import "GCTurnBasedMatchHelper.h"
@implementation HelperMethods

+(void)reportAchievementsForWins:(int64_t)wins{

    NSString *rootPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 	 NSUserDomainMask, YES)[0];
    
    NSString *plistPath =
	[rootPath
	 stringByAppendingPathComponent:
	 kAchievementsWinsFileName];
    
    if (![[NSFileManager defaultManager]
          fileExistsAtPath:plistPath]) {
        
        plistPath =
		[[NSBundle mainBundle]
		 pathForResource:kAchievementsWinsResourceName
		 ofType:@"plist"];
    }
    
    // 2
    NSArray *achievements =
	[NSArray arrayWithContentsOfFile:plistPath];
    
    // 3
    if (achievements == nil) {
        NSLog(@"Error reading plist: %@",
              kAchievementsWinsFileName);
        return;
    }
    
    // 4
    for (NSDictionary *achievementDetail
		 in achievements) {
        
        NSString *achievementId =
		achievementDetail[@"achievementId"];
        
        NSString *number =
		achievementDetail[@"number"];
        
        float percentComplete =
		(wins * 1.0f/[number intValue])
		* 100;
        NSLog(@"%lld  needed:%@  percent:%f",wins,number,percentComplete);
        if (percentComplete > 100)
            percentComplete = 100;
        
        [[GCTurnBasedMatchHelper sharedInstance] reportAchievementWithID:achievementId 		 percentComplete:percentComplete];
    }
}

+(void)reportParticipation{
    NSString *achievementId =@"com.atfp.tap.part";
    [[GCTurnBasedMatchHelper sharedInstance] reportAchievementWithID:achievementId 		 percentComplete:100];
}
+(void)report20Square{
    NSString *achievementId =@"com.atfp.line.square20";
    [[GCTurnBasedMatchHelper sharedInstance] reportAchievementWithID:achievementId 		 percentComplete:100];
}
@end
