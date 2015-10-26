//
//  MainViewController.m
//  PlanList
//
//  Created by Cao Lei on 25/5/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

#import "MainViewController.h"
#import "PlanList.h"
#import "ListsOfPlanListViewController.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "NoteViewController.h"
#import "CLLockVC.h"

#define HEIGHT_CELL_NORMAL 80

@implementation MainViewControllerTableCell
BOOL maineditFlag=NO;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.isLineBreak = YES;
        
        self.lineImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line.png"]];
        _lineImage.frame = CGRectMake(20, 0, 320 - 40, 44);
        [self addSubview:_lineImage];
        
        NSLog(@"cell alloc");
    }
    
    return  self;
}

@end

@interface MainViewController () <ListsOfPlanListViewControllerDelegate, UINavigationControllerDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)UISearchBar * searchBar;
@property(nonatomic, strong)UISearchDisplayController * searchDisplay;
@property(nonatomic, strong)NSMutableArray * filterArray;
@end

@implementation MainViewController
NSMutableArray* cellsArray;
BOOL flipFLag=NO;
static  NoteViewController *vc;

- (id)init
{
    if (self = [super init]) {
        self.data = [[DataModel alloc] init];
        self.filterArray = [NSMutableArray array];
        
        self.title = @"Plan List";
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIBarButtonItem *LeftButton=[[UIBarButtonItem alloc] initWithTitle:@"Note" style:	UIBarButtonSystemItemAction target:self action:@selector(LeftButtonAction:)];
    
    [self.navigationItem setLeftBarButtonItem:LeftButton];
    self.navigationController.delegate = self;
}

-(void)LeftButtonAction:(id)sender{
    
    if(!flipFLag){
    [UIView beginAnimations:@"filpping view" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    
    [self.view addSubview:vc.view];
    
    [UIView commitAnimations];
        flipFLag=!flipFLag;
        
        UIBarButtonItem *firstItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(AddlistToNoteList)];
        
        UIBarButtonItem *secondItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(EditFirstList)];
        
        NSArray *items=[[NSArray alloc] initWithObjects:firstItem,secondItem,nil];
        
        self.navigationItem.rightBarButtonItems=items;
        
    }else{
        
    [UIView beginAnimations:@"filpping view" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view.superview cache:YES];

    [vc.view removeFromSuperview];
     flipFLag=!flipFLag;
    [UIView commitAnimations];
        UIBarButtonItem *firstItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddlistToPlanList)];
        
        UIBarButtonItem *secondItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(EditSecondList)];
        
        NSArray *items=[[NSArray alloc] initWithObjects:firstItem,secondItem,nil];
        
        self.navigationItem.rightBarButtonItems=items;
    }
}
 
#pragma - 手势处理, 右划添加删除线
/*
 * 1> 也可用绘图实现，需自定义tableView，重写其 DrawRect: 方法，在里面去计算具体该画在哪一行
 * 2> 使用cell中添加图片来实现时，应该自定义cell，删除线图片作为其内部属性，否则会出现重复添加
 */
