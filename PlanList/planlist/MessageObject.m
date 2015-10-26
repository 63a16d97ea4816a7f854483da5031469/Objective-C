//
//  MessageObject.m
//  planlist
//
//  Created by Cao Lei on 25/5/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import "MessageObject.h"

@implementation MessageObject

- (id)init
{
    if (self = [super init]) {
        self.messageTitle=@"";
        self.messageContent=@"";
    }
    return self;
}

- (id)init:(NSString*)passTitle Content:(NSString*)passContent{

    if (self = [super init]) {
            self.messageTitle=passTitle;
            self.messageContent=passContent;
    }
    return self;
}

@end