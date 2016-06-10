//
//  ViewController.h
//  EchatTry
//
//  Created by Cao Lei on 10/6/16.
//  Copyright © 2016 Cao Lei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EColumnChart.h"



@interface ViewController : UIViewController<EColumnChartDelegate, EColumnChartDataSource>
@property (strong, nonatomic) EColumnChart *eColumnChart;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@end

