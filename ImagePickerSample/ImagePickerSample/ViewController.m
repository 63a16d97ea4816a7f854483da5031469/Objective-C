//
//  ViewController.m
//  ImagePickerSample
//
//  Created by Lei Cao on 30/6/16.
//  Copyright © 2016 Lei Cao (Tony). All rights reserved.
//

#import "ViewController.h"
#import "AssetHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onShowImagePicker:(id)sender
{
    
    DoImagePickerController *cont = [[DoImagePickerController alloc] initWithNibName:@"DoImagePickerController" bundle:nil];
    cont.delegate = self;
    cont.nResultType = DO_PICKER_RESULT_UIIMAGE;
    //    if (_sgMaxCount.selectedSegmentIndex == 0)
    //        cont.nMaxCount = 1;
    //    else if (_sgMaxCount.selectedSegmentIndex == 1)
    //        cont.nMaxCount = 4;
    //    else if (_sgMaxCount.selectedSegmentIndex == 2)
    //    {
    cont.nMaxCount = DO_NO_LIMIT_SELECT;
    cont.nResultType = DO_PICKER_RESULT_ASSET;  // if you want to get lots photos, you'd better use this mode for memory!!!
    //    }
    
    cont.nColumnCount =2;
    
    [self presentViewController:cont animated:YES completion:nil];
}

#pragma mark - DoImagePickerControllerDelegate
- (void)didCancelDoImagePickerController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didSelectPhotosFromDoImagePickerController:(DoImagePickerController *)picker result:(NSArray *)aSelected
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (picker.nResultType == DO_PICKER_RESULT_UIIMAGE)
    {
        if(aSelected.count!=0)
            self.imageView.image=[aSelected objectAtIndex:0];
        
    }
    //get from the photo saved in phone:
    else if (picker.nResultType == DO_PICKER_RESULT_ASSET)
    {
        if(aSelected.count!=0)
            self.imageView.image= [ASSETHELPER getImageFromAsset:aSelected[0] type:ASSET_PHOTO_SCREEN_SIZE];
        
        
        [ASSETHELPER clearData];
    }
}

@end
