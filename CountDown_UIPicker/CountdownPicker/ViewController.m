//
//  ViewController.m
//  CountdownPicker
//
//  Created by Lei Cao on 3/6/16.
//  Copyright © 2016 Lei Cao (Tony). All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    datePick.delegate=self;
    //initialize arrays
    hoursArray = [[NSMutableArray alloc] init];
    minsArray = [[NSMutableArray alloc] init];
    NSString *strVal = [[NSString alloc] init];
    
    for(int i=0; i<61; i++)
    {
        strVal = [NSString stringWithFormat:@"%d", i];
        
        //NSLog(@"strVal: %@", strVal);
        
        //Create array with 0-12 hours
        if (i < 13)
        {
            [hoursArray addObject:strVal];
        }
        
        //create arrays with 0-60 mins
        [minsArray addObject:strVal];
    }
    
    
    NSLog(@"[hoursArray count]: %lu", (unsigned long)[hoursArray count]);
    NSLog(@"[minsArray count]: %lu", (unsigned long)[minsArray count]);
    
}

//Method to define how many columns/dials to show
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

// Method to define the numberOfRows in a component using the array.
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent :(NSInteger)component
{
    if (component==0)
    {
        return [hoursArray count];
    }
    else
    {
        return [minsArray count];
    }
    
}

// Method to show the title of row for a component.
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    switch (component)
    {
        case 0:
            return [hoursArray objectAtIndex:row];
            break;
        case 1:
            return [minsArray objectAtIndex:row];
            break;
    }
    return nil;
}

- (IBAction)calculateTimeFromPicker:(id)sender
{
    NSLog(@"press the button");
    NSString *hoursStr = [NSString stringWithFormat:@"%@",[hoursArray objectAtIndex:[datePick selectedRowInComponent:0]]];
    
    NSString *minsStr = [NSString stringWithFormat:@"%@",[minsArray objectAtIndex:[datePick selectedRowInComponent:1]]];
    
    
    int hoursInt = [hoursStr intValue];
    int minsInt = [minsStr intValue];
    
    
    
    int totalMinute=hoursInt*60+minsInt;
    
    interval = 0 + (minsInt*60) + (hoursInt*3600);
    
    NSString *totalTimeStr = [NSString stringWithFormat:@"%f",interval];
    
    NSLog(@"the total minute:%d",totalMinute);
    NSLog(@"the totalTimeStr:%@",totalTimeStr);
    
}
@end
