//
//  StatusAppDelegate.h
//  Status
//
//  Created by Jeff Hodnett on 18/04/2011.
//  Copyright 2011 Applausible. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StatusViewController;

@interface StatusAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet StatusViewController *viewController;

@end
