//
//  SecondViewController.h
//  SSocial
//
//  Created by Cao Lei on 16/8/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *profileTableView;
@property (weak, nonatomic) IBOutlet UILabel *profileHeaderLabel;
@end

