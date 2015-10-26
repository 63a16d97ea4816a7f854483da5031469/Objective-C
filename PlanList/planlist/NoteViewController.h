//
//  NoteViewController.h
//  PlanList
//
//  Created by Cao Lei on 25/5/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
@interface NoteViewController :UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *noteTableview;


@end