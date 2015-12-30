//
//  ViewController.m
//  JsonObjectMapping
//
//  Created by Lei Cao on 30/12/15.
//  Copyright © 2015 Lei Cao. All rights reserved.
//

#import "ViewController.h"
#import "JSONModel+networking.h"
#import "KivaFeed.h"
#import "DirectoryListingFeed.h"

@interface ViewController (){

KivaFeed* feed;


double benchStart;
double benchObj;
double benchEnd;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [JSONHTTPClient getJSONFromURLWithString:@"https://api.kivaws.org/v1/loans/search.json"
                                      params:@{@"status":@"fundraising"}
                                  completion:^(NSDictionary *json, JSONModelError *err) {
                                      
                                      benchStart = CFAbsoluteTimeGetCurrent();
                                      feed = [[KivaFeed alloc] initWithDictionary: json error:nil];
                                      benchEnd = CFAbsoluteTimeGetCurrent();
                                      
//                                      [HUD hideUIBlockingIndicator];
                                      
                                      if (feed) {
                                          NSLog(@"the json Object:%@",feed);
                                          
//                                          [table reloadData];
                                          
//                                          [self logBenchmark];
                                      } else {
                                          //show error
                                          [[[UIAlertView alloc] initWithTitle:@"Error"
                                                                      message:[err localizedDescription]
                                                                     delegate:nil
                                                            cancelButtonTitle:@"Close"
                                                            otherButtonTitles:nil] show];
                                      }
                                  }];
    
    
    //post method:
    
//    [JSONHTTPClient postJSONFromURLWithString:@"xxxxxxx"
//                                      params:@{@"xxxx":@"xxxxxx",@"xxxxx":@"xxxxx"}
//                                  completion:^(NSDictionary *json, JSONModelError *err) {
//                                      
//        
//                           DirectoryListingFeed    *DirectoryFeed = [[DirectoryListingFeed alloc] initWithDictionary: json error:nil];
//      
//                                      
//                                      //                                      [HUD hideUIBlockingIndicator];
//                                      
//                                      if (DirectoryFeed) {
//                                          NSLog(@"the DirectoryFeed json Object:%@",DirectoryFeed);
//                                          
//                                          //                                          [table reloadData];
//                                          
//                                          //                                          [self logBenchmark];
//                                      } else {
//                                          //show error
//                                          [[[UIAlertView alloc] initWithTitle:@"Error"
//                                                                      message:[err localizedDescription]
//                                                                     delegate:nil
//                                                            cancelButtonTitle:@"Close"
//                                                            otherButtonTitles:nil] show];
//                                      }
//                                  }];
    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
