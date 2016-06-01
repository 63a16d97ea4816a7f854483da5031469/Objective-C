//
//  ChatMessageCell.m
//  QuickStart
//
//  Created by Abir Majumdar on 12/3/14.
//  Copyright (c) 2014 Layer, Inc. All rights reserved.
//

#import "LQSChatMessageCell.h"

@interface LQSChatMessageCell ()

@property (nonatomic) UIImageView *messageImageView;

@end

@implementation LQSChatMessageCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.messageImageView = [[UIImageView alloc]init];
        self.messageImageView.tag = 1;
        self.messageImageView.frame = CGRectMake(100, 30, 150, 90);
        [self addSubview:self.messageImageView];
    }

    return self;
}

- (void)updateWithImage:(UIImage *)image
{
    self.messageImageView.image = image;
}

- (void)removeImage
{
    if (self.messageImageView.image) {
        self.messageImageView.image = nil;
    }
}

- (void)assignText:(NSString *)text
{
    self.messageLabel.text = text;
}

@end
