//
//  ViewController.m
//  GoogleDrive
//
//  Created by Lei Cao on 31/5/16.
//  Copyright © 2016 Lei Cao (Tony). All rights reserved.
//

#import "ViewController.h"
#import "GTLDrive.h"

static NSString *const kKeychainItemName = @"Drive API";
static NSString *const kClientID = @"API KEY";

@implementation ViewController

@synthesize service = _service;
@synthesize output = _output;

// When the view loads, create necessary subviews, and initialize the Drive API service.
- (void)viewDidLoad {
    [super viewDidLoad];
 
    // Initialize the Drive API service & load existing credentials from the keychain if available.
    self.service = [[GTLServiceDrive alloc] init];
    
    // Check for authorization.
    GTMOAuth2Authentication *auth =
    [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName
                                                          clientID:kClientID
                                                      clientSecret:nil];
    if ([auth canAuthorize]) {
           [self.service setAuthorizer:auth];
    }
 
}

- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (error == nil) {
          [self.service setAuthorizer:auth];
    }
}

// When the view appears, ensure that the Drive API service is authorized, and perform API calls.
- (void)viewDidAppear:(BOOL)animated {
    if (!self.service.authorizer.canAuthorize) {
        // Not yet authorized, request authorization by pushing the login UI onto the UI stack.
        [self presentViewController:[self createAuthController] animated:YES completion:nil];
        
    } else {
//        [self fetchFiles];
        [self searchFileContent];
    }
}
//
//// Construct a query to get names and IDs of 10 files using the Google Drive API.
//- (void)fetchFiles {
//    self.output.text = @"Getting files...";
//    GTLQueryDrive *query =
//    [GTLQueryDrive queryForFilesList];
//    query.pageSize = 10;
//    query.fields = @"nextPageToken, files(id, name)";
//    [self.service executeQuery:query
//                      delegate:self
//             didFinishSelector:@selector(displayResultWithTicket:finishedWithObject:error:)];
//}
//
//// Process the response and display output.
//- (void)displayResultWithTicket:(GTLServiceTicket *)ticket
//             finishedWithObject:(GTLDriveFileList *)response
//                          error:(NSError *)error {
//    if (error == nil) {
//        NSMutableString *filesString = [[NSMutableString alloc] init];
//        if (response.files.count > 0) {
//            [filesString appendString:@"Files:\n"];
//            for (GTLDriveFile *file in response.files) {
//                [filesString appendFormat:@"%@ (%@)\n", file.name, file.identifier];
//                NSLog(@"the permission for file:%d",[file.writersCanShare intValue]);
//                
//                if([file.name isEqualToString:@"newTest"]){
//                    [self saveFile:file];
//                }
//                
//            }
//        } else {
//            [filesString appendString:@"No files found."];
//        }
//        self.output.text = filesString;
//    } else {
//        [self showAlert:@"Error" message:error.localizedDescription];
//    }
//}


// Creates the auth controller for authorizing access to Drive API.
- (GTMOAuth2ViewControllerTouch *)createAuthController {
    GTMOAuth2ViewControllerTouch *authController;
    // If modifying these scopes, delete your previously saved credentials by
    // resetting the iOS simulator or uninstall the app.
    NSArray *scopes = [NSArray arrayWithObjects:kGTLAuthScopeDriveFile, nil];
    authController = [[GTMOAuth2ViewControllerTouch alloc]
                      initWithScope:[scopes componentsJoinedByString:@" "]
                      clientID:kClientID
                      clientSecret:nil
                      keychainItemName:kKeychainItemName
                      delegate:self
                      finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    return authController;
}

// Helper for showing an alert
- (void)showAlert:(NSString *)title message:(NSString *)message {
    UIAlertView *alert;
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:message
                                      delegate:nil
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil];
    [alert show];
}

- (IBAction)pressButton:(id)sender {
    [self saveFile:[GTLDriveFile new]];
}


-(void)loadFileContent:(GTLDriveFile *) DriveFile{
    
    NSString *url = [NSString stringWithFormat:@"https://www.googleapis.com/drive/v3/files/%@?alt=media&mimeType=text/plain",
                     DriveFile.identifier];
    NSLog(@"load file content:%@",DriveFile);
    GTMSessionFetcher *fetcher =
    [self.service.fetcherService fetcherWithURLString:url];
    
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        
        if (error == nil) {
            NSString* fileContent = [[NSString alloc] initWithData:data
                                                          encoding:NSUTF8StringEncoding];
            
            NSLog(@"the content:%@",fileContent);
        } else {
            NSLog(@"An error occurred: %@", error);
            
        }
    }];
    
}

- (void)searchFileContent{
    
    NSString *search = @"name = 'newTest'";
    GTLQueryDrive *query = [GTLQueryDrive queryForFilesList];
    query.q = search;
    query.pageSize = 10;
    query.fields = @"nextPageToken, files(id, name)";
    [self.service executeQuery:query completionHandler:^(GTLServiceTicket *ticket,
                                                  GTLDriveFileList *fileList,
                                                  NSError *error) {
        if (error == nil) {
            NSLog(@"Have results:%lu",(unsigned long)fileList.files.count);
            if (fileList.files.count > 0) {
                for (GTLDriveFile *searchFile in fileList.files) {
                    self.file=searchFile;
                    break;
                }
            } else {
                //Could not be able to find the file
                [self saveFile:nil];
            }

        } else {
            NSLog(@"An error occurred: %@", error);
        }
    }];
 
}

- (void)saveFile:(GTLDriveFile *) DriveFile{
    GTLUploadParameters *uploadParameters = nil;
        NSData *fileContent = [@"Test: good got it!"
                               dataUsingEncoding:NSUTF8StringEncoding];
        uploadParameters = [GTLUploadParameters
                            uploadParametersWithData:fileContent
                            MIMEType:@"text/plain"];
    
   
    GTLQueryDrive *query = nil;
    if (DriveFile==nil) {
        NSLog(@"try to create file");
        DriveFile=[GTLDriveFile object];
        DriveFile.name=@"newTest";
        // This is a new file, instantiate an insert query.
        query = [GTLQueryDrive queryForFilesCreateWithObject:DriveFile
                                            uploadParameters:uploadParameters];
    } else {
        // This file already exists, instantiate an update query.

        NSLog(@"update query");
        NSLog(@"the file id:%@",self.file.identifier);
        
        GTLDriveFile * tmp=[GTLDriveFile object];
        
        query = [GTLQueryDrive
                 queryForFilesUpdateWithObject:tmp
                 fileId:self.file.identifier
                 uploadParameters:uploadParameters];
    }
 
    
    [self.service executeQuery:query
                  completionHandler:^(GTLServiceTicket *ticket,
                                      GTLDriveFile *updatedFile,
                                      NSError *error) {

                      if (!error) {
                          
                      } else {
                          NSLog(@"An error occurred: %@", error);
                      }
                  }];
}

@end