//
//  ViewController.h
//  RadioButtonSample
//
//  Created by Sergey on 9/22/13.
//
//

#import <UIKit/UIKit.h>

@class RadioButton;

@interface ViewController : UIViewController


@property (nonatomic, strong) IBOutlet RadioButton* radioButton;
@property (nonatomic, strong) IBOutlet UILabel* statusLabel;
-(IBAction)onRadioBtn:(id)sender;

@end
