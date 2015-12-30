//
//  DirectoryListingFeed.h
//  JsonObjectMapping
//
//  Created by Lei Cao on 30/12/15.
//  Copyright © 2015 Lei Cao. All rights reserved.
//

#import "JSONModel.h"
#import "DataModel.h"

@interface DirectoryListingFeed : JSONModel

@property (strong, nonatomic) NSArray<DataModel, ConvertOnDemand>* data;

@end