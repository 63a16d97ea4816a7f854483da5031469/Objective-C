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

//Add delete button --begin
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"Press the delete button!");
    }
}
//Add delete button --end

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomTableCell *cell=(CustomTableCell*)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.titleLabel.text=@"mytext";
    
    //Add in the 'More' button and configure the color of it.  --begin
    cell.delegate=self;
    [cell setConfigurationBlock:^(UIButton *deleteButton, UIButton *moreOptionButton, CGFloat *deleteButtonWitdh, CGFloat *moreOptionButtonWidth) {
        // Give the 'More' button a orange background every third row
        moreOptionButton.backgroundColor = [UIColor orangeColor];
        
    }];
    //Add in the 'More' button and configure the color of it.  --end
    
    return cell;
    
}

//Configure in the More button's title  --begin
- (NSString *)tableView:(UITableView *)tableView titleForMoreOptionButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"More";
}
//Configure in the More button's title  --end

//Configure in the More button's action  --begin
- (void)tableView:(UITableView *)tableView moreOptionButtonPressedInRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"press more button!");
}
//Configure in the More button's action  --end

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
