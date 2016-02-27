//
//  ViewController.m
//  AskForLocationService
//
//  Created by Lei Cao on 27/2/16.
//  Copyright © 2016 Lei Cao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    _locationManager =[[CLLocationManager alloc]init];
    
    // Use either one of these authorizations **The top one gets called first and the other gets ignored
    [self.locationManager requestWhenInUseAuthorization];
    //[self.locationManager requestAlwaysAuthorization];
    
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
