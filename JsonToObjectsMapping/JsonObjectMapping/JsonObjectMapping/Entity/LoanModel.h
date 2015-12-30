//
//  LoanModel.h
//  JsonObjectMapping
//
//  Created by Lei Cao on 30/12/15.
//  Copyright © 2015 Lei Cao. All rights reserved.
//

#import "JSONModel.h"


@protocol LoanModel @end

@interface LoanModel : JSONModel

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* status;
@property (strong, nonatomic) NSString* use;
@property (strong, nonatomic) NSString* sector;

//@property (strong, nonatomic) LocationModel* location;

@end