- (void)swipeAtCell:(UISwipeGestureRecognizer *)gesture
{

    BOOL hasPwd = [CLLockVC hasPwd];
    
    if(hasPwd){
        
        //        [CLLockVC showVerifyLockVCInVC:<#(UIViewController *)#> forgetPwdBlock:nil successBlock:<#^(CLLockVC *lockVC, NSString *pwd)successBlock#>]
        
        [CLLockVC showVerifyLockVCInVC:self.navigationController forgetPwdBlock:nil successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            NSLog(@"密码正确");
            [lockVC dismiss:0.0f];
        }];
        
    }else{
        
        [CLLockVC showSettingLockVCInVC:self.navigationController successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            NSLog(@"密码设置成功");
            [lockVC dismiss:0.0f];
        }];
        
    }
    
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGContextMoveToPoint(ctx, 50, 50);
    CGContextAddLineToPoint(ctx, 200, 200);
    CGContextDrawPath(ctx, kCGPathStroke);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard"
                                                         bundle: nil];
    
    vc = [storyboard instantiateViewControllerWithIdentifier:@"NoteViewController"];
    
    
    self.tableView.separatorStyle=NO;
    cellsArray=[[NSMutableArray alloc] init];
    
    for(int i=0;i<100;i++){
            [cellsArray addObject:@"0"];
      }
 
    UIBarButtonItem *firstItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddlistToPlanList)];
    
    UIBarButtonItem *secondItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(EditSecondList)];
    
    NSArray *items=[[NSArray alloc] initWithObjects:firstItem,secondItem,nil];
    
    self.navigationItem.rightBarButtonItems=items;
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    // 手势处理
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAtCell:)];
    swipe.numberOfTouchesRequired = 1;
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.tableView addGestureRecognizer:swipe];
    
    // 手动设置搜索条
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectZero];
    self.searchBar.showsScopeBar = NO;
    [self.searchBar sizeToFit];
    self.searchBar.placeholder = @"请输入要搜素的内容";
    self.searchBar.scopeButtonTitles = @[@"All"];
    self.searchBar.delegate = self;
    self.tableView.tableHeaderView = _searchBar;
    
    UISearchDisplayController * searchDisplay = [[UISearchDisplayController alloc]initWithSearchBar:_searchBar contentsController:self];
    searchDisplay.delegate = self;
    searchDisplay.searchResultsDelegate = self;
    searchDisplay.searchResultsDataSource = self;
    self.searchDisplay = searchDisplay;
    
    // 搜素栏初始隐藏
    self.tableView.contentOffset = CGPointMake(0, CGRectGetHeight(_searchBar.bounds));
    
    CALayer * layer = [CALayer layer];
    layer.bounds = self.view.bounds;
    layer.position = CGPointZero;
    layer.delegate = self;
    [layer setNeedsDisplay];
    [self.view.layer addSublayer:layer];
}

//the + button for note list

-(void)AddlistToNoteList{
    
    BOOL hasPwd = [CLLockVC hasPwd];
    if(hasPwd){
        
        [CLLockVC showVerifyLockVCInVC:self.navigationController forgetPwdBlock:nil successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            NSLog(@"密码正确");
            [lockVC dismiss:0.0f];
        }];
    }else{
        
        [CLLockVC showSettingLockVCInVC:self.navigationController successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            NSLog(@"密码设置成功");
            [lockVC dismiss:0.0f];
        }];
        
    }
    
    
}



//the + button:
- (void)AddlistToPlanList
{
    ListsOfPlanListViewController * listsOfPlanList = [[ListsOfPlanListViewController alloc] initWithStyle:UITableViewStyleGrouped];
    listsOfPlanList.delegate = self;
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:listsOfPlanList];
    
    [self presentViewController:nav animated:YES completion:nil];
}


//the 'Edit' button:
- (void)EditFirstList
{
[[NSNotificationCenter defaultCenter] postNotificationName:@"com.my.edit.first.table" object:self];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    return HEIGHT_CELL_NORMAL;
}

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope
{
    [self.filterArray removeAllObjects];
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF.listTitle contains[c] %@", searchText];
    NSArray * tempArray = [_data.lists filteredArrayUsingPredicate: predicate];
    if (![scope isEqual:@"All"]) {
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF.listIconName contains[c] %@", scope];
        tempArray = [tempArray filteredArrayUsingPredicate: predicate];
    }
    
    _filterArray = [tempArray mutableCopy];
}

#pragma - UISearchBar Delegate



//the 'Edit' button:
- (void)EditSecondList{
    if(!maineditFlag){
        self.tableView.editing=YES;
        maineditFlag=YES;
    }else{
        self.tableView.editing=NO;
        maineditFlag=NO;
    }
}

//adding reorder code--begin
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *stringToMove = [_data.lists objectAtIndex:sourceIndexPath.row];
    
    [_data.lists removeObjectAtIndex:sourceIndexPath.row];
    [_data.lists insertObject:stringToMove atIndex:destinationIndexPath.row];

}

