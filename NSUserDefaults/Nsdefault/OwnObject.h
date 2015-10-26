//
//  OwnObject.h
//  Nsdefault
//
//  Created by Cao Lei on 25/10/15.
//  Copyright © 2015 Cao Lei. All rights reserved.
//

/*
    This object need to implement the protocol NSCoding
 */

@interface OwnObject : NSObject<NSCoding>

/*
 If we use below code:
 @property(nonatomic,weak) NSString *name;
 @property(nonatomic,weak) NSString *gender;
 @property(nonatomic,weak) NSNumber *number;
 
 You can only get the nil for NSString. You still can get the NSNumber.
 */

@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *gender;
@property(nonatomic,strong) NSNumber *number;

@end