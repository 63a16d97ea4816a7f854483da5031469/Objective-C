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
@property (strong, nonatomic) IBOutlet UITableView *tableViewObj;

@end


CGFloat screenWidth;
CGFloat screenheight;
CGFloat originalY=0;

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    screenheight=[UIScreen mainScreen].bounds.size.height;
    originalY=screenheight-120;
    [self addOverlayButton];
}


#pragma mark Camera Button
- (void)addOverlayButton {
    
    self.oButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.oButton.frame = CGRectMake(screenWidth-70, originalY, 56.0, 56.0);
    self.oButton.backgroundColor = [UIColor clearColor];
    [self.oButton setImage:[UIImage imageNamed:@"ic_th_current_normal.png"] forState:UIControlStateNormal];
    [self.oButton setImage:[UIImage imageNamed:@"ic_th_current_press.png"] forState:UIControlStateHighlighted];
    [self.oButton addTarget:self action:@selector(zoomToCurrentLocation:) forControlEvents:UIControlEventTouchDown];
    [self.view insertSubview:self.oButton aboveSubview:self.view];
}

// to make the button float over the tableView including tableHeader
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect tableBounds = self.tableView.bounds;
    CGRect floatingButtonFrame = self.oButton.frame;
    floatingButtonFrame.origin.y = originalY + tableBounds.origin.y;
    self.oButton.frame = floatingButtonFrame;
    
    [self.view bringSubviewToFront:self.oButton]; // float over the tableHeader
}

-(void)zoomToCurrentLocation:(id *)sender{
    NSLog(@"press the button");
    
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
    
    return 2;
    
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
