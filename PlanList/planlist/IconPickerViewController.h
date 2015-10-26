//
//  IconPickerViewController.h
//  PlanList
//
//  Created by Cao Lei on 25/5/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IconPickerViewController;

@protocol IconPickerViewControllerDelegate <NSObject>

- (void)IconPickerViewController:(IconPickerViewController *)controller DidFinishPickIcon:(NSString *)iconName;

@end

@interface IconPickerViewController : UITableViewController
@property(nonatomic, assign) id<IconPickerViewControllerDelegate> delegate;
@end
