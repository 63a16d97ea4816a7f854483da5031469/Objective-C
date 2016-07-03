//
//  ViewController.h
//  ImagePickerSample
//
//  Created by Lei Cao on 30/6/16.
//  Copyright © 2016 Lei Cao (Tony). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoImagePickerController.h"



@interface ViewController : UIViewController<DoImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

