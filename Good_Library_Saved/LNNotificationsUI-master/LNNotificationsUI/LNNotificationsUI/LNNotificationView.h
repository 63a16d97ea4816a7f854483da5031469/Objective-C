//
//  LNNotificationView.h
//  LNNotificationsUI
//
//  Created by Leo Natan on 9/5/14.
//  Copyright (c) 2014 Leo Natan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LNNotification;

@interface LNNotificationView : UIView

@property (nonatomic, strong, readonly) UIVisualEffectView* backgroundView;
@property (nonatomic, strong, readonly) UIView* notificationContentView;

- (void)configureForNotification:(LNNotification*)notification;

@property (nonatomic, strong, readonly) LNNotification* currentNotification;

@end

// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net
