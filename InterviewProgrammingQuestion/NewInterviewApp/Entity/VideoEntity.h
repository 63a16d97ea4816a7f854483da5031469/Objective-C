//
//  ViewController.h
//  NewInterviewApp
//
//  Created by Cao Lei on 16/10/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoEntity : NSObject

@property (nonatomic,strong) NSDictionary* titlesWithMultiLanguages;
@property (nonatomic,strong) NSDictionary* descriptionWithMultiLanguages;
@property (nonatomic,strong) NSString* videoImageURL;

@end

