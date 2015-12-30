//
//  DataModel.h
//  JsonObjectMapping
//
//  Created by Lei Cao on 30/12/15.
//  Copyright © 2015 Lei Cao. All rights reserved.
//

#import "JSONModel.h"


@protocol DataModel @end

@interface DataModel : JSONModel

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSString* company;


@end