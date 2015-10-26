//
//  DataModel.h
//  PlanList
//
//  Created by Cao Lei on 25/5/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject
@property(nonatomic, strong) NSMutableArray * lists;

- (void)savePlanLists;
- (int)indexOfSelectedPlanlist;
- (void)setIndexOfSelectedPlanlist:(int)index;
+ (int)nextPlanlistItemID;
@end
