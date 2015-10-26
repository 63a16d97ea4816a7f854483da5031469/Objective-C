//
//  MainViewController.h
//  PlanList
//
//  Created by Cao Lei on 25/5/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

@interface MainViewController : UIViewController

@property(nonatomic, strong) DataModel * data;
@end
 

@interface MainViewControllerTableCell : UITableViewCell
@property(nonatomic, assign) BOOL isLineBreak;
@property(nonatomic, strong) UIImageView * lineImage;
@end