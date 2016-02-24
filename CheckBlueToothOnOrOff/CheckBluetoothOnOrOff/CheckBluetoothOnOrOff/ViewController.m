//
//  ViewController.m
//  CheckBluetoothOnOrOff
//
//  Created by Lei Cao on 24/2/16.
//  Copyright © 2016 Lei Cao. All rights reserved.
//
@import CoreBluetooth;
#import "ViewController.h"


@interface ViewController () <CBCentralManagerDelegate>

@end

@implementation ViewController
CBCentralManager *_bluetoothManager;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     _bluetoothManager= [[CBCentralManager alloc] initWithDelegate:self
                                                             queue:nil
                                                           options:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0]
                                                                                               forKey:CBCentralManagerOptionShowPowerAlertKey]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    // This delegate method will monitor for any changes in bluetooth state and respond accordingly
    NSString *stateString = nil;
    switch(_bluetoothManager.state)
    {
        case CBCentralManagerStateResetting: stateString = @"The connection with the system service was momentarily lost, update imminent."; break;
        case CBCentralManagerStateUnsupported: stateString = @"The platform doesn't support Bluetooth Low Energy."; break;
        case CBCentralManagerStateUnauthorized: stateString = @"The app is not authorized to use Bluetooth Low Energy."; break;
        case CBCentralManagerStatePoweredOff: stateString = @"Bluetooth is currently powered off."; break;
        case CBCentralManagerStatePoweredOn: stateString = @"Bluetooth is currently powered on and available to use."; break;
        default: stateString = @"State unknown, update imminent."; break;
    }
    NSLog(@"Bluetooth State: %@",stateString);
}



//- (void)requestBluetoothAccess {
//    
//    if(!self.cbManager) {
//        self.cbManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
//    }
//    
//    /*
//     When the application requests to start scanning for bluetooth devices that is when the user is presented with a consent dialog.
//     */
//    
//    [self.cbManager scanForPeripheralsWithServices:nil options:nil];
//    
//}
//
//- (void)checkBluetoothAccess {
//    
//    if(!self.cbManager) {
//        self.cbManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
//    }
//    
//    /*
//     We can ask the bluetooth manager ahead of time what the authorization status is for our bundle and take the appropriate action.
//     */
//    
//    CBCentralManagerState state = [self.cbManager state];
//    
//    if(state == CBCentralManagerStateUnknown) {
//        NSLog(@"UNKNOWN");
//    }
//    else if(state == CBCentralManagerStateUnauthorized) {
//        NSLog(@"DENY");
//    }
//    else {
//        NSLog(@"GRANTED");
//    }
//}

@end
