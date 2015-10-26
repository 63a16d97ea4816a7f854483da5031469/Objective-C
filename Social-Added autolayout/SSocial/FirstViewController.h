//
//  FirstViewController.h
//  SSocial
//
//  Created by Cao Lei on 16/8/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *listtableview;
@property (weak, nonatomic) IBOutlet UILabel *headerBackgroundLabel;


@end

