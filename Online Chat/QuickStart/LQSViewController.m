//
//  ViewController.m
//  QuickStart
//
//  Created by Abir Majumdar on 12/3/14.
//  Copyright (c) 2014 Layer, Inc. All rights reserved.
//

#import "LQSViewController.h"
#import "LQSChatMessageCell.h"
#import "LQSAnnouncementsTableViewController.h"

// Defined in LQSAppDelegate.m
extern NSString *const LQSCurrentUserID;
extern NSString *const LQSParticipantUserID;
extern NSString *const LQSParticipant2UserID;
extern NSString *const LQSInitialMessageText;
extern NSString *const LQSCategoryIdentifier;

// Metadata keys related to navbar color
static NSString *const LQSBackgroundColorMetadataKey = @"backgroundColor";
static NSString *const LQSRedBackgroundColorMetadataKeyPath = @"backgroundColor.red";
static NSString *const LQSBlueBackgroundColorMetadataKeyPath = @"backgroundColor.blue";
static NSString *const LQSGreenBackgroundColorMetadataKeyPath = @"backgroundColor.green";
static NSString *const LQSRedBackgroundColor = @"red";
static NSString *const LQSBlueBackgroundColor = @"blue";
static NSString *const LQSGreenBackgroundColor = @"green";

// Message State Images
static NSString *const LQSMessageSentImageName = @"message-sent";
static NSString *const LQSMessageDeliveredImageName =@"message-delivered";
static NSString *const LQSMessageReadImageName =@"message-read";

static NSString *const LQSChatMessageCellReuseIdentifier = @"ChatMessageCell";

static NSString *const LQSLogoImageName = @"Logo";
static CGFloat const LQSKeyboardHeight = 255.0f;

static NSInteger const LQSMaxCharacterLimit = 66;

static NSString *const MIMETypeImagePNG = @"image/png";

static NSDateFormatter *LQSDateFormatter()
{
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"HH:mm:ss";
    }
    return dateFormatter;
}

static UIColor *LSRandomColor(void)
{
    CGFloat redFloat = arc4random() % 100 / 100.0f;
    CGFloat greenFloat = arc4random() % 100 / 100.0f;
    CGFloat blueFloat = arc4random() % 100 / 100.0f;
    
    return [UIColor colorWithRed:redFloat
                           green:greenFloat
                            blue:blueFloat
                           alpha:1.0f];
}

@interface LQSViewController () <UITextViewDelegate, LYRQueryControllerDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>

@property (nonatomic) LYRConversation *conversation;
@property (nonatomic) LYRQueryController *queryController;
@property (nonatomic) BOOL sendingImage;
@property (nonatomic) UIImage *photo; // This is where the selected photo will be stored

@end

@implementation LQSViewController

#pragma mark - VC Lifecycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupLayerNotificationObservers];
    [self fetchLayerConversation];
    
    // Setup for Shake
    [self becomeFirstResponder];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:LQSLogoImageName]];
    logoImageView.frame = CGRectMake(0, 0, 36, 36);
    logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = logoImageView;
    self.navigationItem.hidesBackButton = YES;
    self.inputTextView.delegate = self;
    self.inputTextView.text = LQSInitialMessageText;
    
}

- (void)viewWillAppear:(BOOL)animated {
    if (self.queryController) {
        [self scrollToBottom];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupLayerNotificationObservers
{
    // Register for Layer object change notifications
    // For more information about Synchronization, check out https://developer.layer.com/docs/integration/ios#synchronization
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveLayerObjectsDidChangeNotification:)
                                                 name:LYRClientObjectsDidChangeNotification
                                               object:nil];
    
    // Register for typing indicator notifications
    // For more information about Typing Indicators, check out https://developer.layer.com/docs/integration/ios#typing-indicator
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveTypingIndicator:)
                                                 name:LYRConversationDidReceiveTypingIndicatorNotification
                                               object:self.conversation];
    
    // Register for synchronization notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveLayerClientWillBeginSynchronizationNotification:)
                                                 name:LYRClientWillBeginSynchronizationNotification
                                               object:self.layerClient];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveLayerClientDidFinishSynchronizationNotification:)
                                                 name:LYRClientDidFinishSynchronizationNotification
                                               object:self.layerClient];
}

