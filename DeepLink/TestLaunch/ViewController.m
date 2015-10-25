//
//  ViewController.m
//  TestLaunch
//
//  Created by Cao Lei on 22/6/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import "ViewController.h"

#define BUNDLE_IDENTIFIER @"sg.com.mcdelivery.McDelivery"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getJsonFromAppleWebService{
    
    //  Create string of the URL
    NSString *serviceURL = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?bundleId=%@", BUNDLE_IDENTIFIER];

    NSURL *URL = [NSURL URLWithString:[serviceURL stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    
    //  Request the url and store the response into NSData
    NSData *data = [NSData dataWithContentsOfURL:URL];
    
    
    if (!data) {
        return nil;
    }
    
    //  Since I know the response will be 100% strings, convert the NSData to NSString
    NSString *response = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];

    //  Test response and return a string that an XML Parser can parse
    if (![response isEqualToString:@"UNAUTHORIZED"]) {
        return response;
    }
        return nil;
}


// Get the URL from Json returned from apple web service
-(NSString*)getAppInstallURLInStoreFromJson:(NSString*)passJson{
    
    if([passJson containsString:@"trackViewUrl"]&&passJson.length>25)
    {
        
        passJson = [passJson stringByReplacingOccurrencesOfString:@"{\"results\":[]}" withString:@""];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[passJson dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        
        if(dictionary!=nil)
            if(dictionary.allValues.count>0)
            {
                NSArray *array =[dictionary valueForKeyPath:@"results.trackViewUrl"];
                if(array){
                    return (NSString*)[array objectAtIndex:0];
                }
                
            }
    }
    return nil;
}

- (IBAction)LaunchButtonAction:(id)sender {
    
    NSString* AppInstallUrlInstore=[self getAppInstallURLInStoreFromJson:[self getJsonFromAppleWebService]];
    
    //this URL comes from the M4D App's "URL Schemes"
    NSString *customURL = @"mdssg://";
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:customURL]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:customURL]];
    }
    else
    {
        if(AppInstallUrlInstore!=nil){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:AppInstallUrlInstore]];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Sorry, the application failed to get the installation URL from Apple's web service!"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }
    }
}

@end
