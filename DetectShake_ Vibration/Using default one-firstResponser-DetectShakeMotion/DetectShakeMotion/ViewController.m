//
//  ViewController.m
//  DetectShakeMotion
//
//  Created by Cao Lei on 27/7/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shakeNotification:)
                                                 name:@"UIEventSubtypeMotionShakeEnded" object:nil];
}

-(BOOL)becomeFirstResponder
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(event.type == UIEventSubtypeMotionShake)
    {
        NSLog(@"shaking!");
        self.centerLabel.text=@"Shaking!";
        [self.view setBackgroundColor:[UIColor greenColor]];
    }
}


- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if ( event.subtype == UIEventSubtypeMotionShake ) {
        NSLog(@"not shaking");
        self.centerLabel.text=@"Not Shaking!";
        [self.view setBackgroundColor:[UIColor whiteColor]];

    }
    
    if ([super respondsToSelector:@selector(motionEnded:withEvent:)]) {
        [super motionEnded:motion withEvent:event];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)viewDidDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewDidDisappear:NO];
}

-(IBAction)pressButton:(id)sender{
    [self becomeFirstResponder];
}


@end