#pragma mark - Fetching Layer Content

- (void)fetchLayerConversation
{
    // Fetches all conversations between the authenticated user and the supplied participant
    // For more information about Querying, check out https://developer.layer.com/docs/integration/ios#querying
    if (!self.conversation) {
        NSError *error;
        // Trying creating a new distinct conversation between all 3 participants
        self.conversation = [self.layerClient newConversationWithParticipants:[NSSet setWithArray:@[ LQSParticipantUserID, LQSParticipant2UserID  ]] options:nil error:&error];
        if (!self.conversation) {
            // If a conversation already exists, use that one
            if (error.code == LYRErrorDistinctConversationExists) {
                self.conversation = error.userInfo[LYRExistingDistinctConversationKey];
                NSLog(@"Conversation already exists between participants. Using existing");
            }
        }
    }
    NSLog(@"Conversation identifier: %@",self.conversation.identifier);
    
    // setup query controller with messages from last conversation
    if (!self.queryController) {
        [self setupQueryController];
    }
}

- (void)setupQueryController
{
    // For more information about the Query Controller, check out https://developer.layer.com/docs/integration/ios#querying
    
    // Query for all the messages in conversation sorted by position
    LYRQuery *query = [LYRQuery queryWithQueryableClass:[LYRMessage class]];
    query.predicate = [LYRPredicate predicateWithProperty:@"conversation" predicateOperator:LYRPredicateOperatorIsEqualTo value:self.conversation];
    query.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey:@"position" ascending:YES]];
    
    // Set up query controller
    NSError *error;
    self.queryController = [self.layerClient queryControllerWithQuery:query error:&error];
    if (self.queryController) {
        self.queryController.delegate = self;
        
        BOOL success = [self.queryController execute:&error];
        if (success) {
            NSLog(@"Query fetched %tu message objects", [self.queryController numberOfObjectsInSection:0]);
        } else {
            NSLog(@"Query failed with error: %@", error);
        }
        [self.tableView reloadData];
        [self.conversation markAllMessagesAsRead:nil];
    } else {
        NSLog(@"Query Controller initialization failed with error: %@", error);
    }
}

