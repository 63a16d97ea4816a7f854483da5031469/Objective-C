//
//  ViewController.m
//  RadioButtonSample
//
//  Created by Sergey on 9/22/13.
//
//

#import "ViewController.h"
#import "RadioButton.h"


@implementation ViewController

-(IBAction)onRadioBtn:(RadioButton*)sender
{
	_statusLabel.text = [NSString stringWithFormat:@"Selected: %@", sender.titleLabel.text];
}


-(void) onRadioButtonValueChanged:(RadioButton*)sender
{
	// Lets handle ValueChanged event only for selected button, and ignore for deselected
	if(sender.selected) {
		NSLog(@"Selected color: %@", sender.titleLabel.text);
	}
}

@end
