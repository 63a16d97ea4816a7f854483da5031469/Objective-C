//
//  MessageObject.h
//  planlist
//
//  Created by Cao Lei on 25/5/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageObject : NSObject
@property(nonatomic, copy) NSString * messageTitle;
@property(nonatomic, copy) NSString * messageContent;

- (id)init:(NSString*)passTitle Content:(NSString*)passContent;
@end
