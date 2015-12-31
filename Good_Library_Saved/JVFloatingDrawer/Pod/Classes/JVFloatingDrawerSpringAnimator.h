//
//  JVFloatingDrawerAnimator.h
//  JVFloatingDrawer
//
//  Created by Julian Villella on 2015-01-11.
//  Copyright (c) 2015 JVillella. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "JVFloatingDrawerAnimation.h"

@interface JVFloatingDrawerSpringAnimator : NSObject <JVFloatingDrawerAnimation>

@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, assign) NSTimeInterval animationDelay;
@property (nonatomic, assign) CGFloat springDamping;
@property (nonatomic, assign) CGFloat initialSpringVelocity;

@end
// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net