//
//  JHStatusTextView.h
//  Status
//
//  Created by Jeff Hodnett on 19/04/2011.
//  Copyright 2011 Applausible. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHStatusTextView;

@protocol JHStatusTextViewDelegate <NSObject>

@optional
-(void)statusTextView:(JHStatusTextView *)textView postedMessage:(NSString *)message;

@end

@interface JHStatusTextView : UIView <UITextViewDelegate> {
	// The character counter
	UILabel *characterCountLabel;
	
	// The character count
	int characterCount;

	// Showing a placeholder
	BOOL showingPlaceholder;
	
	// The delegate
	IBOutlet id <JHStatusTextViewDelegate> delegate;
}

@property(nonatomic, assign) id <JHStatusTextViewDelegate> delegate;

@end
