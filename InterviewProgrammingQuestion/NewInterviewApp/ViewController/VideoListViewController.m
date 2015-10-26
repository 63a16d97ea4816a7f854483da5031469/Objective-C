//
//  ViewController.m
//  NewInterviewApp
//
//  Created by Cao Lei on 16/10/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//
#import "VideoDetailViewController.h"
#import "VideoListViewController.h"
#import "CustomTableViewCell.h"
#import "VideoEntity.h"
#import "LocalHelper.h"
#import "ImageHelper.h"
#import "APIHelper.h"


#define VIDEO_CELL @"videoCell"

@interface VideoListViewController ()

@end

@implementation VideoListViewController
NSMutableArray *contentSource;
BOOL editFlag;

-(void) initView{
    editFlag=NO;
    self.title=@"Videos";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editAction)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    contentSource=[APIHelper getContentSets];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(contentSource!=nil)
    return contentSource.count;
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:VIDEO_CELL];

    if(contentSource!=nil){
        
    VideoEntity* entity=(VideoEntity *)[contentSource objectAtIndex:indexPath.row];

    cell.titleLabel.text=cell.descriptionLabel.text=[LocalHelper getLocalLanguageForKey:entity Key:@"title"];
    [ImageHelper setImage:cell.videoImageView withUrl:entity.videoImageURL];
    cell.descriptionLabel.text=[LocalHelper getLocalLanguageForKey:entity Key:@"description"];
    }
    
    return cell;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.destinationViewController class]==[VideoDetailViewController class]) {
        VideoDetailViewController* destViewController = (VideoDetailViewController*)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [destViewController setVideoContent:[contentSource objectAtIndex:indexPath.row]];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *stringToMove = [contentSource objectAtIndex:sourceIndexPath.row];
    
    [contentSource removeObjectAtIndex:sourceIndexPath.row];
    [contentSource insertObject:stringToMove atIndex:destinationIndexPath.row];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [contentSource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (void)editAction
{
        if(!editFlag){
            self.tableView.editing=YES;
            editFlag=YES;
        }else{
            self.tableView.editing=NO;
            editFlag=NO;
        }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
