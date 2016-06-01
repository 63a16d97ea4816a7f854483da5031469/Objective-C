//
//  LQSAnnouncementsTableViewCell.h
//  QuickStart
//
//  Created by Layer on 6/22/15.
//  Copyright (c) 2015 Dinesh Kakumani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQSAnnouncementsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *senderName;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *MessageLabel;
@property (strong, nonatomic) IBOutlet UILabel *indicatorLabel;

- (void)updateSenderName:(NSString *) senderName;
- (void)updateDate:(NSString *)date;
- (void)updateMessageLabel:(NSString *)message;

@end
