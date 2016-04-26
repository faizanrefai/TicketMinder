//
//  TicketDetailView.m
//  TicketMinder
//
//  Created by openxcell121 on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TicketDetailView.h"

@implementation TicketDetailView
@synthesize tickeIssuerBtn;
@synthesize issueDateBtn;
@synthesize expDateBtn;
@synthesize notice1Btn;
@synthesize notice2Btn;
@synthesize lsdLocationBtn;
@synthesize cameraBtn;
@synthesize cameraBtn2;
@synthesize saveBtn;
@synthesize ticketNameBtn;
@synthesize detailDictonary;


-(void)dealloc{
    [saveBtn release];
    [ticketNameBtn release];
    [tickeIssuerBtn release];
    [issueDateBtn release];
    [expDateBtn release];
    [notice1Btn release];
    [notice2Btn release];
    [lsdLocationBtn release];
    [cameraBtn release];
    [cameraBtn2 release];
    [detailDictonary release];

    [super dealloc];

}

- (void)viewDidUnload
{
    detailDictonary=nil;
    [detailDictonary release];

    [self setTicketNameBtn:nil];
    [self setTickeIssuerBtn:nil];
    [self setIssueDateBtn:nil];
    [self setExpDateBtn:nil];
    [self setNotice1Btn:nil];
    [self setNotice2Btn:nil];
    [self setLsdLocationBtn:nil];
    [self setCameraBtn:nil];
    [self setCameraBtn2:nil];
    [self setSaveBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)setDictinaryForDetail:(NSMutableDictionary*)dictinary{

    detailDictonary = [[NSMutableDictionary alloc]initWithDictionary:dictinary copyItems:YES];

}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    issueDate = [[NSDate alloc]init];
    reminder1 = [[NSMutableString alloc]initWithFormat:@"1 Week Before Expiry"];
    reminder2 = [[NSMutableString alloc]initWithFormat:@"1 Week Before Expiry"];
    
    arrayNo = [[NSMutableArray alloc] init];
    
    [arrayNo addObject:@"1 Week Before Expiry"];
    [arrayNo addObject:@"2 Weeks Before Expiry"];
    [arrayNo addObject:@"3 Weeks Before Expiry"];
    [arrayNo addObject:@"4 Weeks Before Expiry"];
    [arrayNo addObject:@"5 Weeks Before Expiry"];
    [arrayNo addObject:@"6 Weeks Before Expiry"];
    [arrayNo addObject:@"2 Months Before Expiry"];
    [arrayNo addObject:@"3 Months Before Expiry"];
    [arrayNo addObject:@"4 Months Before Expiry"];
    [arrayNo addObject:@"5 Months Before Expiry"];
    [arrayNo addObject:@"6 Months Before Expiry"];

    
    
    
    [[ticketNameBtn retain] setTitle:[detailDictonary  valueForKey:@"Ticket_Name"] forState:UIControlStateNormal];
    [[tickeIssuerBtn retain] setTitle:[detailDictonary valueForKey:@"Ticket_Issuer"] forState:UIControlStateNormal];
    [[issueDateBtn retain] setTitle:[detailDictonary valueForKey:@"Issue_Date"] forState:UIControlStateNormal];
    [[expDateBtn retain] setTitle:[detailDictonary valueForKey:@"Expiry_Date"] forState:UIControlStateNormal];
    [[notice1Btn retain] setTitle:[detailDictonary valueForKey:@"Notice_1"] forState:UIControlStateNormal];
    [[notice2Btn retain]setTitle:[detailDictonary valueForKey:@"Notice_2"] forState:UIControlStateNormal];
    [[lsdLocationBtn retain] setTitle:[detailDictonary valueForKey:@"Location"] forState:UIControlStateNormal];
    
    
    NSDate *Date1 = [NSDate date];
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init]autorelease];
    [dateFormat  setDateFormat:@"dd MMM yyyy"];    
    
    NSDate *Date2 = [dateFormat dateFromString:[detailDictonary valueForKey:@"Expiry_Date"]];  
    
    NSComparisonResult result = [Date1 compare:Date2];
    
    if (result==NSOrderedAscending) {
        //        cell.textLabel.textColor = [UIColor whiteColor];
        //        cell.detailTextLabel.textColor = [UIColor whiteColor];  
        
        // NSLog(@"Date1 is in the future");
        
    } else if (result==NSOrderedDescending) {
        // NSLog(@"Expired dates ");
        [ticketNameBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];     
        [tickeIssuerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];     
        [issueDateBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];     
        [expDateBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];     
        [lsdLocationBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];     
        [notice1Btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];     
        [notice2Btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];     
        
    } else {
        
        //        // NSLog(@"Both dates are the same");
        //        cell.textLabel.textColor = [UIColor whiteColor];
        //        cell.detailTextLabel.textColor = [UIColor whiteColor];
    }
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillDisappear:(BOOL)animated{

self.title =@"Back";

}
-(void)viewWillAppear:(BOOL)animated{
    
    self.title = @"Ticket Detail";
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", [detailDictonary valueForKey:@"Ticket_Image"]] ];
    UIImage *img = [UIImage imageWithContentsOfFile:getImagePath];
    [cameraBtn setBackgroundImage:img forState:UIControlStateNormal];
    
    NSString *getImagePath2 = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", [detailDictonary valueForKey:@"Ticket_Image2"]] ];
    UIImage *img2 = [UIImage imageWithContentsOfFile:getImagePath2];
    [cameraBtn2 setBackgroundImage:img2 forState:UIControlStateNormal];

    
   

}


