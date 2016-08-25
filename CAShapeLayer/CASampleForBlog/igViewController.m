//
//  igViewController.m
//  CASampleForBlog
//
//  Created by Torrey Betts on 10/14/13.
//  Copyright (c) 2013 Infragistics. All rights reserved.
//

#import "igViewController.h"
#import "CAIndicatorView.h"

@interface igViewController ()
{
    CAIndicatorView *_indicatorView;
}
@end

@implementation igViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _indicatorView = [[CAIndicatorView alloc] init];
    _indicatorView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
    _indicatorView.frame = CGRectMake(0, 0, 150, 150);
    _indicatorView.center = self.view.center;
    [self.view addSubview:_indicatorView];

    [self performSelector:@selector(resizeIndicator) withObject:nil afterDelay:2.5];
}

-(void)resizeIndicator
{
    _indicatorView.frame = CGRectMake(0, 0, 200, 200);
    _indicatorView.center = self.view.center;
}

@end