//
//  ViewController.m
//  IOS_XSS_Detection
//
//  Created by Cao Lei on 23/10/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Whether contain XSS Attack:%d",[self containsXssSequence:@"onkeypress="]);
}


- (BOOL)containsXssSequence:(NSString *)mString
{
    if ([self stringIsNilOrEmpty:mString])
        return NO;
    
    NSString* validationStr = [mString stringByReplacingOccurrencesOfString:@"\\s{2,}" withString:@" "];
    
    NSArray* xssStrSets = [[NSArray alloc] initWithObjects:@"--", @"\"-", @"-\"", @"/*", @"//", @"</", @"http:", @"https:", @"onload=", @"onclick=", @"onkeyup=", @"onkeydown=", @"onkeypress=", @"onfocus=", @"script", @"alert(", @"confirm(", @"prompt(", @"console", @"cdata", @"' or '", @"' and '", @"'='", @"' = '", nil];
    
    NSRange strFound;
    for (NSString* str in xssStrSets) {
        strFound = [validationStr rangeOfString:str options:NSCaseInsensitiveSearch];
        if (strFound.location != NSNotFound) {
            NSLog(@"XSS sequence spotted: %@ in text :%@", str, mString);
            return YES;
        }
    }
    
    // Decoding the text to make that no XSS sequence is hidden in URL encoded text
    if ([validationStr hasSuffix:@"%"]) {
        NSLog(@"Text could not be decode because ending with %%: %@", validationStr);
        return NO;
    }
    NSLog(@"the validation Text:%@",validationStr);
    NSLog(@"the second str:%s",[validationStr cStringUsingEncoding:NSISOLatin1StringEncoding]);
    if ([validationStr length] > 8) { // no need to decode the small texts
        
        NSString* decodedStr=@"";
        @try {
            NSString *currentDecodedString = [validationStr
                                              stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if(currentDecodedString!=nil){
                decodedStr=currentDecodedString;
            }else{
                decodedStr=@"";
            }
        }
        @catch (NSException *exception) {
            decodedStr=@"";
        }
        @finally {
            
        }
        
        NSRange decodedStrFound;
        for (NSString* str in xssStrSets) {
            decodedStrFound = [decodedStr rangeOfString:str options:NSCaseInsensitiveSearch];
            if (decodedStrFound.location != NSNotFound) {
                NSLog(@"XSS sequence spotted :%@ in encoded text: %@", str, decodedStr);
                return YES;
            }
        }
    }
    
    return NO;
}

- (BOOL) stringIsNilOrEmpty:(NSString*) input {
    if (input != nil && [input length] > 0) {
        return NO;
    }
    else {
        return YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
