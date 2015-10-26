//
//  LocalHelper.m
//  NewInterviewApp
//
//  Created by Cao Lei on 17/10/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//
#import "VideoEntity.h"
#import "LocalHelper.h"
#import "AppConfigurationDataHolder.h"

@implementation LocalHelper

+(NSString*) getLocalLanguageForKey:(VideoEntity*)videoEntity Key:(NSString*) key{
    NSString *tmp=@"";
    NSDictionary *tmpDic;
    
    AppConfigurationDataHolder *appconfigHolder=[AppConfigurationDataHolder Instance];

    if([key isEqualToString:@"title"]){
        tmp=[videoEntity.titlesWithMultiLanguages objectForKey:appconfigHolder.defaultLanguage];
        tmpDic=videoEntity.titlesWithMultiLanguages;
    }else if([key isEqualToString:@"description"]){
        tmp=[videoEntity.descriptionWithMultiLanguages objectForKey:appconfigHolder.defaultLanguage];

        tmpDic=videoEntity.descriptionWithMultiLanguages;
    }
    //If cannot get the default_language, we will use any non-empty one.
    if(tmp == nil){
        __block NSString* outsideStr=@"";
        [tmpDic enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
            if(![object isEqualToString:@""]) {
                outsideStr=object;
                *stop = YES;    // Stop
            }
        }];
        tmp=outsideStr;
    }
    return tmp;
}

@end