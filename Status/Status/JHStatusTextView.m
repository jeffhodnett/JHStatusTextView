//
//  JHStatusTextView.m
//  Status
//
//  Created by Jeff Hodnett on 19/04/2011.
//  Copyright 2011 Applausible. All rights reserved.
//

#import "JHStatusTextView.h"
#import <QuartzCore/QuartzCore.h>

#define kViewRoundedCornerRadius 5.0f
#define kMaxCharacterCount 140
#define kFontName @"[z] Arista"
#define kPlaceholderText @"Update your status"

@interface JHStatusTextView (Private)
-(void)setupView;
@end

@implementation JHStatusTextView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

		// Setup the view
		[self setupView];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
	
	if( (self = [super initWithCoder:aDecoder]) ) {
		
		// Setup the view
		[self setupView];
	}
	return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
	[characterCountLabel release];
	
    [super dealloc];
}

#pragma mark - Private
-(void)setupView {
	// ****** README ********
	// Sometimes the font file name will be different than the embedded font name that the iOS system is using as it's key descriptior
	// So you'll have to print the available fonts and see which one font your looking for.
	// Print the available fonts
	//NSLog(@"Available Font Families: %@", [UIFont familyNames]);

	// Set rounded corners on the text view
	[self.layer setCornerRadius:kViewRoundedCornerRadius];

	// Set showing a placeholder by default
	showingPlaceholder = YES;
	
	// Add the text view
	UITextView *messageTextView = [[UITextView alloc] initWithFrame:self.bounds];
	[messageTextView setAutocorrectionType:UITextAutocorrectionTypeNo];
	[messageTextView setReturnKeyType:UIReturnKeyGo];
	[messageTextView.layer setCornerRadius:kViewRoundedCornerRadius];
	
	[messageTextView setText:kPlaceholderText];
	[messageTextView setTextColor:[UIColor lightGrayColor]];
	
	messageTextView.delegate = self;
	[messageTextView setFont:[UIFont fontWithName:kFontName size:20.0f]];
	[self addSubview:messageTextView];
	[messageTextView release];
	
	// Set the max character count
	characterCount = kMaxCharacterCount;
	
	// Add a character label
	float characterCountLabelWidth = 20.0f;
	float characterCountLabelHeight =  18.0f;
	characterCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-characterCountLabelWidth, self.frame.size.height-characterCountLabelHeight, characterCountLabelWidth, characterCountLabelHeight)];
	[characterCountLabel setTextAlignment:UITextAlignmentRight];
	[characterCountLabel setFont:[UIFont fontWithName:kFontName size:14.0f]];
	[characterCountLabel setBackgroundColor:[UIColor clearColor]];
	[characterCountLabel setText:[NSString stringWithFormat:@"%d", characterCount]];
	[self addSubview:characterCountLabel];
}

#pragma mark - UITextView Delegate Methods
-(void)textViewDidBeginEditing:(UITextView *)textView {

	// Check if it's showing a placeholder, remove it if so
	if(showingPlaceholder) {
		[textView setText:@""];
		[textView setTextColor:[UIColor blackColor]];
		
		showingPlaceholder = NO;
	}
}

-(void)textViewDidEndEditing:(UITextView *)textView {

	// Check the length and if it should add a placeholder
	if([[textView text] length] == 0 && !showingPlaceholder) {
		[textView setText:kPlaceholderText];
		[textView setTextColor:[UIColor lightGrayColor]];
		
		showingPlaceholder = YES;
	}
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	// if the user clicked the return key
	if ([text isEqualToString: @"\n"]) {
		// Hide the keyboard
		[textView resignFirstResponder];
		
		// Also return if its showing a placeholder
		if(showingPlaceholder) {
			return NO;
		}
		
		// Notify the delegate
		if(delegate && [delegate respondsToSelector:@selector(statusTextView:postedMessage:)]) {
			[delegate statusTextView:self postedMessage:textView.text];
		}

		return NO ;
	}
	
	return YES ;
}

- (void)textViewDidChange:(UITextView *)textView {
	// Update the character count
	characterCount = kMaxCharacterCount - [[textView text] length];
	[characterCountLabel setText:[NSString stringWithFormat:@"%d", characterCount]];
	
	// Check if the count is over the limit
	if(characterCount < 0) {
		// Change the color
		[characterCountLabel setTextColor:[UIColor redColor]];
	}
	else if(characterCount < 20) {
		// Change the color to yellow
		[characterCountLabel setTextColor:[UIColor orangeColor]];
	}
	else {
		// Set normal color
		[characterCountLabel setTextColor:[UIColor blackColor]];
	}
}

@end
