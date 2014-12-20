//
//  AppDelegate.m
//  line
//
//  Created by Andrew on 3/3/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "AppDelegate.h"
#import "GCTurnBasedMatchHelper.h"
#import "MKiCloudSync.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    UIViewController *rootViewController = nil;
    id appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate respondsToSelector:@selector(viewController)])
    {
        rootViewController = [appDelegate valueForKey:@"viewController"];
    }
    if (!rootViewController && [appDelegate respondsToSelector:@selector(window)])
    {
        UIWindow *window = [appDelegate valueForKey:@"window"];
        rootViewController = window.rootViewController;
    }
    if (!rootViewController)
    {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        rootViewController = window.rootViewController;
    }
    if (!rootViewController)
    {
        NSLog(@"couldn't find root view controller");
    }
    [[GCTurnBasedMatchHelper sharedInstance] authenticateLocalUserFromViewController:rootViewController];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults valueForKey:@"userP1Color"]) {
        [defaults setValue:@"Red" forKey:@"userP1Color"];
        [defaults setValue:@"Blue" forKey:@"userP2Color"];
        [defaults setValue:@"Yellow" forKey:@"userP3Color"];
        [defaults setValue:@"Purple" forKey:@"userP4Color"];
        
        [defaults setValue:@"White" forKey:@"userBoardColor"];
        [defaults setValue:@"Black" forKey:@"userLineColor"];
        [defaults setValue:@"Dark Gray" forKey:@"userViewColor"];
        [defaults synchronize];
    }
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"]]);
    
    [MKiCloudSync start];
    [Flurry startSession:@"9WVNK3DFCK3XB6MNZS6S"];
    [Flurry setSessionReportsOnCloseEnabled:YES];
    [Flurry setSessionReportsOnPauseEnabled:YES];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
