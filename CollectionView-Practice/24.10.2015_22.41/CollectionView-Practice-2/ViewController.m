//
//  ViewController.m
//  CollectionView-Practice-2
//
//  Created by Cao Lei on 24/10/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//

/*
 In order to have solid programming skills, I created this project to
 practise the basic programming skill about creating CollectionView from zero.
 
 It takes me 5 minutes 27 seconds.
 
 */


#import "ViewController.h"
#import "CustomCollectionCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionCell *cell=(CustomCollectionCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    cell.titleLabel.text=@"mycell";
    
    return cell;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
