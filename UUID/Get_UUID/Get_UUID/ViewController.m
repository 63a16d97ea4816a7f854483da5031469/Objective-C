//
//  ViewController.m
//  Get_UUID
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
    
        NSLog(@"%@",[[[UIDevice currentDevice] identifierForVendor] UUIDString]);
    
        NSUUID *tempUUID = [[UIDevice currentDevice] identifierForVendor];
        NSString *stringForUDID =  [tempUUID UUIDString];
        NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"] invertedSet];
        NSString *resultString = [[stringForUDID componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
        NSLog(@"Final string %@", resultString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
