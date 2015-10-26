//
//  AppConfigurationDataHolder.m
//  NewInterviewApp
//
//  Created by Cao Lei on 17/10/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import "AppConfigurationDataHolder.h"


@implementation AppConfigurationDataHolder
static AppConfigurationDataHolder *instance;

@synthesize appID;
@synthesize appPASS;
@synthesize apiEndPoint;
@synthesize requestURLHeader;
@synthesize defaultLanguage;

+(AppConfigurationDataHolder*) Instance {
    if (!instance) {
        instance = [[AppConfigurationDataHolder alloc] init];
    }
    
    return instance;
}

- (id)init {
    if (self = [super init]) {
    appID=[[NSBundle mainBundle] objectForInfoDictionaryKey:@"APP_ID"];
    appPASS=[[NSBundle mainBundle] objectForInfoDictionaryKey:@"APP_PASS"];
    defaultLanguage=[[NSBundle mainBundle] objectForInfoDictionaryKey:@"DEFAULT_LANGUAGE"];
    apiEndPoint=[[NSBundle mainBundle] objectForInfoDictionaryKey:@"API_END_POINT"];
    requestURLHeader=[[NSBundle mainBundle] objectForInfoDictionaryKey:@"REQUEST_URL_HEADER"];
    }
    return self;
}

@end