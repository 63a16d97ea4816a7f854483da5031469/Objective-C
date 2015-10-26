//
//  OwnObject.m
//  Nsdefault
//
//  Created by Cao Lei on 25/10/15.
//  Copyright © 2015 Cao Lei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OwnObject.h"

@implementation OwnObject


/*
 This object need to implement the protocol NSCoding
 */

-(void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.number forKey:@"number"];
}


-(id) initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init]){
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.gender=[aDecoder decodeObjectForKey:@"gender"];
        self.number=[aDecoder decodeObjectForKey:@"number"];
    }
    return self;
}


@end