#pragma - mark Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return number of objects in queryController
    NSInteger rows = [self.queryController numberOfObjectsInSection:0];
    return rows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYRMessage *message = [self.queryController objectAtIndexPath:indexPath];
    LYRMessagePart *messagePart = message.parts[0];
    
    //If it is type image
    if ([messagePart.MIMEType isEqualToString:@"image/png"]) {
        return 130;
    } else {
        return 70;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Set up custom ChatMessageCell for displaying message
    //LQSPictureMessageCell
    LQSChatMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:LQSChatMessageCellReuseIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[LQSChatMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LQSChatMessageCellReuseIdentifier];
    }
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(LQSChatMessageCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get Message Object from queryController
    LYRMessage *message = [self.queryController objectAtIndexPath:indexPath];
    LYRMessagePart *messagePart = message.parts[0];
    
    //If it is type image
    if ([messagePart.MIMEType isEqualToString:@"image/png"]) {
        cell.messageLabel.text = @""; //
        [cell updateWithImage:[[UIImage alloc]initWithData:messagePart.data]];
        
    } else {
        [cell removeImage]; //just a safegaurd to ensure  that no image is present
        [cell assignText:[[NSString alloc]initWithData:messagePart.data
                                              encoding:NSUTF8StringEncoding]];
    }
    NSString *timestampText = @"";
    
    
    // If the message was sent by current user, show Receipent Status Indicator
    if ([message.sender.userID isEqualToString:LQSCurrentUserID]) {
        switch ([message recipientStatusForUserID:LQSParticipantUserID]) {
            case LYRRecipientStatusSent:
                [cell.messageStatus setImage:[UIImage imageNamed:LQSMessageSentImageName]];
                timestampText = [NSString stringWithFormat:@"Sent: %@",[LQSDateFormatter() stringFromDate:message.sentAt]];
                break;
                
            case LYRRecipientStatusDelivered:
                [cell.messageStatus setImage:[UIImage imageNamed:LQSMessageDeliveredImageName]];
                timestampText = [NSString stringWithFormat:@"Delivered: %@",[LQSDateFormatter() stringFromDate:message.sentAt]];
                break;
                
            case LYRRecipientStatusRead:
                [cell.messageStatus setImage:[UIImage imageNamed:LQSMessageReadImageName]];
                timestampText = [NSString stringWithFormat:@"Read: %@",[LQSDateFormatter() stringFromDate:message.receivedAt]];
                break;
                
            case LYRRecipientStatusInvalid:
                NSLog(@"Participant: Invalid");
                break;
                
            default:
                break;
        }
    } else {
        [message markAsRead:nil];
        timestampText = [NSString stringWithFormat:@"Received: %@",[LQSDateFormatter() stringFromDate:message.sentAt]];
    }
    
    if (message.sender.userID != Nil) {
        cell.deviceLabel.text = [NSString stringWithFormat:@"%@ @ %@", message.sender.userID, timestampText];
    }else {
        cell.deviceLabel.text = [NSString stringWithFormat:@"Platform @ %@",timestampText];
    }
}

#pragma mark - Receiving Typing Indicator

- (void)didReceiveTypingIndicator:(NSNotification *)notification
{
    // For more information about Typing Indicators, check out https://developer.layer.com/docs/integration/ios#typing-indicator
    
    NSString *participantID = notification.userInfo[LYRTypingIndicatorParticipantUserInfoKey];
    LYRTypingIndicator typingIndicator = [notification.userInfo[LYRTypingIndicatorValueUserInfoKey] unsignedIntegerValue];
    
    if (typingIndicator == LYRTypingDidBegin) {
        self.typingIndicatorLabel.alpha = 1;
        self.typingIndicatorLabel.text = [NSString stringWithFormat:@"%@ is typing...",participantID];
    } else {
        self.typingIndicatorLabel.alpha = 0;
        self.typingIndicatorLabel.text = @"";
    }
}

#pragma - IBActions

- (IBAction)sendMessageAction:(id)sender
{
    // Send Message
    [self sendMessage:self.inputTextView.text];
    
    // Lower the keyboard
    [self moveViewUpToShowKeyboard:NO];
    [self.inputTextView resignFirstResponder];
}

- (void)sendMessage:(NSString *)messageText
{
    // Send a Message
    // See "Quick Start - Send a Message" for more details
    // https://developer.layer.com/docs/quick-start/ios#send-a-message
    
    LYRMessagePart *messagePart;
    self.messageImageView.image = nil;
    // If no conversations exist, create a new conversation object with a single participant
    if (!self.conversation) {
        [self fetchLayerConversation];
    }
    
    //if we are sending an image
    if (self.sendingImage) {
        UIImage *image = self.photo; //get photo
        NSData *imageData = UIImagePNGRepresentation(image);
        messagePart = [LYRMessagePart messagePartWithMIMEType:MIMETypeImagePNG data:imageData];
        self.sendingImage = NO;
    } else {
        //Creates a message part with text/plain MIME Type
        messagePart = [LYRMessagePart messagePartWithText:messageText];
    }
    
    // Creates and returns a new message object with the given conversation and array of message parts
    NSString *pushMessage= [NSString stringWithFormat:@"%@ says %@",self.layerClient.authenticatedUser.userID ,messageText];
    
    LYRPushNotificationConfiguration *defaultConfiguration = [LYRPushNotificationConfiguration new];
    defaultConfiguration.alert = pushMessage;
    defaultConfiguration.category = LQSCategoryIdentifier;
    // The following dictionary will appear in push payload
    defaultConfiguration.data = @{ @"test_key": @"test_value"};
    NSDictionary *pushOptions = @{ LYRMessageOptionsPushNotificationConfigurationKey: defaultConfiguration };
    
    LYRMessage *message = [self.layerClient newMessageWithParts:@[messagePart] options:pushOptions error:nil];
    
    // Sends the specified message
    NSError *error;
    BOOL success = [self.conversation sendMessage:message error:&error];
    if (success) {
        // If the message was sent by the participant, show the sentAt time and mark the message as read
        NSLog(@"Message queued to be sent: %@", messageText);
        self.inputTextView.text = @"";
        
    } else {
        NSLog(@"Message send failed: %@", error);
    }
    self.photo = nil;
    if (!self.queryController) {
        [self setupQueryController];
    }
}

