//
//  AppDelegate.m
//  ATAppUpdater
//
//  Created by Jean-Pierre Fourie on 2015/09/14.
//  Copyright © 2015 Apptality. All rights reserved.
//

#import "AppDelegate.h"
#import "ATAppUpdater.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Change to your bundle identifier and increase the bundle version number to test.
    
    BOOL showCutomAlert = false;
    
    if (showCutomAlert) {
        // Custom alert
        ATAppUpdater *updater = [ATAppUpdater sharedUpdater];
        [updater setAlertTitle:NSLocalizedString(@"Nuwe Weergawe", @"Alert Title")];
        [updater setAlertMessage:NSLocalizedString(@"Weergawe %@ is beskikbaar op die AppStore.", @"Alert Message")];
        [updater setAlertUpdateButtonTitle:@"Opgradeer"];
        [updater setAlertCancelButtonTitle:@"Nie nou nie"];
        [updater showUpdateWithConfirmation];
    } else {
        // One line of code
//        [[ATAppUpdater sharedUpdater] showUpdateWithConfirmation]; // OR [[ATAppUpdater sharedUpdater] showUpdateWithForce];
        [[ATAppUpdater sharedUpdater] showUpdateWithForce];
    }
 
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
