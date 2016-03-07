//
//  ViewController.m
//  UIDatePicker
//
//  Created by Lei Cao on 7/3/16.
//  Copyright © 2016 Lei Cao (Tony). All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *datePickerTextField;


@end

@implementation ViewController

@synthesize datePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // setup Log Start pickerview
    datePicker = [[UIDatePicker alloc] init];
    datePicker.frame = CGRectMake(0, 160, self.view.bounds.size.width, 200); //160); // try to make a small picker view
    datePicker.datePickerMode=UIDatePickerModeDateAndTime;
    [self.datePickerTextField setInputView:datePicker];
    
    // Setup UIToolbar for UIDatePicker
    UIToolbar *logStartpickerViewToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    [logStartpickerViewToolBar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *extraSpacePVlogStart = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButtonPVlogStart = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissPickerView:)]; // method to dismiss the picker view when the "Done" button is pressed
    [logStartpickerViewToolBar setItems:[[NSArray alloc] initWithObjects: extraSpacePVlogStart, doneButtonPVlogStart, nil]];
    
    [self.datePickerTextField setInputAccessoryView:logStartpickerViewToolBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// dismiss picker view (for gender)
-(void)dismissPickerView:(id)sender
{
    
    // Formatter configuration
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:posix];
    [formatter setDateFormat:@"dd/MM/yy HH:mm:ss"];
    // Date to string
    
    NSString *formatedDate = [formatter stringFromDate:self.datePicker.date];
    self.datePickerTextField.text=formatedDate;
    [self.datePickerTextField resignFirstResponder];
    
}

@end