#pragma - mark Set up for Shake

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    // If user shakes the phone, change the navbar color and set metadata
    if (motion == UIEventSubtypeMotionShake) {
        UIColor *newNavBarBackgroundColor = LSRandomColor();
        self.navigationController.navigationBar.barTintColor = newNavBarBackgroundColor;
        
        CGFloat redFloat = 0.0, greenFloat = 0.0, blueFloat = 0.0, alpha = 0.0;
        [newNavBarBackgroundColor getRed:&redFloat green:&greenFloat blue:&blueFloat alpha:&alpha];
        
        // For more information about Metadata, check out https://developer.layer.com/docs/integration/ios#metadata
        NSDictionary *metadata = @{ LQSBackgroundColorMetadataKey : @{
                                            LQSRedBackgroundColor : [[NSNumber numberWithFloat:redFloat] stringValue],
                                            LQSGreenBackgroundColor : [[NSNumber numberWithFloat:greenFloat] stringValue],
                                            LQSBlueBackgroundColor : [[NSNumber numberWithFloat:blueFloat] stringValue]}
                                    };
        [self.conversation setValuesForMetadataKeyPathsWithDictionary:metadata merge:YES];
    }
}

#pragma - mark TextView Delegate Methods

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    // For more information about Typing Indicators, check out https://developer.layer.com/docs/integration/ios#typing-indicator
    
    // Sends a typing indicator event to the given conversation.
    [self.conversation sendTypingIndicator:LYRTypingDidBegin];
    [self moveViewUpToShowKeyboard:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    // Sends a typing indicator event to the given conversation.
    [self.conversation sendTypingIndicator:LYRTypingDidFinish];
}

// Move up the view when the keyboard is shown
- (void)moveViewUpToShowKeyboard:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    CGRect rect = self.view.frame;
    if (movedUp) {
        if (rect.origin.y == 0) {
            rect.origin.y = self.view.frame.origin.y - LQSKeyboardHeight;
        }
    } else {
        if (rect.origin.y < 0) {
            rect.origin.y = self.view.frame.origin.y + LQSKeyboardHeight;
        }
    }
    self.view.frame = rect;
    [UIView commitAnimations];
}

// If the user hits Return then dismiss the keyboard and move the view back down
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.inputTextView resignFirstResponder];
        [self moveViewUpToShowKeyboard:NO];
        return NO;
    }
    
    NSUInteger limit = LQSMaxCharacterLimit;
    return !([self.inputTextView.text length] > limit && [text length] > range.length);
}

#pragma mark - Query Controller Delegate Methods

- (void)queryControllerWillChangeContent:(LYRQueryController *)queryController
{
    [self.tableView beginUpdates];
}

