//
//  DataModel.m
//  PlanList
//
//  Created by Cao Lei on 25/5/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import "DataModel.h"
#import "PlanList.h"

@implementation DataModel

- (id)init
{
    if (self = [super init]) {
        [self loadPlanLists];
        [self registerDefaults];
        [self handleFirstTime];
    }
    return self;
}

- (NSString *)documentDirectory
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    
    return documentsDirectory;
}

- (NSString *)dataFilePath
{
    return [[self documentDirectory] stringByAppendingPathComponent:@"planlist.plist"];
}

- (void)savePlanLists
{
    NSMutableData * data = [[NSMutableData alloc]init];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:self.lists forKey:@"Planlists"];
    [archiver finishEncoding];
    
    [data writeToFile:[self dataFilePath] atomically:YES];
}

- (void)loadPlanLists
{
    NSString * path = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData * data = [[NSData alloc]initWithContentsOfFile:path];
        NSKeyedUnarchiver * unArchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        self.lists = [unArchiver decodeObjectForKey:@"Planlists"];
        [unArchiver finishDecoding];
    } else {
        self.lists = [[NSMutableArray alloc]initWithCapacity:20];
    }
    NSLog(@"index:%d", [self indexOfSelectedPlanlist]);
}

- (void)registerDefaults
{
    NSDictionary * dictionary = @{@"planlistIndex": @-1,
                                  @"FirstTime" : @YES,
                                  @"planlistItemID" : @0};
    [[NSUserDefaults standardUserDefaults]registerDefaults:dictionary];
}

- (void)handleFirstTime
{
    BOOL firstTime = [[NSUserDefaults standardUserDefaults]boolForKey:@"FirstTime"];
    if (firstTime) {
        PlanList * planList = [[PlanList alloc]init];
        planList.listTitle = @"List";
        [self.lists addObject:planList];
        [self setIndexOfSelectedPlanlist:0];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"FirstTime"];
    }
}

- (int)indexOfSelectedPlanlist
{
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"planlistIndex"];
}

- (void)setIndexOfSelectedPlanlist:(int)index
{
    [[NSUserDefaults standardUserDefaults]setInteger: index forKey:@"planlistIndex"];
}

+ (int)nextPlanlistItemID
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    int itemID = (int)[userDefaults integerForKey:@"planlistItemID"];
    [userDefaults setInteger:itemID + 1 forKey:@"planlistItemID"];
    [userDefaults synchronize];
    return itemID;
}

@end
