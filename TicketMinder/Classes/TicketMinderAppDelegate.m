//
//  TicketMinderAppDelegate.m
//  TicketMinder
//
//  Created by Openxcelltech on 3/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TicketMinderAppDelegate.h"
#import "TicketMinderViewController.h"

@implementation TicketMinderAppDelegate

@synthesize window;
@synthesize navigationbar=_navigationbar;
@synthesize dictinory;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    UIImage *img=[[UIImage alloc]init] ;
    NSDate *dat =[NSDate date] ;
    
    dictinory = [[NSMutableDictionary alloc]init];
    
    [dictinory setObject:@"" forKey:@"edited"];
    [dictinory setObject:@"Ticket Name" forKey:@"ticketName"];
    [dictinory setObject:@"Ticket Issuer Name" forKey:@"ticketIssuer"];
    [dictinory setObject:@"Issue Date" forKey:@"issueDate"];
    [dictinory setObject:@"Expiry Date" forKey:@"expDateBtn"];
    [dictinory setObject:@"Reminder 1" forKey:@"ramainder1"];
    [dictinory setObject:@"Reminder 2" forKey:@"ramainder2"];
    [dictinory setObject:@"LSD/Facility/Location" forKey:@"location"];
    [dictinory setObject:img forKey:@"camera1"];
    [dictinory setObject:img forKey:@"camera2"];
    [dictinory setObject:@"0" forKey:@"remainderInt1"];
    [dictinory setObject:@"0" forKey:@"remainderInt2"];
    [dictinory setObject:dat forKey:@"expDateValue"];
    
    [img release];
    
    // Override point for customization after application launch.
    self.navigationbar.navigationBarHidden = TRUE;
    // Add the view controller's view to the window and display.
    [self.window addSubview:_navigationbar.view];
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"This was fired off");
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Notification" message:notification.alertBody delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [_navigationbar release];
    [window release];
    [dictinory release];
    [super dealloc];
}


@end
