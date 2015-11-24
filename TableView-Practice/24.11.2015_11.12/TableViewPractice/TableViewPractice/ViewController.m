//
//  ViewController.m
//  TableViewPractice
//
//  Created by Cao Lei on 24/11/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 1. Create the UITableView by using storyboard
 2. Modify the root control(by moving the arrow)
 3. Modify the ViewController.h to UITableViewController
 4. Linked the MainStoryboard TableView to the file(ViewController)
 5. Create the CustomTableCell.h and CustomTableCell.m.
 6. Fill in the content of the CustomTableCell.h and CustomTableCell.m
 7. Linked the mainStoryboard TableViewCell to the file(CustomTableCell)
 8. Add one UILabel into the TableViewCell by using Storyboard.
 9. Create the Outlet of UILabel to the file(CustomTableCell.h)
 10. Modify the Identifier of TableViewCell to "cell";
 11. Modify the code of ViewController to add two required methods:
 numberOfRowsInSection
 cellForRowAtIndexPath
 ---> Consider the cell==nil situation.
 To use the dequeueReusableCellWithIdentifier:@"cell"
 12.run it.
 */


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomTableCell *cell=(CustomTableCell*)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell==nil){
        cell=[[CustomTableCell alloc] init];
        cell.titleLabel.text=@"fds";
    }
        cell.titleLabel.text=@"fds";
    
    
    
    return cell;
}


@end
