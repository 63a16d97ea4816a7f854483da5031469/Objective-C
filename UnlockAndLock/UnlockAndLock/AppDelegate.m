//
//  AppDelegate.m
//  UnlockAndLock
//
//  Created by Lei Cao on 10/2/16.
//  Copyright © 2016 Lei Cao. All rights reserved.
//

#import "AppDelegate.h"
#import "notify.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#define NotifName_LockComplete @"com.apple.springboard.lockcomplete"
#define NotifName_LockState    @"com.apple.springboard.lockstate"
BOOL flag=NO;


void setupLocalNotifications(NSString* str) {
    
    //remove all the notifications created by this app
    //[[UIApplication sharedApplication] cancelAllLocalNotifications];
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    NSDate *now = [NSDate date];
    
    localNotification.fireDate = now;
    NSString* myalertMessage=[NSString stringWithFormat:@"%@",str];
    
    localNotification.alertBody = myalertMessage;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    [UIApplication sharedApplication].applicationIconBadgeNumber++;
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber]+1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

//call back
void lockStatusChanged(CFNotificationCenterRef center, void *observer, CFStringRef name_cf, const void *object, CFDictionaryRef userInfo){
    
    
    NSString *name = (__bridge NSString*)name_cf;
    if ([name isEqualToString:NotifName_LockComplete]) {
        NSLog(@"DEVICE LOCKED");
        flag=YES;
        setupLocalNotifications(@"DEVICE LOCKED!");
    } else if ([name isEqualToString:NotifName_LockState]) {
        if(!flag){
            NSLog(@"DEVICE UNLOCKED");
            setupLocalNotifications(@"DEVICE UNLOCKED!");
        }
        flag=NO;
    }
}


- (void)registerforDeviceLockNotif {
    //Screen lock notifications
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                    NULL,
                                    lockStatusChanged,
                                    (__bridge CFStringRef)NotifName_LockComplete,
                                    NULL,
                                    CFNotificationSuspensionBehaviorDeliverImmediately);
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                    NULL,
                                    lockStatusChanged,
                                    (__bridge CFStringRef)NotifName_LockState,
                                    NULL,
                                    CFNotificationSuspensionBehaviorDeliverImmediately);
}

//added new method:
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [self showAlarm:notification.alertBody];
    //    NSLog(@"the str is:%@",[notification.userInfo objectForKey:@"Key 1"]);
    //    [self showAlarm:[notification.userInfo objectForKey:@"Key 1"]];
    application.applicationIconBadgeNumber = 0;
    NSLog(@"AppDelegate didReceiveLocalNotification %@", notification.userInfo);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self registerforDeviceLockNotif];
    
    [launchOptions valueForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
    {
        
        [application registerUserNotificationSettings:[UIUserNotificationSettings
                                                       settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|
                                                       UIUserNotificationTypeSound categories:nil]];
    }
    
    
    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if (notification) {
        [self showAlarm:[notification.userInfo objectForKey:@"Key 1"]];
        NSLog(@"AppDelegate didFinishLaunchingWithOptions");
        application.applicationIconBadgeNumber = 0;
    }
    
    
    
    return YES;
}

- (void)showAlarm:(NSString *)text {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alarm"
                                                        message:text delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}




- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
