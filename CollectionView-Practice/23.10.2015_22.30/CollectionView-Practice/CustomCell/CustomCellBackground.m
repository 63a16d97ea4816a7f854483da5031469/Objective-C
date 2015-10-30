//
//  CustomCellBackground.m
//  CollectionView-Practice
//
//  Created by Cao Lei on 21/10/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//
#import "CustomCellBackground.h"

@implementation CustomCellBackground

- (void)drawRect:(CGRect)rect
{
    CGContextRef aRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(aRef);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5.0f];
    bezierPath.lineWidth = 5.0f;
    [[UIColor blackColor] setStroke];
    
    UIColor *fillColor = [UIColor colorWithRed:0.529 green:0.808 blue:0.922 alpha:1];
    [fillColor setFill];
    
    [bezierPath stroke];
    [bezierPath fill];
    CGContextRestoreGState(aRef);
}

@end
