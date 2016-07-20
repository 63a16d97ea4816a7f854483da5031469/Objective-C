//
//  ViewController.m
//  CodeViewPop
//
//  Created by Lei Cao on 3/7/16.
//  Copyright © 2016 Lei Cao (Tony). All rights reserved.
//

#import "ViewController.h"
#import "PopUpCodeViewController.h"


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (IBAction)pressBtn:(id)sender {
    PopUpCodeViewController *viewController=[PopUpCodeViewController new];
    
    [self presentViewController:viewController animated:YES completion:nil];
}

@end
