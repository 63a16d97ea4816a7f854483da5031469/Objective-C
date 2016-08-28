//
//  ViewController.m
//  FeedbackView
//
//  Created by hp on 05/11/13.
//  Copyright (c) 2013 Iftekhar. All rights reserved.
//

#import "ViewController.h"
#import "IQFeedbackView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendBugReportClicked:(id)sender
{
    IQFeedbackView *bugReport = [[IQFeedbackView alloc] initWithTitle:@"Bug Report" message:nil image:nil cancelButtonTitle:@"Cancel" doneButtonTitle:@"Send"];
    [bugReport setCanAddImage:YES];
    [bugReport setCanEditText:YES];
    
    [bugReport showInViewController:self completionHandler:^(BOOL isCancel, NSString *message, UIImage *image) {
        [bugReport dismiss];
    }];
}

- (IBAction)sendFeedbackClicked:(id)sender
{
    IQFeedbackView *feedback = [[IQFeedbackView alloc] initWithTitle:@"Feedback" message:nil image:nil cancelButtonTitle:@"Cancel" doneButtonTitle:@"Send"];
    [feedback setCanAddImage:NO];
    [feedback setCanEditText:YES];
    
    [feedback showInViewController:self completionHandler:^(BOOL isCancel, NSString *message, UIImage *image) {
        [feedback dismiss];
    }];
}
@end
