//
//  ViewController.h
//  NewInterviewApp
//
//  Created by Cao Lei on 16/10/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoListViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *videoTableView;
@property (strong,nonatomic) NSArray *contentSource;

@end

