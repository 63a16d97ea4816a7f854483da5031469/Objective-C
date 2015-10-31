//
//  MainViewController.m
//  InterviewQuestionForBigO
//
//  Created by Cao Lei on 22/10/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import "MainViewController.h"
#import "CustomCell.h"

#define CELL_ID @"customCell"

@interface MainViewController ()

@end

@implementation MainViewController
    NSMutableDictionary *tmpDic;

// You can set values for Non-Object, but you cannot set value for object or init the object
    unsigned long long recusionRunTimes=0;

- (void)viewDidLoad {
    [super viewDidLoad];
    tmpDic=[[NSMutableDictionary alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomCell *cell=(CustomCell*)[self.CustomTableView dequeueReusableCellWithIdentifier:CELL_ID];

    //1 by using recusion:
//    cell.titleLabel.text=[NSString stringWithFormat:@"%d",[self getF:indexPath.row]];
    
    //2 by using loop:
//    cell.titleLabel.text=[NSString stringWithFormat:@"%d",[self getFbyUsingLoop:indexPath.row]];
    
    //3 by using loop and modified the type of variable
//    NSMutableDictionary *tmpDic=[[NSMutableDictionary alloc] init];
//    [tmpDic setObject:[NSNumber numberWithInt:0] forKey:[NSNumber numberWithInteger:indexPath.row]];
    
//    cell.titleLabel.text=[NSString stringWithFormat:@"%llu, loop times:%@",[self getFbyUsingLoopModifiedType:indexPath.row],(NSNumber*)[tmpDic objectForKey:[NSNumber numberWithInteger:indexPath.row]]];
    
    //4 by using recusion and count the run times:
    cell.titleLabel.text=[NSString stringWithFormat:@"%llu, loop times:%@",[self getFandCountRunTimes:indexPath.row],(NSNumber*)[tmpDic objectForKey:[NSNumber numberWithInteger:indexPath.row]]];
//    NSLog(@"the dic:%@",tmpDic);
    
    return cell;
}


//by using recusion and count the run times:
-(unsigned long long) getFandCountRunTimes:(unsigned long long) n{
    
    unsigned long long tmpResult=0;
    
    if(n==0) {
//    [tmpDic setObject:[NSNumber numberWithUnsignedLongLong:recusionRunTimes] forKey:[NSNumber numberWithUnsignedLongLong:n]];
        NSLog(@"the run time:%llu",recusionRunTimes);
        
//    recusionRunTimes=0;
    return 1;
    }else if(n==1) {return 1;
        
    }else {
        tmpResult=[self getFandCountRunTimes:n-1]+[self getFandCountRunTimes:n-2];
        recusionRunTimes++;
    }
    
 
    
    return tmpResult;
}



//By using Loop and unsigned long long
-(unsigned long long) getFbyUsingLoopModifiedType:(unsigned long long) n{
    
//    if(n==0||n==1) {
//        return 1;}
    //In order to mark the loop times, I modified the code to below:
    unsigned long long runTimes=0;
    
    
    if(n==0){
        runTimes=0;
        return 1;
    }else if(n==1) return 1;
    
    unsigned long long i=1;
    unsigned long long j=1;
    unsigned long long tmpResult=0;
    
    for(int y=2;y<=n;y++){
        tmpResult=i+j;
        j=i;
        i=tmpResult;
        runTimes++;
    }
    
    [tmpDic setObject:[NSNumber numberWithUnsignedLongLong:runTimes] forKey:[NSNumber numberWithUnsignedLongLong:n]];
    
    return tmpResult;
}


//By using Loop  ----> Very fast, but some value become negative.
-(int) getFbyUsingLoop:(int) n{
    
    if(n==0||n==1) return 1;
    
    int i=1;
    int j=1;
    int tmpResult=0;
    for(int y=2;y<=n;y++){
        tmpResult=i+j;
        j=i;
        i=tmpResult;
    }
    return tmpResult;
}

//By using recusion  ----> Very slow.
-(int) getF:(int) n{
    
    
    if(n==0||n==1) return 1;
    
    /*
     This sentence will encounter error.   Java programmer---LOL
     int tmp=getF(n-1)+getF(n-2);
    */
    
//    NSInteger tmp=[self getF:n-1]+[self getF:n-2];
    
    return [self getF:n-1]+[self getF:n-2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
