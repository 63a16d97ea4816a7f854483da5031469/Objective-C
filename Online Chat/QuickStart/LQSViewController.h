//
//  ViewController.h
//  QuickStart
//
//  Created by Abir Majumdar on 12/3/14.
//  Copyright (c) 2014 Layer, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LayerKit/LayerKit.h>

@interface LQSViewController : UIViewController

@property (nonatomic) LYRClient *layerClient;

@property (nonatomic, weak) IBOutlet UIButton *sendButton;
@property (nonatomic, weak) IBOutlet UITextView *inputTextView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *typingIndicatorLabel;
@property (nonatomic, weak) IBOutlet UIImageView *messageImageView;

- (IBAction)clearButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)cameraButtonPressed:(UIButton *)sender;

@end
