//
//  ItemsOfPlanListViewController.h
//  PlanList
//
//  Created by Cao Lei on 25/5/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlanList;
@class ListsOfPlanListViewController;

@protocol ListsOfPlanListViewControllerDelegate <NSObject>

- (void)ListsOfPlanListController:(ListsOfPlanListViewController *)controller didFinishAddPlanList:(PlanList *)list;

- (void)ListsOfPlanListController:(ListsOfPlanListViewController *)controller didFinishEditPlanList:(PlanList *)list;

- (void)ListsOfPlanListControllerDidCancel:(ListsOfPlanListViewController *)controller;

@end

@interface ListsOfPlanListViewController : UITableViewController
@property(nonatomic, strong) PlanList * list;
@property(nonatomic, assign) id<ListsOfPlanListViewControllerDelegate> delegate;
@end
