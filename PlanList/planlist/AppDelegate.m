//
//  AppDelegate.m
//  PlanList
//
//  Created by Cao Lei on 25/5/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "CLLockVC.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    MainViewController * mainController = [[MainViewController alloc]init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:mainController];
    self.window.rootViewController = _navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)saveData
{
    UINavigationController * navigationController = (UINavigationController *)self.window.rootViewController;
    MainViewController * controller = (MainViewController *)[navigationController.viewControllers objectAtIndex:0];
    [controller.data savePlanLists];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self saveData];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

    BOOL hasPwd = [CLLockVC hasPwd];
    
    if(hasPwd){
        /* To prevent the error:
            Unbalanced calls to begin/end appearance transitions for <UINavigationController: 0xa98e050>
            So add delay display below:
         */
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *   NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [CLLockVC showVerifyLockVCInVC:self.navigationController forgetPwdBlock:nil successBlock:^(CLLockVC *lockVC, NSString *pwd) {
                NSLog(@"密码正确");
                [lockVC dismiss:0.0f];
            }];
        });
  

    }else{
        /* To prevent the error:
            Unbalanced calls to begin/end appearance transitions for <UINavigationController: 0xa98e050>
            So add delay display below:
         */
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *   NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [CLLockVC showSettingLockVCInVC:self.navigationController successBlock:^(CLLockVC *lockVC, NSString *pwd) {
                NSLog(@"密码设置成功");
                [lockVC dismiss:0.0f];
            }];
        });

        
    }
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveData];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"didReceiveLocalNotification %@", notification);
}

@end
