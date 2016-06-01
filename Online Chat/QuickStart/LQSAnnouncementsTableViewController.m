//
//  LQSAnnouncementsTableViewController.m
//  QuickStart
//
//  Created by Layer on 6/18/15.
//  Copyright (c) 2015 Dinesh Kakumani. All rights reserved.
//

#import "LQSAnnouncementsTableViewController.h"
#import <LayerKit/LayerKit.h>
#import <LayerKit/LYRAnnouncement.h>
#import "LQSViewController.h"
#import "LQSAnnouncementsTableViewCell.h"
#import "LQSChatMessageCell.h"

@interface LQSAnnouncementsTableViewController () <LYRQueryControllerDelegate>

@property (nonatomic) BOOL shouldScrollAfterFirstAppearance;
@property (nonatomic) BOOL shouldScrollAfterUpdates;
@property (nonatomic) NSOrderedSet *announcements;
@property (nonatomic) LYRQueryController *queryController;

@end

@implementation LQSAnnouncementsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up query controller
    NSError *error;
    LYRQuery *query = [LYRQuery queryWithQueryableClass:[LYRAnnouncement class]];
    query.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey:@"position" ascending:NO]];
    
    // Set up query controller
    self.queryController = [self.layerClient queryControllerWithQuery:query error:&error];
    if (self.queryController) {
        self.queryController.delegate = self;
        
        BOOL success = [self.queryController execute:&error];
        if (success) {
            NSLog(@"Announcements Query fetched %tu announcement objects", [self.queryController numberOfObjectsInSection:0]);
            //if there are no announcements,show an alert
            if (self.queryController.count <= 0) {
                
                UIView *empty_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
                empty_view.backgroundColor = [UIColor whiteColor];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Announcements"
                                                                message:@"You currently have no announcements. Would you like to learn about announcements?"
                                                               delegate:self
                                                      cancelButtonTitle:@"NO"
                                                      otherButtonTitles:@"Yes",nil];
                [alert show];
                
                
                UILabel *label = [[UILabel alloc]initWithFrame: CGRectMake(10, 50, 500, 500)];
                [label setFont:[UIFont fontWithName:@"Helvetica Neue" size:17]];
                label.lineBreakMode = NSLineBreakByWordWrapping;
                label.numberOfLines = 0;
                label.text = @"You currently have no announcements!";
                
                [empty_view addSubview:label];
                self.view = empty_view;
            }
        } else {
            NSLog(@"Announcements Query failed with error: %@", error);
        }
    } else {
        NSLog(@"Announcements Query Controller initialization failed with error: %@", error);
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSURL *ourURL = [[NSURL alloc] initWithString:@"http://bit.ly/layer-announcements"];
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:ourURL];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.queryController.count;
}

// If an unread Announcement is selected, then mark as read
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYRAnnouncement *announcement = [_queryController objectAtIndexPath:indexPath];
    if (announcement.isUnread) {
        NSError *error = nil;
        BOOL success = [announcement markAsRead:&error];
        if (!success) {
            NSLog(@"Failed marking Announcement as read: %@", error);
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"AnnouncementCell";
    LQSAnnouncementsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    LYRAnnouncement *announcementsInfo = [self.queryController objectAtIndexPath:indexPath];
    LYRMessage *message = [self.queryController objectAtIndexPath:indexPath];
    
    LYRMessagePart *messagePart = message.parts[0];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    NSString *announcementMessage = [[NSString alloc]initWithData:messagePart.data encoding:NSUTF8StringEncoding];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    [cell updateDate:[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:announcementsInfo.sentAt]]];
    [cell updateSenderName:announcementsInfo.sender.displayName];
    [cell updateMessageLabel:announcementMessage];
    
    if (announcementsInfo.isUnread) {
        cell.indicatorLabel.hidden = NO;
    } else {
        cell.indicatorLabel.hidden = YES;
    }
    
    return cell;
}

#pragma mark - Query controller delegate implementation

- (void)queryController:(LYRQueryController *)controller didChangeObject:(id)object atIndexPath:(NSIndexPath *)indexPath forChangeType:(LYRQueryControllerChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    
    switch (type) {
        case LYRQueryControllerChangeTypeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case LYRQueryControllerChangeTypeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            if (controller.count >= newIndexPath.row) {
                self.shouldScrollAfterUpdates = YES;
            }
            break;
        case LYRQueryControllerChangeTypeMove:
            [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
        case LYRQueryControllerChangeTypeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
    
}

- (void)queryControllerWillChangeContent:(LYRQueryController *)queryController
{
    [self.tableView beginUpdates];
}

- (void)queryControllerDidChangeContent:(LYRQueryController *)queryController
{
    [self.tableView endUpdates];
}

@end
