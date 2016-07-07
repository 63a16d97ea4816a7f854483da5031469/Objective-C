//
//  ViewController.m
//  EditableLabel
//
//  Created by Lei Cao on 7/7/16.
//  Copyright © 2016 Lei Cao (Tony). All rights reserved.
//

#import "ViewController.h"
#import "RFTapEditLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    RFTapEditLabel *tapLabel = [[RFTapEditLabel alloc] initWithFrame:CGRectMake(20, 100, 180, 31) title:@"Please input the room number:"  secureTextEntry:NO];

    tapLabel.text=@"12131";
    [self.view addSubview:tapLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
