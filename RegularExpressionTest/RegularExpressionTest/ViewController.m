//
//  ViewController.m
//  RegularExpressionTest
//
//  Created by Cao Lei on 26/10/15.
//  Copyright © 2015 Cao Lei. All rights reserved.
//


/*
 This is a test program to test Regular Expression
 
 ^([1-9][0-9]*)$     the first number should be 0
 
 ^(0[0-9]*)$      the first number must be 0
 
 */

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self triggerRegularExpression:@"10"];

    
    // Do any additional setup after loading the view, typically from a nib.
}

-(BOOL)triggerRegularExpression:(NSString*) regularStr{
    NSString* phoneNoValidPattern=@"^(0[0-9]*)$";

    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:phoneNoValidPattern options:0 error:NULL];
    NSTextCheckingResult *match = [regex firstMatchInString:regularStr
                                                    options:0
                                                      range:NSMakeRange(0, [regularStr length])];
    if (!match) {
        NSLog(@"NO");
        return NO;
    } else {
        NSLog(@"YES");
        return YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