#pragma mark - IBAction Division 


-(IBAction)cameraBtn1Press:(id)sender{
    
    UIImageView *imgVi = [[UIImageView alloc]initWithImage:[cameraBtn currentBackgroundImage]];
    TicketImageFullView *imageTicket = [[TicketImageFullView alloc]initWithNibName:@"TicketImageFullView" bundle:nil];
    [imageTicket setTicket:imgVi cameraBtn:1 imageName:[detailDictonary valueForKey:@"Ticket_Image"]];
    [self.navigationController pushViewController:imageTicket animated:YES];
    [imgVi release];
    [imageTicket release];
}
-(IBAction)cameraBtn2Press:(id)sender{
    
    UIImageView *imgVi = [[UIImageView alloc]initWithImage:[cameraBtn2 currentBackgroundImage]];
    TicketImageFullView *imageTicket = [[TicketImageFullView alloc]initWithNibName:@"TicketImageFullView" bundle:nil];
    [imageTicket setTicket:imgVi cameraBtn:2 imageName:[detailDictonary valueForKey:@"Ticket_Image2"]];
    [self.navigationController pushViewController:imageTicket animated:YES];
    [imgVi release];
    [imageTicket release];
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag==2) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
-(IBAction)saveButtonClicked:(id)sender{
    
    if ([[ticketNameBtn currentTitle] isEqualToString:@"Ticket Name"]|| [[[ticketNameBtn currentTitle] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) 
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Enter Ticket Name." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    } else   if ([[tickeIssuerBtn currentTitle] isEqualToString:@"Ticket Issuer Name"]|| [[[tickeIssuerBtn currentTitle] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) 
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Enter Ticket Issuer Name." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    } else if([[issueDateBtn currentTitle] isEqualToString:@"Issue Date"]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Enter Ticket Issue Date." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
        
    }else if ([[expDateBtn currentTitle] isEqualToString:@"Expiry Date"]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Enter Ticket Expiry Date." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;    
    } else if([[notice1Btn currentTitle] isEqualToString:@"Reminder 1"]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Enter Reminder 1." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
        
    } else if([[notice2Btn currentTitle] isEqualToString:@"Reminder 2"]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Enter Reminder 2." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
        
    }    
    NSMutableDictionary *recordDic = [[NSMutableDictionary alloc]init];
    
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]autorelease];;
    dateFormatter.dateFormat = @"yyyyddMMhhmmss";
    NSString *strdt=[dateFormatter stringFromDate:now];
    
    NSDate *now1 = [NSDate date];
    NSDateFormatter *dateFormatter1 = [[[NSDateFormatter alloc] init]autorelease];;
    dateFormatter1.dateFormat = @"ddMMhhmmss";
    NSString *strdt1=[dateFormatter1 stringFromDate:now1];
    
    
    [recordDic setValue:[ticketNameBtn currentTitle] forKey:@"Ticket_Name"];
    [recordDic setValue:[tickeIssuerBtn currentTitle] forKey:@"Ticket_Issuer"];
    [recordDic setValue:[issueDateBtn currentTitle] forKey:@"Issue_Date"];
    [recordDic setValue:[expDateBtn currentTitle] forKey:@"Expiry_Date"];
    [recordDic setValue:[notice1Btn currentTitle] forKey:@"Notice_1"];
    [recordDic setValue:[notice1Btn currentTitle] forKey:@"Notice_2"];
    [recordDic setValue:[lsdLocationBtn currentTitle] forKey:@"Location"];
    [recordDic setValue:strdt forKey:@"Ticket_Image"];
    [recordDic setValue:strdt1 forKey:@"Ticket_Image2"];
    
  // Save New Images Start
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //For Image 1
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",strdt]];
    UIImage *image = [cameraBtn currentBackgroundImage]; // imgProfile is the image which you are fetching from url
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:savedImagePath atomically:YES]; 
    // For Image 2
    NSString *savedImagePath1 = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",strdt1]];
    UIImage *image1 = [cameraBtn2 currentBackgroundImage]; // imgProfile is the image which you are fetching from url
    NSData *imageData1 = UIImagePNGRepresentation(image1);
    [imageData1 writeToFile:savedImagePath1 atomically:YES]; 
    
    
    //Save New Image End
    
    
    
    // Remove Current Image Start
    
    NSFileManager *fileManager2 = [NSFileManager defaultManager];  
    NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSString *documentsDirectory2 = [paths2 objectAtIndex:0];  
    
    NSString *fullPath1 = [documentsDirectory2 stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", [detailDictonary valueForKey:@"Ticket_Image"]]];  
    [fileManager2 removeItemAtPath: fullPath1 error:NULL];  
    
    NSString *fullPath2 = [documentsDirectory2 stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", [detailDictonary valueForKey:@"Ticket_Image2"]]];  
    [fileManager2 removeItemAtPath: fullPath2 error:NULL];  
    NSLog(@"image removed");  
    
    // Remove Current Image End
    databaseObj=[[DAL alloc]initDatabase:@"AddTicketDatabase"];
    [databaseObj updateRecord:recordDic forID:@"id=" inTable:@"Ticket_Detail" withValue:[detailDictonary valueForKey:@"id"]];
    [databaseObj release];
    [recordDic release];

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Your Ticket has been saved." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    alert.tag=2;
    [alert show];
    [alert release];
    
}

-(IBAction)noticePeriod:(id)sender{
    
    UIButton *btn = (UIButton*)sender;
    pickerView3 = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 320, 216)];
    pickerView3.showsSelectionIndicator=TRUE;
    pickerView3.delegate=self;
    pickerView3.tag=btn.tag;
    UIActionSheet *ExpArea = [[UIActionSheet alloc] initWithTitle:@"Pickup Time\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"Set" destructiveButtonTitle:nil otherButtonTitles:nil];
	ExpArea.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[ExpArea setBounds:CGRectMake(0, 0, 320, 250)];
	[ExpArea addSubview:pickerView3];
	[ExpArea showInView:self.view];
    ExpArea.tag=btn.tag;
    [ExpArea release];
    [btn release];
    [pickerView3 release];
    
    
}

