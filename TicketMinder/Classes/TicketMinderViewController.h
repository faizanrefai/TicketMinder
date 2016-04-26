//
//  TicketMinderViewController.h
//  TicketMinder
//
//  Created by Openxcelltech on 3/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTicketView.h"
#import "ViewTicket.h"
#import "BackUpData.h"
#import "Dialog.h"
@interface TicketMinderViewController : UIViewController {

    AddTicketView *addTicket;
    ViewTicket *viewTicket;
    BackUpData *backUpData;
}
@property (retain, nonatomic) IBOutlet UIButton *addTicketBtn;
@property (retain, nonatomic) IBOutlet UIButton *viewTicketbBtn;
@property (retain, nonatomic) IBOutlet UIButton *backUpDataBtn;
-(IBAction)addTicket:(id)sender;
-(IBAction)viewTicket:(id)sender;
-(IBAction)backUpData:(id)sender;
-(IBAction)popup:(id)sender;

@end

