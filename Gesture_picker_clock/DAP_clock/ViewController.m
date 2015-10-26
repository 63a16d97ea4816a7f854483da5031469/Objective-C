//
//  ViewController.m
//  DAP_clock
//
//  Created by Cao Lei on 22/7/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

/*
 I did this because I need to develop an app which has similar function with Surprise Alarm.
 
 This is the Surprise Alarm app's download link:
 https://www.mcdonalds.com.sg/downloads/surprise-alarm/
 */

#import "ViewController.h"
#import "Slider.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize valueLabel;

BOOL IsMinuteHour=NO;
BOOL is12or24format=NO;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IsMinuteHour){
        CGRect sliderFrame = CGRectMake(60, 150, 250, 250);
        Slider* minuteSlider = [[Slider alloc] initWithFrame:sliderFrame];
        minuteSlider.lineWidth=15;
        minuteSlider.unfilledColor=[UIColor lightGrayColor];
        minuteSlider.filledColor = [UIColor grayColor];
        minuteSlider.handleType = semiTransparentWhiteCircle;
        minuteSlider.minimumValue = 0;
        minuteSlider.maximumValue = 60;
        minuteSlider.isShowTimeLabel=NO;
        [minuteSlider setInnerMarkingLabels:@[@"5", @"10", @"15", @"20", @"25", @"30", @"35", @"40", @"45", @"50", @"55", @"60"]];
        [minuteSlider addTarget:self action:@selector(minuteDidChange:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:minuteSlider];
    }else{
        CGRect sliderFrame = CGRectMake(60, 150, 250, 250);
        Slider* hourSlider = [[Slider alloc] initWithFrame:sliderFrame];
        hourSlider.lineWidth=15;
        hourSlider.unfilledColor=[UIColor lightGrayColor];
        hourSlider.filledColor = [UIColor grayColor];
        hourSlider.handleType = semiTransparentWhiteCircle;
        hourSlider.isShowTimeLabel=NO;
        if(is12or24format){
            [hourSlider setInnerMarkingLabels:@[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"]];
            hourSlider.minimumValue = 0;
            hourSlider.maximumValue = 12;
        }else{
            [hourSlider setInnerMarkingLabels:@[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12",@"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"00"]];
            hourSlider.minimumValue = 0;
            hourSlider.maximumValue = 24;
        }
        [hourSlider addTarget:self action:@selector(hourDidChange:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:hourSlider];
    }
}

-(void)hourDidChange:(Slider*)slider {
    int newVal=0;
    if(is12or24format){
        newVal = (int)slider.currentValue<12 ? (int)slider.currentValue : 12;
    }else{
        newVal = (int)slider.currentValue<24 ? (int)slider.currentValue : 00;
    }
    NSString* oldTime = valueLabel.text;
    NSRange colonRange = [oldTime rangeOfString:@":"];
    valueLabel.text = [NSString stringWithFormat:@"%d:%@", newVal, [oldTime substringFromIndex:colonRange.location + 1]];
}

-(void)minuteDidChange:(Slider*)slider {
    int newVal = (int)slider.currentValue < 60 ? (int)slider.currentValue : 0;
    NSString* oldTime = valueLabel.text;
    NSRange colonRange = [oldTime rangeOfString:@":"];
    valueLabel.text = [NSString stringWithFormat:@"%@:%02d", [oldTime substringToIndex:colonRange.location], newVal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
