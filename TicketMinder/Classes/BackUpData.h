//
//  BackUpData.h
//  TicketMinder
//
//  Created by openxcell121 on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAL.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface BackUpData : UIViewController<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate,UIActionSheetDelegate>{
    NSMutableArray *databaseResponseArray;
    NSMutableArray *arrayToMail;
    UIImage *img;
    UIImage *img2;
    NSMutableArray *selectedItem_arr;
     NSString *dateStr;
}

@property (retain, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (retain, nonatomic) IBOutlet UITableView *myTableView;
-(IBAction)backGo:(id)sender;
-(IBAction) mailSentButtonPresed;

@end
