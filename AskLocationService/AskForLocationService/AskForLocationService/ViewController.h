//
//  ViewController.h
//  AskForLocationService
//
//  Created by Lei Cao on 27/2/16.
//  Copyright © 2016 Lei Cao. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate>

@property(nonatomic)CLLocationManager *locationManager;

@end

