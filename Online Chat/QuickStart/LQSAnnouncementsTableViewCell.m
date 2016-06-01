//
//  LQSAnnouncementsTableViewCell.m
//  QuickStart
//
//  Created by Layer on 6/22/15.
//  Copyright (c) 2015 Dinesh Kakumani. All rights reserved.
//

#import "LQSAnnouncementsTableViewCell.h"

@interface LQSAnnouncementsTableViewCell ()

@end

@implementation LQSAnnouncementsTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)updateSenderName:(NSString *) senderName
{
    self.senderName.text = senderName;
}

- (void)updateDate:(NSString *)date
{
    self.dateLabel.text = date;
}

- (void)updateMessageLabel:(NSString *)message
{
    self.MessageLabel.text = message;
}

@end
