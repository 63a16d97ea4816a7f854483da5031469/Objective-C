//
//  ViewController.m
//  ConnectBLEDevice
//
//  Created by Lei Cao on 25/2/16.
//  Copyright © 2016 Lei Cao. All rights reserved.
//

#import "ViewController.h"
@import CoreBluetooth;

@interface ViewController ()<CBCentralManagerDelegate>

@end

@implementation ViewController
CBCentralManager * _cm;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.peripherals=[NSMutableArray new];
    _cm = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (NSString*)UUIDString:(CFUUIDRef)uuid {
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    return (__bridge_transfer NSString*)string;
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state == CBCentralManagerStatePoweredOn) {
        [self scanForPeripherals];
    }
}

- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary *)advertisementData
                  RSSI:(NSNumber *)RSSI {
        NSLog(@"Received peripheral : \n%@", peripheral); 
        NSLog(@"Adv data : %@", advertisementData);
    
    [self.peripherals addObject:peripheral];
    [central connectPeripheral:peripheral options:nil];
    [peripheral readRSSI];
}

- (int)scanForPeripherals {
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:NO], CBCentralManagerScanOptionAllowDuplicatesKey,
                             nil];
    
    [_cm scanForPeripheralsWithServices:nil options:options];
    return 0;
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"didConnectPeripheral");
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"didDisconnectPeripheral");
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"failed to connect");
}

- (void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(NSError *)error {
    NSLog(@"didReadRSSI");
}

@end
