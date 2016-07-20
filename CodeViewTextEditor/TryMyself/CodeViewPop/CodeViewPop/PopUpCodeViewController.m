//
//  ViewController.m
//  CodeViewPop
//
//  Created by Lei Cao on 3/7/16.
//  Copyright © 2016 Lei Cao (Tony). All rights reserved.
//

#import "PopUpCodeViewController.h"

@interface PopUpCodeViewController ()<PTDCodeViewEditorEventsDelegate>
@property (strong, nonatomic) PTDCodeViewEditor *codeTextEditor;
@end

@implementation PopUpCodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredContentSizeChanged) name:UIContentSizeCategoryDidChangeNotification object:nil];
    
    self.codeTextEditor = [[PTDCodeViewEditor alloc] initWithLineViewWidth:25 textReplaceFile:@"textReplace" keywordsFile:@"keywords" textColorsFile:@"textColors" textSkipFile:@"textSkip"];
    self.codeTextEditor.translatesAutoresizingMaskIntoConstraints = NO;
    self.codeTextEditor.separatorViewColor = [UIColor colorWithRed:0 green:125.0/255.0 blue:1 alpha:1];
    
    NSError *error;
    [self.codeTextEditor setToolbarButtonsFromJsonResourceWithName:@"custom-menu" error:&error];
    if (error) {
        @throw error;
    }
    
    [self.codeTextEditor setEditorEventsDelegate:self];
    [self.view addSubview:self.codeTextEditor];
    
    NSDictionary *views = @{@"myRichTextEditor":self.codeTextEditor};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[myRichTextEditor]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[myRichTextEditor]|" options:0 metrics:nil views:views]];
    
    [self preferredContentSizeChanged];

    NSError *errorGetSource = nil;
    NSString *urlString = [NSString stringWithFormat:@"%@", @"https://raw.githubusercontent.com/63a16d97ea4816a7f854483da5031469/Data-Structure/master/LeetOJ/AddBinary.java"];
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    NSString *webSource = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&errorGetSource];
    
    //load the local default file.
    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"examplesketch" ofType:@"ino"];
    //    NSString *myText = [NSString stringWithContentsOfFile:filePath encoding:NSStringEncodingConversionAllowLossy error:nil];
    
    [self.codeTextEditor loadWithText:webSource];
    
    self.codeTextEditor.editable=NO;
 
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired = 3;
    [self.codeTextEditor addGestureRecognizer:tapGesture];
    
}


- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized) {
        // handling code
        NSLog(@"detect the three times tap");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)preferredContentSizeChanged {
    self.codeTextEditor.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

- (void)openedKeyboardForEditor:(PTDCodeViewEditor *)editor
{
    NSLog(@"Opened keyboard for editor: %@", editor);
}

- (void)dismissedKeyboardForEditor:(PTDCodeViewEditor *)editor
{
    NSLog(@"Dismissed keyboard for editor: %@", editor);
}

@end
