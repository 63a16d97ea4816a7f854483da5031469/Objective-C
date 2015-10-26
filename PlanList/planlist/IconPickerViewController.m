//
//  IconPickerViewController.m
//  PlanList
//
//  Created by Cao Lei on 25/5/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import "IconPickerViewController.h"

@interface IconPickerViewController ()
@property(nonatomic, strong) NSArray * icons;
@property(nonatomic, strong) NSMutableArray * iconFiles;
@end

@implementation IconPickerViewController
@synthesize iconFiles;
@synthesize icons;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Icon pick";
    
    self.icons = @[@"Today",@"Love", @"Progress", @"English", @"Career", @"EatAndDrink",
                   @"LOL", @"Smile", @"Bible", @"Trips",@"Future",@"Run"];
    
    for(int i=0;i<self.icons.count;i++){
        [self.iconFiles addObject:[NSString stringWithFormat:@"%d",i+1]];
    }
}

- (void)IconPickCancel
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return icons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identifier];
    }

    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",indexPath.row+1]];
 
    cell.textLabel.text = icons[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.delegate IconPickerViewController:self DidFinishPickIcon:[NSString stringWithFormat:@"%d",indexPath.row+1]];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
