//
//  AppConfigurationDataHolder.h
//  NewInterviewApp
//
//  Created by Cao Lei on 17/10/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppConfigurationDataHolder : NSObject

+(AppConfigurationDataHolder*) Instance;
@property (nonatomic, strong) NSString *appID;
@property (nonatomic, strong) NSString *appPASS;
@property (nonatomic, strong) NSString *apiEndPoint;
@property (nonatomic, strong) NSString *requestURLHeader;
@property (nonatomic, strong) NSString *defaultLanguage;

@end
