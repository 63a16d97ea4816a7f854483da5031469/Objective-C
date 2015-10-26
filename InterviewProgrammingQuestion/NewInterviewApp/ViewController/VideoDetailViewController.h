//
//  VideoDetailViewController.h
//  NewInterviewApp
//
//  Created by Cao Lei on 17/10/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//
#import "VideoEntity.h"
#import <UIKit/UIKit.h>

@interface VideoDetailViewController :UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UILabel *videoDescription;
@property (weak, nonatomic) VideoEntity *videoContent;
@end

