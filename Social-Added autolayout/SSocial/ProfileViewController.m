//
//  SecondViewController.m
//  SSocial
//
//  Created by Cao Lei on 16/8/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileSecondaryTableViewCell.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

CGFloat ScreenWidth;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ScreenWidth = [UIScreen mainScreen].bounds.size.width;
    [self setHeaderBottomLine];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setHeaderBottomLine{
    CALayer* layer=[self.profileHeaderLabel layer];
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderColor = [UIColor lightGrayColor].CGColor;
    bottomBorder.borderWidth = 1;
    /*
     After using autolayout, even you use the
     bottomBorder.frame = CGRectMake(-1, layer.frame.size.height-1, layer.frame.size.width, 1);
     */
    bottomBorder.frame = CGRectMake(-1, layer.frame.size.height-1, ScreenWidth, 1);
    [bottomBorder setBorderColor:[UIColor lightGrayColor].CGColor];
    [layer addSublayer:bottomBorder];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0&&indexPath.row==0){
        return 70;
    }
    
    return 62;
}



//Add footer --begin
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if(section==0) return 10;
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *hView = [[UIView alloc] initWithFrame:CGRectZero];
    hView.backgroundColor=[UIColor clearColor];
    
    UILabel *hLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,0,320,10)];
    
    hLabel.backgroundColor=[UIColor clearColor];
 
    
    
    [hView addSubview:hLabel];
    
    return hView;
}

//Add footer --end



//Change related variable's value when screen is rotated.
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        NSLog(@"the screen size: h  %f",[UIScreen mainScreen].bounds.size.width);
        ScreenWidth = [UIScreen mainScreen].bounds.size.width;
        [self setHeaderBottomLine];
    }
    else
    {
        NSLog(@"the screen size: v %f",[UIScreen mainScreen].bounds.size.width);
        ScreenWidth = [UIScreen mainScreen].bounds.size.width;
        [self setHeaderBottomLine];
    }
    [self.profileTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//Add header --begin
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0) return 0;
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *hView = [[UIView alloc] initWithFrame:CGRectZero];
    hView.backgroundColor=[UIColor clearColor];
    
    UILabel *hLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,0,320,21)];
    
    hLabel.backgroundColor=[UIColor clearColor];
    hLabel.shadowColor = [UIColor whiteColor];
    hLabel.shadowOffset = CGSizeMake(0.5,1);
    hLabel.textColor = [UIColor colorWithRed:44.0f/255.0f green:151.0f/255.0f blue:220.0f/255.0f alpha:1.0];
    hLabel.font = [UIFont boldSystemFontOfSize:15];
    hLabel.text = @"  通知";
    

    CALayer* layer=[hLabel layer];
    hLabel.frame=layer.bounds;
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderColor = [UIColor lightGrayColor].CGColor;
    bottomBorder.borderWidth = 1;
    bottomBorder.frame = CGRectMake(-1, layer.frame.size.height-1, ScreenWidth, 1);
    [bottomBorder setBorderColor:[UIColor lightGrayColor].CGColor];
    [layer addSublayer:bottomBorder];
    
    [hView addSubview:hLabel];
    
    return hView;
}
//Add header --end

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 2;
    }
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if(indexPath.section==0&&indexPath.row==0){
        cell=(UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"nameCell" forIndexPath:indexPath];
    }else if(indexPath.section==0){
        cell=(UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"profileListCell" forIndexPath:indexPath];
        
    }else if(indexPath.section==1&&indexPath.row==0){
        
        ProfileSecondaryTableViewCell *mycell=(ProfileSecondaryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"profileListCell" forIndexPath:indexPath];
        mycell.icon.image=[UIImage imageNamed:@"ic_setting_notification_icon"];
        mycell.iconlabel.text=@"通知";
        cell=mycell;
        
    }else if(indexPath.section==1&&indexPath.row==1){
        ProfileSecondaryTableViewCell *mycell=(ProfileSecondaryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"profileListCell" forIndexPath:indexPath];
        mycell.icon.image=[UIImage imageNamed:@"ic_setting_self_service_icon"];
        mycell.iconlabel.text=@"服务";
        cell=mycell;
    }
    else if(indexPath.section==1&&indexPath.row==2){
        ProfileSecondaryTableViewCell *mycell=(ProfileSecondaryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"profileListCell" forIndexPath:indexPath];
        mycell.icon.image=[UIImage imageNamed:@"ic_setting_software_about_icon"];
        mycell.iconlabel.text=@"关于软件";
        cell=mycell;
    }
    else if(indexPath.section==1&&indexPath.row==3){
        ProfileSecondaryTableViewCell *mycell=(ProfileSecondaryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"profileListCell" forIndexPath:indexPath];
        mycell.icon.image=[UIImage imageNamed:@"ic_setting_exit_icon"];
        mycell.iconlabel.text=@"登出";
        cell=mycell;
    }
    return cell;
}

@end
