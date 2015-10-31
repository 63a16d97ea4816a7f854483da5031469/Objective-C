//
//  ViewController.m
//  SHA1_HMAC
//
//  Created by Cao Lei on 24/10/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import "ViewController.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"the encode str:%@",[self hmac:@"original string" withKey:@"key"]);
}


//SHA1-HMAC
-(NSString *)hmac:(NSString *)plaintext withKey:(NSString *)key
{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [plaintext cStringUsingEncoding:NSASCIIStringEncoding];
    
    uint8_t cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSString *Hash1 = @"";
    for (int i=0; i< CC_SHA1_DIGEST_LENGTH; i++)
    {
        Hash1 = [Hash1 stringByAppendingString:[NSString stringWithFormat:@"%02X", cHMAC[i]]];
    }
    return [Hash1 lowercaseString];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
