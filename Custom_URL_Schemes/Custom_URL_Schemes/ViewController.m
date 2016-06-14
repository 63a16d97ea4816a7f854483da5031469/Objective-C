//
//  ViewController.m
//  Custom_URL_Schemes
//
//  Created by Lei Cao on 14/6/16.
//  Copyright © 2016 Lei Cao (Tony). All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressBtn:(id)sender {
    
    //myappscheme ===> test
    
    //http://www.idev101.com/code/Objective-C/custom_url_schemes.html
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"myappscheme://test/one?token=12345&domain=foo.com"]];
}

@end
