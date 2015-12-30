//
//  KivaFeed.h
//  JsonObjectMapping
//
//  Created by Lei Cao on 30/12/15.
//  Copyright © 2015 Lei Cao. All rights reserved.
//


#import "JSONModel.h"
#import "LoanModel.h"

@interface KivaFeed : JSONModel

@property (strong, nonatomic) NSArray<LoanModel, ConvertOnDemand>* loans;

@end