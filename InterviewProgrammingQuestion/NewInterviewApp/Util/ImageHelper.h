//
//  ImageHelper.h
//  NewInterviewApp
//
//  Created by Cao Lei on 17/10/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageHelper : NSObject
+ (void)asyncSetImageForView:(UIImageView*)view withUrl:(NSString*)url;
+ (void) setImage:(UIImageView*)view withUrl:(NSString *)url;
@end
