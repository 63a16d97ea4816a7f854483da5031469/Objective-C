//
//  ImageHelper.m
//  NewInterviewApp
//
//  Created by Cao Lei on 17/10/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageHelper.h"

#define TMP NSTemporaryDirectory()
#define FILE_EXT_PNG @"png"
#define FILE_EXT_JPG @"jpg"
#define FILE_EXT_JPEG @"jpg"
#define FILE_EXT_DOT @"."
#define HEADER_STATIC_ID @"1222997280324"

@implementation ImageHelper

+(void) setImage:(UIImageView*)view withUrl:(NSString *)url {
    [self asyncSetImageForView:view withUrl:url];
}

+(void)setImage:(UIImage*)image forView:(UIImageView*)view animate:(BOOL)animate  {
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self stopSpinnerForView:view];
        if ([view image] != image) {
            
            if (animate) {
                view.alpha =0.0;
            }
            
            [view setImage:image];
            
            if(animate){
                [UIView beginAnimations:@"fade in" context:nil];
                [UIView setAnimationDuration:0.5];
                view.alpha =1.0;
                [UIView commitAnimations];
            }
        }
    });
}


+ (void)asyncSetImageForView:(UIImageView*)view withUrl:(NSString*)url {
    // This is the loading indicator
    [self startSpinnerForView:view];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage* image = nil;
        if (url) {
            // File the image in the disk cache
            image = [self getImageFromCache:url];
            if (image) {
                [self setImage:image forView:view animate:true];
                return;
            } else {
                //Download the image from the server
                image = [self downloadImageFromUrl:url];
                if (image) {
                    [self setImage:image forView:view animate:true];
                    return;
                }
            }
        }
    });
}

+(void)startSpinnerForView:(UIView*)view {
    // This is the loading indicator
    UIActivityIndicatorView *spinner=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
    [view addSubview:spinner];
    [view bringSubviewToFront:spinner];
    [spinner startAnimating];
}


+(void)stopSpinnerForView:(UIView*)view{
    for (UIView * subview in view.subviews) {
        [ (UIActivityIndicatorView*)subview stopAnimating];
        [subview removeFromSuperview];
    }
}

+(UIImage*)getImageFromCache:(NSString*)ImageURLString {
    NSString * filename = [ImageURLString substringFromIndex:([ImageURLString rangeOfString:@"/" options:NSBackwardsSearch].location+1)];
    NSString* cacheFileName = [NSString stringWithFormat:@"%@_%@", HEADER_STATIC_ID, filename];
    NSString *uniquePath = [TMP stringByAppendingPathComponent: cacheFileName];
    if([[NSFileManager defaultManager] fileExistsAtPath: uniquePath]) {
        return [UIImage imageWithContentsOfFile: uniquePath];
    }
    return nil;
}


+ (UIImage*) downloadImageFromUrl: (NSString *) ImageURLString
{
    NSURL *ImageURL = [NSURL URLWithString: ImageURLString];
    
    NSString* filename = [ImageURLString substringFromIndex:([ImageURLString rangeOfString:@"/" options:NSBackwardsSearch].location+1)];
    NSString* cacheFileName = [NSString stringWithFormat:@"%@_%@", HEADER_STATIC_ID, filename];
    
    NSString* uniquePath = [TMP stringByAppendingPathComponent:cacheFileName];
    
    // Check for file existence
    if(![[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
    {
        // The file doesn't exist, we should get a copy of it
        
        // Fetch image
        NSData *data = [[NSData alloc] initWithContentsOfURL: ImageURL];
        UIImage *image = [[UIImage alloc] initWithData: data];
        
        // Is it PNG or JPG/JPEG?
        // Running the image representation function writes the data from the image to a file
        NSString* dotPNG = [NSString stringWithFormat:@"%@%@", FILE_EXT_DOT, FILE_EXT_PNG];
        NSString* dotJPG = [NSString stringWithFormat:@"%@%@", FILE_EXT_DOT, FILE_EXT_JPG];
        NSString* dotJPEG = [NSString stringWithFormat:@"%@%@", FILE_EXT_DOT, FILE_EXT_JPEG];
        if([ImageURLString rangeOfString:dotPNG options: NSCaseInsensitiveSearch].location != NSNotFound)
        {
            [UIImagePNGRepresentation(image) writeToFile: uniquePath atomically: YES];
        }
        else if(
                [ImageURLString rangeOfString:dotJPG options: NSCaseInsensitiveSearch].location != NSNotFound ||
                [ImageURLString rangeOfString:dotJPEG options: NSCaseInsensitiveSearch].location != NSNotFound
                )
        {
            [UIImageJPEGRepresentation(image, 100) writeToFile: uniquePath atomically: YES];
        }
        return image;
    }
    return nil;
}

@end
