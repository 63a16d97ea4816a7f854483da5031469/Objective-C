//
//  CustomTableViewCell.h
//  NewInterviewApp
//
//  Created by Cao Lei on 16/10/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface CustomTableViewCell:UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