//adding reorder code--end

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{

    [self filterContentForSearchText:self.searchDisplayController.searchBar.text
                               scope:self.searchDisplayController.searchBar.scopeButtonTitles[searchOption]];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{

    [self filterContentForSearchText:searchString
                               scope:self.searchDisplayController.searchBar.scopeButtonTitles[self.searchDisplayController.searchBar.selectedScopeButtonIndex]];
    return YES;
}

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    NSLog(@"searchDisplayControllerWillBeginSearch:%@", controller);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        count = (int)_filterArray.count;
    }
    else{
        count = (int)_data.lists.count;
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Cell";
    MainViewControllerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[MainViewControllerTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identifier];
        
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    PlanList * list;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        list = (PlanList *)(_filterArray[indexPath.row]);
    }
    else{
        list = (PlanList *)(_data.lists[indexPath.row]);
    }
    
    cell.imageView.image = [UIImage imageNamed: list.listIconName];
    cell.textLabel.text = list.listTitle;
 
    [cell.lineImage setHidden:cell.isLineBreak];
    
    if([[cellsArray objectAtIndex:indexPath.row] isEqualToString:@"1"]){
        cell.detailTextLabel.text=@"√";
        cell.detailTextLabel.textColor=[UIColor whiteColor];
        cell.detailTextLabel.backgroundColor=[UIColor clearColor];
        cell.textLabel.backgroundColor=[UIColor clearColor];
        cell.textLabel.textColor=[UIColor whiteColor];
        
        //set the gradient background colour:
        CAGradientLayer *grad = [CAGradientLayer layer];
        grad.frame = cell.bounds;
        grad.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:2/255.0 green:124/255.0 blue:255/255.0 alpha:1.0] CGColor], (id)[[UIColor colorWithRed:57/255.0 green:177/255.0 blue:255/255.0 alpha:1.0] CGColor], nil];
        [cell setBackgroundView:[[UIView alloc] init]];
        [cell.backgroundView.layer insertSublayer:grad atIndex:indexPath.row];
        
        CAGradientLayer *selectedGrad = [CAGradientLayer layer];
        selectedGrad.frame = cell.bounds;
        selectedGrad.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
        [cell setSelectedBackgroundView:[[UIView alloc] init]];
        [cell.selectedBackgroundView.layer insertSublayer:selectedGrad atIndex:indexPath.row];
        //end
    }else{
        cell.detailTextLabel.text=@"";
        cell.textLabel.textColor=[UIColor blackColor];
        cell.backgroundColor=[UIColor clearColor];
        [cell setBackgroundView:[[UIView alloc] init]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    ListsOfPlanListViewController * listsController = [[ListsOfPlanListViewController alloc]initWithStyle:UITableViewStyleGrouped];
    listsController.delegate = self;
    listsController.list = _data.lists[indexPath.row];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:listsController];
    [self presentViewController:nav animated:YES completion:nil];
}


-(void)movetheArrayValueToEndWithStepOne:(NSMutableArray*) passArray{
    NSString* nextStr=[passArray objectAtIndex:0];
    for (int i=0;i<passArray.count-1; i++) {
        NSString* tmp=nextStr;
        nextStr=[passArray objectAtIndex:i+1];
        [passArray replaceObjectAtIndex:i+1 withObject:tmp];
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([[cellsArray objectAtIndex:indexPath.row] isEqualToString:@"-1"]){
        [cellsArray replaceObjectAtIndex:indexPath.row withObject:@"0"];
    }else if([[cellsArray objectAtIndex:indexPath.row] isEqualToString:@"0"]){
        [cellsArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
    }else{
        [cellsArray replaceObjectAtIndex:indexPath.row withObject:@"0"];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
 
    [self.tableView reloadData];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_data.lists removeObjectAtIndex:indexPath.row];
        [cellsArray replaceObjectAtIndex:indexPath.row withObject:@"-1"]; 
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - ItemsOfPlanListViewController Delegate

- (void)ListsOfPlanListController:(ListsOfPlanListViewController *)controller didFinishAddPlanList:(PlanList *)list
{
    [self.data.lists insertObject:list atIndex:0];
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    
    NSInteger index = [_data.lists indexOfObject:list];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self movetheArrayValueToEndWithStepOne:cellsArray];
    [cellsArray replaceObjectAtIndex:indexPath.row withObject:@"-1"];
    [self.tableView reloadData];
}

- (void)ListsOfPlanListController:(ListsOfPlanListViewController *)controller didFinishEditPlanList:(PlanList *)list
{
    NSInteger index = [_data.lists indexOfObject:list];
    _data.lists[index] = list;
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)ListsOfPlanListControllerDidCancel:(ListsOfPlanListViewController *)controller
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UINavigationController Delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self) {
        [self.data setIndexOfSelectedPlanlist:-1];
    }
}

@end
