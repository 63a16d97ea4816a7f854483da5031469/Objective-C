//
//  Slider.h
//  DAP_clock
//
//  Created by Cao Lei on 22/7/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.

// I reused some code from other library in this file.

#import <UIKit/UIKit.h>

@interface Slider : UIControl

typedef enum : NSUInteger {
    semiTransparentWhiteCircle,
    semiTransparentBlackCircle,
    doubleCircleWithOpenCenter,
    doubleCircleWithClosedCenter,
    bigCircle
} HandleType;

@property (nonatomic) float minimumValue;
@property (nonatomic) float maximumValue;
@property (nonatomic) float currentValue;

@property (nonatomic) int lineWidth;
@property (nonatomic, strong) UIColor* filledColor;
@property (nonatomic, strong) UIColor* unfilledColor;

@property (nonatomic, strong) UIColor* handleColor;
@property (nonatomic) HandleType handleType;

@property (nonatomic, strong) UIFont* labelFont;
@property (nonatomic, strong) UIColor* labelColor;
@property (nonatomic) BOOL snapToLabels;
@property (nonatomic) BOOL isShowTimeLabel;


-(void)setInnerMarkingLabels:(NSArray*)labels;


@end
