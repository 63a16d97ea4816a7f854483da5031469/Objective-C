//
//  NoteViewController.m
//  PlanList
//
//  Created by Cao Lei on 25/5/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import "NoteViewController.h"
#import "MessageObject.h"

@interface NoteViewController ()

@end

@implementation NoteViewController

NSMutableArray* sentences;
BOOL editFlag=NO;

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"start");
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EditListNotification:) name:@"com.my.edit.first.table" object:nil];
    
    
    if(!sentences){
    sentences=[[NSMutableArray alloc] init];
    [sentences addObject:[[MessageObject alloc] init:@"2015年的目标" Content:@"1.拥有强大的身心,每天健身（上肢和下肢都有强大肌肉）2. 努力练习编程"]];
    }
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text=[[sentences objectAtIndex:indexPath.row] messageTitle];
    
    
    cell.textLabel.font=[UIFont boldSystemFontOfSize:10.0f];
    cell.textLabel.textColor=[UIColor blueColor];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(![[[sentences objectAtIndex:indexPath.row] messageContent] isEqualToString:@""]){
        NSString* dialogTitle = @"Message";
        NSString* dialogMessage =[[sentences objectAtIndex:indexPath.row] messageContent];
        NSString* ok = @"Smile";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:dialogTitle
                                                        message:dialogMessage delegate:nil cancelButtonTitle: ok
                                              otherButtonTitles: nil];
        [alert show];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return sentences.count;
}


//adding reorder code--begin
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *stringToMove = [sentences objectAtIndex:sourceIndexPath.row];
    
    [sentences removeObjectAtIndex:sourceIndexPath.row];
    [sentences insertObject:stringToMove atIndex:destinationIndexPath.row];
}

//adding reorder code--end


//adding delete handler here --begin

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [sentences removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

//adding delete handler here --end

 
//the 'Edit' button:
- (void)EditListNotification:(NSNotification *)notif {
    NSLog(@"press");
    if(!editFlag){
    self.noteTableview.editing=YES;
        editFlag=YES;
    }else{
        self.noteTableview.editing=NO;
        editFlag=NO;
    }
}

@end