-(void) dueDateChanged:(id)sender {
    
    UIDatePicker *picker = (UIDatePicker*)sender;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"dd MMM yyyy"];    
    
    if (picker.tag == 1) {
        
        [[issueDateBtn retain] setTitle:[dateFormatter stringFromDate:picker.date] forState:UIControlStateNormal];
        issueDate = [picker.date retain];
    }
    
    if (picker.tag == 2) {
        [[expDateBtn retain] setTitle:[dateFormatter stringFromDate:picker.date] forState:UIControlStateNormal];
    }
    
    [dateFormatter release];
    
}

-(IBAction)lsdLocation:(id)sender{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Enter LSD/Location Name" message:@"\n\n" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:@"Cancel", nil]; 
    UITextField *txt = [[UITextField alloc]initWithFrame:CGRectMake(30, 50, 230, 27)];
    txt.backgroundColor = [UIColor whiteColor];
    txt.tag=3;
    [txt becomeFirstResponder];
    [txt addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [alert addSubview:txt];
    [alert show];
    [alert release];
    [txt release];
    
}


-(IBAction)ticketNameandIssuer:(id)sender{
    
    if ([ticketNameBtn isTouchInside]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Enter Ticket Name" message:@"\n\n" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:@"Cancel", nil]; 
        UITextField *txt = [[UITextField alloc]initWithFrame:CGRectMake(30, 50, 230, 27)];
        txt.backgroundColor = [UIColor whiteColor];
        txt.tag=1;
        [txt becomeFirstResponder];
        [txt addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        [alert addSubview:txt];
        [alert show];
        [alert release];
        [txt release];
    }
    if ([tickeIssuerBtn isTouchInside]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Enter Ticket Issuer Name" message:@"\n\n" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:@"Cancel", nil]; 
        UITextField *txt = [[UITextField alloc]initWithFrame:CGRectMake(30, 50, 230, 27)];
        txt.backgroundColor = [UIColor whiteColor];
        txt.tag=2;
        [txt becomeFirstResponder];
        [txt addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        [alert addSubview:txt];
        [alert show];
        [alert release];
        [txt release];
        
    }
    
}

-(void)textChanged:(id)sender{
    
    UITextField *texting = (UITextField *)sender;
    
    if (texting.tag==1) {
        [[ticketNameBtn retain] setTitle:texting.text forState:UIControlStateNormal];
    }
    if (texting.tag==2) {
        [[tickeIssuerBtn retain] setTitle:texting.text forState:UIControlStateNormal];
    }
    if (texting.tag==3) {
        [[lsdLocationBtn retain] setTitle:texting.text forState:UIControlStateNormal];
    }
    
}
-(IBAction)dateSelection:(id)sender{
    
    UIButton *btn = (UIButton*)sender;
    UIDatePicker *picker2 = [[UIDatePicker alloc]init];
    picker2.frame = CGRectMake(0, 0, 320, 216);
    [picker2 setDatePickerMode:UIDatePickerModeDate];
    picker2.tag= btn.tag;
    if (btn.tag==1) {
        picker2.maximumDate = [NSDate date];
    }
    if (btn.tag==2) {
        picker2.minimumDate =issueDate;
    }
    
    [picker2 addTarget:self action:@selector(dueDateChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    UIActionSheet *ExpArea = [[UIActionSheet alloc] initWithTitle:@"Pickup Time\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"Set" destructiveButtonTitle:nil otherButtonTitles:nil];
	ExpArea.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[ExpArea setBounds:CGRectMake(0, 0, 320, 250)];
	[ExpArea addSubview:picker2];
    ExpArea.tag=1;
	[ExpArea showInView:self.view];
    [ExpArea release];
    [picker2 release];

}



-(IBAction)backGo:(id)sender{


    [self.navigationController popViewControllerAnimated:YES];
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (actionSheet.tag==2) {
        switch (buttonIndex) {
            case 0:{
                
                if (imagePickerController) {
                    imagePickerController=Nil;
                    [imagePickerController release];
                    
                }
                imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.delegate = self;
                imagePickerController.allowsEditing = TRUE;
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                [self.navigationController presentModalViewController:imagePickerController animated:YES];
                
                break;
                
                
            }
            case 1:{
                if (imagePickerController) {
                    imagePickerController=Nil;
                    [imagePickerController release];
                    
                }
                imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.delegate = self;
                imagePickerController.allowsEditing = TRUE;
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                
                [self.navigationController presentModalViewController:imagePickerController animated:YES];
                
                break;
            }
            default:
                break;
        }
    }
    
    
    if (actionSheet.tag==3) {
        
        [[notice1Btn retain] setTitle:reminder1 forState:UIControlStateNormal];  
        
    }else if (actionSheet.tag==4){    
        
        [[notice2Btn retain] setTitle:reminder2  forState:UIControlStateNormal];
    }
    
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView1 didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (pickerView1.tag == 3) {
        
        reminder1 = [[arrayNo objectAtIndex:row]retain];
        
    }
    if (pickerView1.tag == 4) {
        
        reminder2 = [[arrayNo objectAtIndex:row]retain];
    }
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [arrayNo count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [arrayNo objectAtIndex:row];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
