//
//  PlanList.m
//  PlanList
//
//  Created by Cao Lei on 25/5/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import "PlanList.h"

@implementation PlanList

- (id)init
{
    if (self = [super init]) {
        self.listTitle = @"";
        self.listIconName = @"NO Icon";
        self.items = [NSMutableArray array];

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.listIconName = [aDecoder decodeObjectForKey:@"iconName"];
        self.listTitle = [aDecoder decodeObjectForKey:@"title"];
        self.items = [aDecoder decodeObjectForKey:@"items"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_listTitle forKey:@"title"];
    [aCoder encodeObject:_listIconName forKey:@"iconName"];
    [aCoder encodeObject:_items forKey:@"items"];
}

@end
