//
//  ViewController.m
//  Notification
//
//  Created by Cao Lei on 27/7/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIButton *mybutton;

@end

@implementation ViewController
int i=0;

//notification channel

- (void)setupLocalNotifications {
    
    //remove all the notifications created by this app
    //[[UIApplication sharedApplication] cancelAllLocalNotifications];
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    // current time plus 10 secs
    NSDate *now = [NSDate date];
    NSDate *dateToFire = [now dateByAddingTimeInterval:10];
    
    NSLog(@"now time: %@", now);
    NSLog(@"fire time: %@", dateToFire);
    
    localNotification.fireDate = dateToFire;
    NSString* myalertMessage=[NSString stringWithFormat:@"%@,%d",@"Time to go!",i];
    i++;
    localNotification.alertBody = myalertMessage;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    [UIApplication sharedApplication].applicationIconBadgeNumber++;
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber]+1;
    
    
    //Can use userInfo to save some Parameters
    NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Object 1", @"Key 1", @"Object 2", @"Key 2", nil];
    localNotification.userInfo = infoDict;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mybuttonAction:(id)sender {
    [self setupLocalNotifications];
}

@end
