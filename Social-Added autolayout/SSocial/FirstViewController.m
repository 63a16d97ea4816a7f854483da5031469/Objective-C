//
//  FirstViewController.m
//  SSocial
//
//  Created by Cao Lei on 16/8/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

/*
 Used some useful autolayout:
 1. Center X.
 2. Set the distance to boarder to 0.
 3. Three buttons have same width(Equal Width) and the distance between them is 0(Horizontal space).
 4. Two components' Vertical space to 0
 5. Two components' Horizontal space to 0
 */



#import "FirstViewController.h"
#import "ListTableViewCell.h"

#define COLOR_BUTTON_BOARDER [UIColor colorWithRed:170.0f/255.0f green:170.0f/255.0f blue:170.0f/255.0f alpha:0.5f]


@interface FirstViewController ()

@end

@implementation FirstViewController
CGFloat screenWidth;
CGFloat screenheight;

UIButton *overLayButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    screenheight=[UIScreen mainScreen].bounds.size.height;
    [self addOverlayButton];
    [self.listtableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

-(void)setBottomBorderLine{
    CALayer* layer=[self.headerBackgroundLabel layer];
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderColor = [UIColor lightGrayColor].CGColor;
    bottomBorder.borderWidth = 1;
    
    /*
     This sentence is not workable after using autolayout
     bottomBorder.frame = CGRectMake(-1, layer.frame.size.height-1, layer.frame.size.width, 1);
     */
    
    bottomBorder.frame = CGRectMake(-1, layer.frame.size.height-1, screenWidth, 1);
    [bottomBorder setBorderColor:[UIColor lightGrayColor].CGColor];
    [layer addSublayer:bottomBorder];
    
}

//Change related variable's value when screen is rotated.
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        NSLog(@"the screen size: h  %f",[UIScreen mainScreen].bounds.size.width);
        screenWidth = [UIScreen mainScreen].bounds.size.width;
        screenheight=[UIScreen mainScreen].bounds.size.height;
        overLayButton.frame= CGRectMake(screenWidth-70, screenheight-120, 56.0, 56.0);
        [self setBottomBorderLine];

    }
    else
    {
        NSLog(@"the screen size: v %f",[UIScreen mainScreen].bounds.size.width);
        screenWidth = [UIScreen mainScreen].bounds.size.width;
        screenheight=[UIScreen mainScreen].bounds.size.height;
        overLayButton.frame= CGRectMake(screenWidth-70, screenheight-120, 56.0, 56.0);
        [self setBottomBorderLine];
    }
    [self.listtableview reloadData];
}


- (void)addOverlayButton {
    overLayButton = [[UIButton alloc] init];
    overLayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    overLayButton.frame = CGRectMake(screenWidth-70, screenheight-120, 56.0, 56.0);
    overLayButton.backgroundColor = [UIColor clearColor];
    [overLayButton setImage:[UIImage imageNamed:@"ic_th_send_normal"] forState:UIControlStateNormal];
    [overLayButton setImage:[UIImage imageNamed:@"ic_th_send_press"] forState:UIControlStateHighlighted];
    [overLayButton addTarget:self action:@selector(addPost:) forControlEvents:UIControlEventTouchDown];
    [self.view insertSubview:overLayButton aboveSubview:self.view];
}

-(void)addPost:(id *)sender{
    NSLog(@"The button pressed!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTableViewCell *cell=(ListTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"listcell" forIndexPath:indexPath];
    
    [cell.button1.layer setBorderWidth:1.0];
    [cell.button1.layer setBorderColor:[COLOR_BUTTON_BOARDER CGColor]];
    
    
    [cell.button2.layer setBorderWidth:1.0];
    [cell.button2.layer setBorderColor:[COLOR_BUTTON_BOARDER CGColor]];
    

//This is another way to draw the button2's border:
    
//    CALayer* layer=[cell.button2 layer];
//    
//    CALayer *bottomBorder = [CALayer layer];
//    bottomBorder.borderColor = [COLOR_BUTTON_BOARDER CGColor];
//    bottomBorder.borderWidth = 1;
//    bottomBorder.frame = CGRectMake(0, layer.frame.size.height-1, screenWidth/3, 1);
//
//    
//    CALayer *headBorder = [CALayer layer];
//    headBorder.borderColor = [COLOR_BUTTON_BOARDER CGColor];
//    headBorder.borderWidth = 1;
//    headBorder.frame = CGRectMake(0, 0, screenWidth/3, 1);
//    
//    [layer addSublayer:headBorder];
//    [layer addSublayer:bottomBorder];
    

    [cell.button3.layer setBorderWidth:1.0];
    [cell.button3.layer setBorderColor:[COLOR_BUTTON_BOARDER CGColor]];
    
    return cell;
}

@end
