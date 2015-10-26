//
//  ViewController.m
//  Nsdefault
//
//  Created by Cao Lei on 24/10/15.
//  Copyright © 2015 Cao Lei. All rights reserved.
//


/*
 ##Warnning:
 * First of all it should only be used for very small amounts of data, such as settings.
 * And secondly it always returns immutable objects, even if you set mutable ones. Making a mutable copy of your first array doesn’t help because only the array will be mutable. Everything that is inside that array isn’t touched by the mutableCopy method and stay immutable.
 
 * if you have to save so much data, you should use the NSPropertyListSerialization class to read and write your data from a file. On reading you can pass options controlling the mutability of the read objects. There you will want to pass NSPropertyListMutableContainers or NSPropertyListMutableContainersAndLeaves.
 *
 */

#import "ViewController.h"
#import "OwnObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addOwnDefinedObjectIntoNSDefault];
    [self saveDefault];
    [self loadDefault];
    [self loadSavedOwnDefinedObjectFromNSDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void) loadDefault
{
    //Read values from specific plist-begin:
    NSURL *defaultPrefsFile = [[NSBundle mainBundle] URLForResource:@"DefaultPreferences" withExtension:@"plist"];
    NSDictionary *defaultPrefs = [NSDictionary dictionaryWithContentsOfURL:defaultPrefsFile];
    //Read values from specific plist-end
    
    //Read from NSUserDefaults:
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults registerDefaults:defaultPrefs];
    
    NSLog(@"the value from DefaultPreferences.plist :%@",[defaultPrefs objectForKey:@"sensitivitySettings"]);
    NSLog(@"the value from DefaultPreferences.plist:%@",[defaultPrefs objectForKey:@"sensitivities"]);
    
    NSLog(@"the value from NSUserDefaults:%@",[defaults objectForKey:@"controlMode"]);
    NSLog(@"the value from NSUserDefaults-sensitivities:%@",[defaults objectForKey:@"sensitivities"]);
    
    NSLog(@"all the keys in NSUserDefaults: %@", [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys]);
    
    
    NSLog(@"Begin to print all the keys and values in NSUserDefaults:");
    [self printAllUserDefaults];

}


-(void)addOwnDefinedObjectIntoNSDefault{
    OwnObject *ownObj=[[OwnObject alloc] init];
    ownObj.name=@"myname";
    ownObj.gender=@"male";
    ownObj.number=[NSNumber numberWithInt:1];

    NSData *ownObjData=[NSKeyedArchiver archivedDataWithRootObject:ownObj];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setObject:ownObjData forKey:@"OwnDefinedObject"];
}

- (void) printAllUserDefaults
{
    NSArray *keys = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys];
    NSArray *values = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allValues];
    for (int i = 0; i < keys.count; i++) {
        NSLog(@"%@: %@", [keys objectAtIndex:i], [values objectAtIndex:i]);
    }
}


-(void)loadSavedOwnDefinedObjectFromNSDefault{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSData *ownDefinedObjdata=[userDefaults objectForKey:@"OwnDefinedObject"];
    OwnObject *ownObj=[NSKeyedUnarchiver unarchiveObjectWithData:ownDefinedObjdata];
    
    NSLog(@"the ownObjec's name,gender,number:%@, %@, %@",ownObj.name,ownObj.gender,[NSString stringWithFormat:@"%d",[ownObj.number intValue]]);
}


- (void) saveDefault
{
    NSMutableDictionary *sensitivities=[[NSMutableDictionary alloc] init];
    [sensitivities setObject:@"the first value" forKey:@"first"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[NSNumber numberWithInt:100] forKey:@"controlMode"];
    [defaults setObject:sensitivities forKey:@"sensitivities"];
}

@end
