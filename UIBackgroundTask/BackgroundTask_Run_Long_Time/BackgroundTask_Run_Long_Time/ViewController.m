//
//  ViewController.m
//  BackgroundTask_Run_Long_Time
//
//  Created by Lei Cao on 4/2/16.
//  Copyright © 2016 Lei Cao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self runlongTime];
}


-(void) runlongTime{
    UIApplication * application = [UIApplication sharedApplication];
    
    if([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)])
    {
        NSLog(@"Multitasking Supported");
        
        __block UIBackgroundTaskIdentifier background_task;
        background_task = [application beginBackgroundTaskWithExpirationHandler:^ {
            
            //Clean up code. Tell the system that we are done.
            //-- if do not put below code, apple will refuse the app.
            
            //            [application endBackgroundTask: background_task];
            //            background_task = UIBackgroundTaskInvalid;
        }];
        
        //To make the code block asynchronous
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            //### background task starts
            NSLog(@"Running in the background\n");
            //            while([[UIApplication sharedApplication] backgroundTimeRemaining]>10.0f)
            while(true)
            {
                NSLog(@"Background time Remaining: %f",[[UIApplication sharedApplication] backgroundTimeRemaining]);
                [NSThread sleepForTimeInterval:1]; //wait for 1 sec
            }
            //#### background task ends
            
            //Clean up code. Tell the system that we are done.
            //            [application endBackgroundTask: background_task];
            //            background_task = UIBackgroundTaskInvalid;
        });
    }
    else
    {
        NSLog(@"Multitasking Not Supported");
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
