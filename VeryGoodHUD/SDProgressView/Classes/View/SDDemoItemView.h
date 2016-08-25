//
//  SDDemoItemView.h
//  SDProgressView
//
//  Created by aier on 15-2-20.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDBaseProgressView.h"

@interface SDDemoItemView : UIView

@property (nonatomic, assign) Class progressViewClass;

@property (nonatomic, strong) SDBaseProgressView *progressView;

+ (id)demoItemViewWithClass:(Class)class;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com