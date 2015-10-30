//
//  CustomCollectionCell.m
//  CollectionView-Practice
//
//  Created by Cao Lei on 21/10/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomCollectionCell.h"
#import "CustomCellBackground.h"

@implementation CustomCollectionCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // change to our custom selected background view
        CustomCellBackground *backgroundView = [[CustomCellBackground alloc] initWithFrame:CGRectZero];
        self.selectedBackgroundView = backgroundView;
    }
    return self;
}


@end
