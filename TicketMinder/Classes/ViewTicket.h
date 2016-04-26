//
//  ViewTicket.h
//  TicketMinder
//
//  Created by openxcell121 on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAL.h"
#import <QuartzCore/QuartzCore.h>
#import "TicketDetailView.h"

@interface ViewTicket : UIViewController<UITableViewDataSource,UITableViewDelegate>  {
    NSMutableArray * databaseResponseArray;
    UITableView *myTableView;
        NSString *dateStr ;
}
@property (retain, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (retain, nonatomic)  IBOutlet  UITableView *myTableView;

-(IBAction)backGo:(id)sender;
-(IBAction)edit:(id)sender;
@end
