//
//  APIHelper.m
//  NewInterviewApp
//
//  Created by Cao Lei on 17/10/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import "APIHelper.h"
#import "VideoEntity.h"
#import "AppConfigurationDataHolder.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>

@implementation APIHelper

+(NSMutableArray *) getContentSets{
    NSString* url=[self getRequestURL];
    NSString* json=[self getDataFrom:url];
   NSMutableArray *tmpContentSource=[[NSMutableArray alloc] init];
    
    if(json!=nil){
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        if(dictionary!=nil){
            if(dictionary.allValues.count>0)
            {
                NSArray *array =[dictionary valueForKeyPath:@"response"];
                for (int i=0;i<array.count;i++) {
                    VideoEntity *tmpEntity=[[VideoEntity alloc] init];
                    tmpEntity.titlesWithMultiLanguages=[(NSDictionary *)array[i] objectForKey:@"titles"];
                    tmpEntity.descriptionWithMultiLanguages=[(NSDictionary *)array[i] objectForKey:@"descriptions"];
                    tmpEntity.videoImageURL=[(NSDictionary *)array[i] valueForKeyPath:@"images.poster.url"];
                    [tmpContentSource addObject:tmpEntity];
                }
            }
            
        }
        
    }
    return tmpContentSource;
}

+ (NSString *)getRequestURL{
    AppConfigurationDataHolder *configHolder=[AppConfigurationDataHolder Instance];
    int timestamp = [[NSDate date] timeIntervalSince1970];
    NSString *serviceURL=[NSString stringWithFormat:@"%@&app=%@&t=%d",configHolder.requestURLHeader,configHolder.appID,timestamp];
    serviceURL=[self hmac:serviceURL withKey:configHolder.appPASS];
    
    NSString *requestURL=[NSString stringWithFormat:@"http://%@%@&app=%@&t=%d&sig=%@",configHolder.apiEndPoint,configHolder.requestURLHeader,configHolder.appID,timestamp,serviceURL];
    NSLog(@"the serviceURL:%@",requestURL);
    
    return requestURL;
}

+ (NSString *) getDataFrom:(NSString *)url{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error: %@, Error code %i", url, [error code]);
        NSString *errorMessage=[NSString stringWithFormat:@"%@ Error Code:%d",@"Failed to communicate with the server!",[error code]];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:errorMessage
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

+(NSString *)hmac:(NSString *)plaintext withKey:(NSString *)key
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

@end