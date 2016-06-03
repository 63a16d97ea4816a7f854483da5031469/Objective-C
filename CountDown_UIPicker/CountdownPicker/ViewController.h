//
//  ViewController.h
//  CountdownPicker
//
//  Created by Lei Cao on 3/6/16.
//  Copyright © 2016 Lei Cao (Tony). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    
    __weak IBOutlet UIPickerView *datePick;
    NSMutableArray *hoursArray;
    NSMutableArray *minsArray;
    
    NSTimeInterval interval;
}
- (IBAction)calculateTimeFromPicker:(id)sender;

@end