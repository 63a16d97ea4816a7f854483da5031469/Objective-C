//
//  ViewController.m
//  GetInfoFromHtmlPageByAddress
//
//  Created by Cao Lei on 29/7/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//


/*
 This one is used to get the content(source code) of one specific web page. This is a testing: using web page's content to decide enable or disable a function in app.
 */
 

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
        [self getContentFromHttpPage];
    
    
    
}

- (NSString *)getContentFromHttpPage{
    
    //  Create string of the URL
    NSString *serviceURL = [NSString stringWithFormat:@"http://54.148.138.167/2016/thinfilms/boolean.html"];
    
    NSURL *URL = [NSURL URLWithString:[serviceURL stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    
    //  Request the url and store the response into NSData
    NSData *data = [NSData dataWithContentsOfURL:URL];
    
    
    if (!data) {
        return nil;
    }
    
    //  Since I know the response will be 100% strings, convert the NSData to NSString
    NSString *response = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    if([response isEqualToString:@"YES"])
    NSLog(@"the response is:%@",response);
    
    //  Test response and return a string that an XML Parser can parse
    if (![response isEqualToString:@"UNAUTHORIZED"]) {
        return response;
    }
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
