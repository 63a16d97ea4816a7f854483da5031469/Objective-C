//
//  ViewController.m
//  TableViewPractise
//
//  Created by Cao Lei on 24/10/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

/*
 I created this from zero to practise the basic programming skills about TableView.
 
 It takes me 7 minutes and 10 seconds.
 */

#import "CustomTableCell.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomTableCell *cell=(CustomTableCell*)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.titleLabel.text=@"mytext";
    
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
