//
//  AddTicketView.h
//  TicketMinder
//
//  Created by openxcell121 on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAL.h"
#import "TicketMinderAppDelegate.h"
#import <MobileCoreServices/MobileCoreServices.h>


@interface AddTicketView : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIAlertViewDelegate>
{
    UIImagePickerController * imagePickerController;
    DAL *databaseObj;
    NSMutableArray * arrayNo;
    int cameraBtnTag;
    NSDate *issueDate;
    NSDate *expiryDate;
    NSString * reminder1;
    NSString * reminder2;
    int remainder1Int;
    int remainder2Int;
    int viewUnloadTag;
    UIImage *selectedImage;
    TicketMinderAppDelegate *appDelegate;

}
@property (retain, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (retain, nonatomic) IBOutlet UIToolbar *toolBar;
@property (retain, nonatomic) IBOutlet UIButton *cameraBtn2;
@property (retain, nonatomic) IBOutlet UIButton *expiryDateBtn;
@property (retain, nonatomic) IBOutlet UIButton *remainder2Btn;
@property (retain, nonatomic) IBOutlet UIButton *remainder1Btn;
@property (retain, nonatomic) IBOutlet UIButton *camerabtn;
@property (retain, nonatomic) IBOutlet UIButton *ticketNameBtn;
@property (retain, nonatomic) IBOutlet UIButton *ticketIssuerBtn;
@property (retain, nonatomic) IBOutlet UIButton *issueDateBtn;
@property (retain, nonatomic) IBOutlet UIButton *lsdLocationBtn;
@property (retain, nonatomic)     NSDate *issueDate;
@property (retain, nonatomic) IBOutlet UIPickerView *pickerRemainder;

-(IBAction)noticePeriod:(id)sender;
-(IBAction)dateSelection:(id)sender;
-(IBAction)cameraBtnPressed:(id)sender;
-(IBAction)lsdLocation:(id)sender;
-(IBAction)ticketNameandIssuer:(id)sender;
-(IBAction)backGo:(id)sender;
-(IBAction)saveButtonClicked;
-(IBAction)done:(id)sender;
-(IBAction)dueDateChanged:(id)sender;



@end
