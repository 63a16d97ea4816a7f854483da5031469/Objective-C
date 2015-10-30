//
//  ViewController.m
//  CollectionView-Practice
//
//  Created by Cao Lei on 21/10/15.
//  Copyright (c) 2015 Cao Lei. All rights reserved.
//


/*
This is for creating new Collection View from zero
To make sure I really understand all the necessary detail about Collection View.
 */


#import "ViewController.h"
#import "CustomCollectionCell.h"

#define CELL_ID @"collectionCell"

@interface ViewController ()
@end

@implementation ViewController


-(void) viewDidLoad{
    [super viewDidLoad];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.CustomCollectionView deselectItemAtIndexPath:indexPath animated:YES];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 31;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomCollectionCell *cell=(CustomCollectionCell*)[self.CustomCollectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];

    cell.Titlelabel.text=[NSString stringWithFormat:@"[r,s]:%d,%d",indexPath.row,indexPath.section];

    cell.CustomImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",indexPath.row]];
    
//    NSLog(@"[row,section]:%d,%d",indexPath.row,indexPath.section);
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
