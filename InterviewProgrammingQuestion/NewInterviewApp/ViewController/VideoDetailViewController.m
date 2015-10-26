//
//  VideoDetailViewController.m
//  NewInterviewApp
//
//  Created by Cao Lei on 17/10/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//
#import "VideoDetailViewController.h"
#import "ImageHelper.h"
#import "LocalHelper.h"

@interface VideoDetailViewController ()

@end

@implementation VideoDetailViewController
@synthesize videoContent;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(videoContent!=nil){
    self.title=[LocalHelper getLocalLanguageForKey:videoContent Key:@"title"];
    self.videoDescription.text=[LocalHelper getLocalLanguageForKey:videoContent Key:@"description"];
    
    self.detailImageView.alpha =0.0;
    
    [ImageHelper setImage:self.detailImageView withUrl:videoContent.videoImageURL];
    
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:0.5];
    self.detailImageView.alpha =1.0;
    [UIView commitAnimations];
    }
}





@end