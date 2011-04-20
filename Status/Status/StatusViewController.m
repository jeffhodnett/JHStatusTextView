//
//  StatusViewController.m
//  Status
//
//  Created by Jeff Hodnett on 18/04/2011.
//  Copyright 2011 Applausible. All rights reserved.
//

#import "StatusViewController.h"

#import "JHStatusTextView.h"

@implementation StatusViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Print the available fonts
//	NSLog(@"Available Font Families: %@", [UIFont familyNames]);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark JHStatusTextView Delegate methods
-(void)statusTextView:(JHStatusTextView *)textView postedMessage:(NSString *)message {

	NSLog(@"got message = %@",message);
	
	//TODO whatever you want
}

@end
