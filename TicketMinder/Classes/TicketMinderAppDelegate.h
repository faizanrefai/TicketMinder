//
//  TicketMinderAppDelegate.h
//  TicketMinder
//
//  Created by Openxcelltech on 3/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TicketMinderViewController;

@interface TicketMinderAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navigationbar;
    NSMutableDictionary *dictinory;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationbar;
@property(nonatomic,retain)    NSMutableDictionary *dictinory;

@end

