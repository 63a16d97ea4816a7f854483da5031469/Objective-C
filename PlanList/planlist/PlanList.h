//
//  PlanList.h
//  PlanList
//
//  Created by Cao Lei on 25/5/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlanList : NSObject<NSCoding>
@property(nonatomic, copy) NSString * listTitle;
@property(nonatomic, copy) NSString * listIconName;
@property(nonatomic, strong) NSMutableArray * items;
@end
