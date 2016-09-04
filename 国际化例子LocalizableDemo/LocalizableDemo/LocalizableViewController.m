//
//  LocalizableViewController.m
//  LocalizableDemo
//
//  Created by Jordan Cao on 12-9-26.
//  Copyright (c) 2012年 AirView.com. All rights reserved.
//

#import "LocalizableViewController.h"

@interface LocalizableViewController ()

@end

@implementation LocalizableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    bgview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgview];
    lb1 = [[UILabel alloc] init];
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    lb1.text = NSLocalizedString(@"demo", @"lb1 name");
    lb1.frame = CGRectMake(20, 20, 200, 30);
    [button setTitle:NSLocalizedString(@"enter", @"button name") forState:UIControlStateNormal]; 
    button.frame = CGRectMake(20, 60, 100, 30);
    [bgview addSubview:lb1];
    [bgview addSubview:button];
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
