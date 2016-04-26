//
//  TicketMinderViewController.m
//  TicketMinder
//
//  Created by Openxcelltech on 3/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TicketMinderViewController.h"

@implementation TicketMinderViewController
@synthesize addTicketBtn;
@synthesize viewTicketbBtn;
@synthesize backUpDataBtn;



# pragma View Life Cycle

- (void)dealloc {
    [addTicketBtn release];
    [viewTicketbBtn release];
    [backUpDataBtn release];
    [super dealloc];
}


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

-(IBAction)popup:(id)sender{
    
    Dialog *obj =[[Dialog alloc]init];
    [self.view addSubview:obj];
    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    
    if (![[NSUserDefaults standardUserDefaults]valueForKey:@"Terms"]) {
        [self popup:nil];
    }

    
    [super viewDidLoad];
      
}
-(void)viewWillAppear:(BOOL)animated    {

    self.title=@"Ticket Minder";
}

-(void)viewWillDisappear:(BOOL)animated {
    self.title=@"Back";
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [self setBackUpDataBtn:nil];
    [self setViewTicketbBtn:nil];
    [self setAddTicketBtn:nil];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma IBAction Division

-(IBAction)addTicket:(id)sender{
    addTicket = [[AddTicketView alloc]initWithNibName:@"AddTicketView" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:addTicket animated:YES];
    [addTicket release];

}
-(IBAction)viewTicket:(id)sender{
    viewTicket =[[ViewTicket alloc]initWithNibName:@"ViewTicket" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:viewTicket animated:YES];
    [viewTicket release];

   }
-(IBAction)backUpData:(id)sender{
    backUpData = [[BackUpData alloc]initWithNibName:@"BackUpData" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:backUpData animated:YES];
    [backUpData release];

}


@end
