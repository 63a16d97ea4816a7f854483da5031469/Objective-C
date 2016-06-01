//
//  ViewController.h
//  GoogleDrive
//
//  Created by Lei Cao on 31/5/16.
//  Copyright © 2016 Lei Cao (Tony). All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GTMOAuth2ViewControllerTouch.h"
#import "GTLDrive.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) GTLServiceDrive *service;
@property (nonatomic,strong) GTLDriveFile *file;
@property (nonatomic, strong) UITextView *output;

@end

