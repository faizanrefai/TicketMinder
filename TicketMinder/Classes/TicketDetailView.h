//
//  TicketDetailView.h
//  TicketMinder
//
//  Created by openxcell121 on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketImageFullView.h"
#import "DAL.h"

@interface TicketDetailView : UIViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIAlertViewDelegate>{
    
    UIImagePickerController * imagePickerController;
    DAL *databaseObj;
    NSMutableArray * arrayNo;
    UIPickerView *pickerView3;
    NSDate *issueDate;
    NSMutableString * reminder1;
    NSMutableString * reminder2;
    
    

}

@property (retain, nonatomic) IBOutlet UIButton *saveBtn;

@property (retain, nonatomic) IBOutlet UIButton *tickeIssuerBtn;
@property (retain, nonatomic) IBOutlet UIButton *issueDateBtn;
@property (retain, nonatomic) IBOutlet UIButton *expDateBtn;
@property (retain, nonatomic) IBOutlet UIButton *notice1Btn;
@property (retain, nonatomic) IBOutlet UIButton *notice2Btn;
@property (retain, nonatomic) IBOutlet UIButton *lsdLocationBtn;
@property (retain, nonatomic) IBOutlet UIButton *cameraBtn;
@property (retain, nonatomic) IBOutlet UIButton *cameraBtn2;

@property (retain, nonatomic) IBOutlet UIButton *ticketNameBtn;
@property (nonatomic,retain)NSMutableDictionary *detailDictonary;
-(void)setDictinaryForDetail:(NSMutableDictionary*)dictinary;
-(IBAction)backGo:(id)sender;
-(IBAction)cameraBtn1Press:(id)sender;
-(IBAction)cameraBtn2Press:(id)sender;

-(IBAction)noticePeriod:(id)sender;
-(IBAction)dateSelection:(id)sender;
-(IBAction)lsdLocation:(id)sender;
-(IBAction)ticketNameandIssuer:(id)sender;
-(IBAction)saveButtonClicked:(id)sender;


@end