- (void)queryController:(LYRQueryController *)controller
        didChangeObject:(id)object
            atIndexPath:(NSIndexPath *)indexPath
          forChangeType:(LYRQueryControllerChangeType)type
           newIndexPath:(NSIndexPath *)newIndexPath
{
    // Automatically update tableview when there are change events
    switch (type) {
        case LYRQueryControllerChangeTypeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case LYRQueryControllerChangeTypeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case LYRQueryControllerChangeTypeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case LYRQueryControllerChangeTypeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
}

- (void)queryControllerDidChangeContent:(LYRQueryController *)queryController
{
    [self.tableView endUpdates];
    [self scrollToBottom];
    
}

#pragma mark - Layer Sync Notification Handler

- (void)didReceiveLayerClientWillBeginSynchronizationNotification:(NSNotification *)notification
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didReceiveLayerClientDidFinishSynchronizationNotification:(NSNotification *)notification
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark - Layer Object Change Notification Handler

- (void)didReceiveLayerObjectsDidChangeNotification:(NSNotification *)notification;
{
    // Get nav bar colors from conversation metadata
    [self setNavbarColorFromConversationMetadata:self.conversation.metadata];
    [self fetchLayerConversation];
}

#pragma - mark General Helper Methods

- (void)scrollToBottom
{
    NSUInteger messageCount = [self numberOfMessages];
    if (self.conversation && messageCount > 0) {
        NSIndexPath* ip = [NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:0] - 1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)setNavbarColorFromConversationMetadata:(NSDictionary *)metadata
{
    // For more information about Metadata, check out https://developer.layer.com/docs/integration/ios#metadata
    if (![metadata valueForKey:LQSBackgroundColorMetadataKey]) {
        return;
    }
    CGFloat redColor = (CGFloat)[[metadata valueForKeyPath:LQSRedBackgroundColorMetadataKeyPath] floatValue];
    CGFloat blueColor = (CGFloat)[[metadata valueForKeyPath:LQSBlueBackgroundColorMetadataKeyPath] floatValue];
    CGFloat greenColor = (CGFloat)[[metadata valueForKeyPath:LQSGreenBackgroundColorMetadataKeyPath] floatValue];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:redColor
                                                                           green:greenColor
                                                                            blue:blueColor
                                                                           alpha:1.0f];
}

- (IBAction)CameraButtonSelected:(UIBarButtonItem *)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    [self presentViewController:picker animated:YES completion:nil];
}

- (NSUInteger)numberOfMessages
{
    return [self.queryController numberOfObjectsInSection:0];
}


- (IBAction)clearButtonPressed:(UIBarButtonItem *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete messages?"
                                                    message:@"This action will clear all your current messages. Are you sure you want to do this?"
                                                   delegate:self
                                          cancelButtonTitle:@"NO"
                                          otherButtonTitles:@"Yes",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self clearMessages];
    }
}

- (void)clearMessages
{
    LYRQuery *message = [LYRQuery queryWithQueryableClass:[LYRMessage class]];
    
    NSError *error;
    NSOrderedSet *messageList = [self.layerClient executeQuery:message error:&error];
    
    if (messageList) {
        for (LYRMessage *message in messageList) {
            BOOL success = [message delete:LYRDeletionModeAllParticipants error:&error];
            NSLog(@"Message is: %@", message.parts);
            if (success) {
                NSLog(@"The message has been deleted");
            } else {
                NSLog(@"Failed deletion of message: %@", error);
            }
        }
    } else {
        NSLog(@"Failed querying for messages: %@", error);
    }
}

- (IBAction)cameraButtonPressed:(UIButton *)sender
{
    self.inputTextView.text = @"";
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.sendingImage = YES;
    UIImage *image = info[UIImagePickerControllerEditedImage] ?: info[UIImagePickerControllerOriginalImage];
    self.photo = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.messageImageView.image = image;
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"Cancel");
    [self dismissViewControllerAnimated:YES completion:nil];
    self.sendingImage = FALSE;
}

#pragma mark - Segue method

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]]) {
        if ([segue.destinationViewController isKindOfClass:[LQSAnnouncementsTableViewController class]]) {
            LQSAnnouncementsTableViewController *anncementsController = segue.destinationViewController;
            anncementsController.layerClient = self.layerClient;
        }
    }
}

@end
