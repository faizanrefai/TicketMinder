//
//  AddTicketView.m
//  TicketMinder
//
//  Created by openxcell121 on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



#import "AddTicketView.h"


@implementation AddTicketView
@synthesize datePicker;
@synthesize toolBar;
@synthesize cameraBtn2;
@synthesize expiryDateBtn;
@synthesize remainder2Btn;
@synthesize remainder1Btn;
@synthesize camerabtn;
@synthesize ticketNameBtn;
@synthesize ticketIssuerBtn;
@synthesize issueDateBtn;
@synthesize lsdLocationBtn;
@synthesize issueDate;
@synthesize pickerRemainder;



- (void)dealloc {
    
    [expiryDateBtn release];
    [ticketNameBtn release];
    [ticketIssuerBtn release];
    [camerabtn release];
    [cameraBtn2 release];
    [lsdLocationBtn release];
    [remainder2Btn release];
    [remainder1Btn release];
    [imagePickerController release];
    [pickerRemainder release];
    [toolBar release];  
    [datePicker release];
    [arrayNo release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setExpiryDateBtn:nil];
    [self setRemainder2Btn:nil];
    [self setRemainder1Btn:nil];
    [self setCamerabtn:nil];
    [self setTicketNameBtn:nil];
    [self setTicketIssuerBtn:nil];
    [self setIssueDateBtn:nil];
    [self setLsdLocationBtn:nil];
    [self setCameraBtn2:nil];
    selectedImage = nil;
    imagePickerController =  nil;
    [self setPickerRemainder:nil];
    [self setToolBar:nil];
    arrayNo = nil;
    [self setDatePicker:nil];
    reminder1=nil;
    reminder2=nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    
    
    
    pickerRemainder.hidden=TRUE;
    toolBar.hidden=TRUE;
    datePicker.hidden = TRUE;
     imagePickerController = [[UIImagePickerController alloc] init];
     imagePickerController.delegate = self;  
    self.title=@"Ticket Detail";
    
    UIBarButtonItem* saveItem = [[UIBarButtonItem alloc]  initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonClicked)];
    self.navigationItem.rightBarButtonItem = saveItem;
    [saveItem release];
    
    reminder1 = @"1 Week Before Expiry";
    reminder2 = @"1 Week Before Expiry";
    
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
    
  // Load From App delegate !!
    
    appDelegate = [[UIApplication sharedApplication]delegate];
    if ([[appDelegate.dictinory valueForKey:@"edited"] isEqualToString:@"set"]) {
        
        [ticketNameBtn setTitle:[appDelegate.dictinory valueForKey:@"ticketName"] forState:UIControlStateNormal];
        [ticketIssuerBtn setTitle:[appDelegate.dictinory valueForKey:@"ticketIssuer"] forState:UIControlStateNormal];
        [issueDateBtn setTitle:[appDelegate.dictinory valueForKey:@"issueDate"] forState:UIControlStateNormal];
        [expiryDateBtn setTitle:[appDelegate.dictinory valueForKey:@"expDateBtn"] forState:UIControlStateNormal];
        [remainder1Btn setTitle:[appDelegate.dictinory valueForKey:@"ramainder1"] forState:UIControlStateNormal];
        [remainder2Btn setTitle:[appDelegate.dictinory valueForKey:@"ramainder2"] forState:UIControlStateNormal];
        reminder1 =[appDelegate.dictinory valueForKey:@"ramainder1"] ;
        reminder2 =[appDelegate.dictinory valueForKey:@"ramainder2"];
        remainder1Int =[[appDelegate.dictinory valueForKey:@"remainderInt1"] intValue];
        remainder2Int =[[appDelegate.dictinory valueForKey:@"remainderInt2"] intValue];
        [lsdLocationBtn setTitle:[appDelegate.dictinory valueForKey:@"location"] forState:UIControlStateNormal];
        [camerabtn setBackgroundImage:[appDelegate.dictinory valueForKey:@"camera1"] forState:UIControlStateNormal];
        [cameraBtn2 setBackgroundImage:[appDelegate.dictinory valueForKey:@"camera2"] forState:UIControlStateNormal];
        expiryDate =  [appDelegate.dictinory valueForKey:@"expDateValue"]; 
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    
      [super viewWillAppear:animated]; 
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma  mark -  Picker Camera  and remainder picker Delegate


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker1{
    [picker1 dismissModalViewControllerAnimated:YES];

}

-(void)imagePickerController:(UIImagePickerController *)picker1 didFinishPickingMediaWithInfo:(NSDictionary *)info{
   
    [picker1 dismissModalViewControllerAnimated:YES];
    
    
    NSString *mediaType = 
    [info objectForKey:UIImagePickerControllerMediaType];
    
    if (![mediaType isEqualToString:(NSString *)kUTTypeImage]) {
    
        return;
    
    }
    
     selectedImage = (UIImage *) [info valueForKey:UIImagePickerControllerOriginalImage];
        
        
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (selectedImage.imageOrientation) {
       
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
        
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, selectedImage.size.width, selectedImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, selectedImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, selectedImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
    }
    
    switch (selectedImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, selectedImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:{
            transform = CGAffineTransformTranslate(transform, selectedImage.size.height, 0);
             transform = CGAffineTransformScale(transform, -1, 1);
            break;
       
        
        }
            
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, selectedImage.size.width, selectedImage.size.height,
                                             CGImageGetBitsPerComponent(selectedImage.CGImage), 0,
                                             CGImageGetColorSpace(selectedImage.CGImage),
                                             CGImageGetBitmapInfo(selectedImage.CGImage));
   
    CGContextConcatCTM(ctx, transform);
    switch (selectedImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,selectedImage.size.height,selectedImage.size.width), selectedImage.CGImage);
            break;
            
        default:{ 
            
            CGContextDrawImage(ctx, CGRectMake(0,0,selectedImage.size.width,selectedImage.size.height), selectedImage.CGImage);
            break;
        }
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    selectedImage = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
        if (cameraBtnTag==1)
        {
            [camerabtn setBackgroundImage:selectedImage forState:UIControlStateNormal];
            [appDelegate.dictinory setObject:[camerabtn currentBackgroundImage] forKey:@"camera1"];
            [appDelegate.dictinory setObject:@"set" forKey:@"edited"];

        }
         if(cameraBtnTag==2)
        {
            [cameraBtn2 setBackgroundImage:selectedImage forState:UIControlStateNormal];
            [appDelegate.dictinory setObject:[cameraBtn2 currentBackgroundImage] forKey:@"camera2"];
            [appDelegate.dictinory setObject:@"set" forKey:@"edited"];

        }
   
    selectedImage=nil;


}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView1 didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView1.tag == 3) {
        reminder1 = [[arrayNo objectAtIndex:row]retain];
        remainder1Int =row;
        [remainder1Btn  setTitle:reminder1 forState:UIControlStateNormal];  
        [appDelegate.dictinory setObject:reminder1 forKey:@"ramainder1"];
        [appDelegate.dictinory setObject:[NSString stringWithFormat:@"%i",remainder1Int] forKey:@"remainderInt1"];
        [appDelegate.dictinory setObject:@"set" forKey:@"edited"];
        
    }
    if (pickerView1.tag == 4) {
        reminder2 = [[arrayNo objectAtIndex:row]retain];
        remainder2Int =row;
        [remainder2Btn setTitle:reminder2  forState:UIControlStateNormal];
        [appDelegate.dictinory setObject:reminder2 forKey:@"ramainder2"];
        [appDelegate.dictinory setObject:[NSString stringWithFormat:@"%i",remainder2Int] forKey:@"remainderInt2"];
        [appDelegate.dictinory setObject:@"set" forKey:@"edited"];

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



#pragma mark - Action Sheet and Alert delegate


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet.tag==2) {
        switch (buttonIndex) {
            case 0:{
                // [imagePickerController retain];
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                viewUnloadTag=1;            
                [self.navigationController presentModalViewController:imagePickerController animated:YES];
                break;
            }
            case 1:{
                
                //[imagePickerController retain];
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                viewUnloadTag=1;
                [self.navigationController presentModalViewController:imagePickerController animated:YES];
                break;
            }
            default:
                break;
        }
    }
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==1) {
        
        [appDelegate.dictinory setObject:@"" forKey:@"edited"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


#pragma mark - IBAction Division

-(BOOL)validation {
    
    if ([[ticketNameBtn currentTitle] isEqualToString:@"Ticket Name"]|| [[[ticketNameBtn currentTitle] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) 
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Enter Ticket Name." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        [ticketNameBtn setTitle:@"Ticket Name" forState:UIControlStateNormal];
        return FALSE;
    } else   if ([[ticketIssuerBtn currentTitle] isEqualToString:@"Ticket Issuer Name"]|| [[[ticketIssuerBtn currentTitle] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) 
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Enter Ticket Issuer Name." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        [ticketIssuerBtn setTitle:@"Ticket Issuer Name" forState:UIControlStateNormal];

        return FALSE;
    } else if([[issueDateBtn currentTitle] isEqualToString:@"Issue Date"]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Enter Ticket Issue Date." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return FALSE;
        
    }else if ([[expiryDateBtn currentTitle] isEqualToString:@"Expiry Date"]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Enter Ticket Expiry Date." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return FALSE;
    } else if([[remainder1Btn currentTitle] isEqualToString:@"Reminder 1"]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Enter Reminder 1." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return FALSE;
        
    } else if([[remainder2Btn currentTitle] isEqualToString:@"Reminder 2"]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Enter Reminder 2." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return FALSE;
        
    }

    return TRUE;

}


-(IBAction)backGo:(id)sender{

    [appDelegate.dictinory setObject:@"" forKey:@"edited"];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)saveButtonClicked{
    
    if (![self validation]) {
        return;
    }
    
    
    NSMutableDictionary *recordDic = [[NSMutableDictionary alloc]init];
    
    // Set the Name for camera button Image 1
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];;
    dateFormatter.dateFormat = @"yyyyddMMhhmmss";
    NSString *strdt=[dateFormatter stringFromDate:now];
    
    // Set the Name for camera button Image 2
    NSDate *now1 = [NSDate date];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];;
    dateFormatter1.dateFormat = @"ddMMhhmmss";
    NSString *strdt1=[dateFormatter1 stringFromDate:now1];    
   
    
    [recordDic setValue:[ticketNameBtn currentTitle] forKey:@"Ticket_Name"];
    [recordDic setValue:[ticketIssuerBtn currentTitle] forKey:@"Ticket_Issuer"];
    [recordDic setValue:[issueDateBtn currentTitle] forKey:@"Issue_Date"];
    [recordDic setValue:[expiryDateBtn currentTitle] forKey:@"Expiry_Date"];
    [recordDic setValue:[remainder1Btn currentTitle] forKey:@"Notice_1"];
    [recordDic setValue:[remainder2Btn currentTitle] forKey:@"Notice_2"];
    
    if([[lsdLocationBtn currentTitle] isEqualToString:@"LSD/Facility/Location"]){
        
        [recordDic setValue:[NSString stringWithFormat:@"NO %@", [lsdLocationBtn currentTitle]] forKey:@"Location"];
        
    }else{
    
        [recordDic setValue:[lsdLocationBtn currentTitle] forKey:@"Location"];

    }

    
    [recordDic setValue:strdt forKey:@"Ticket_Image"];
    [recordDic setValue:strdt1 forKey:@"Ticket_Image2"];
    
    [dateFormatter release];
    [dateFormatter1 release];
    
    // End the Name for camera button Image 1
    // End the Name for camera button Image 2
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
   
    //For Image 1 saved to resources
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",strdt]];
    UIImage *image ;
    image=[camerabtn currentBackgroundImage];
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:savedImagePath atomically:YES]; 
    
    // For Image 2 saved to resorces
    NSString *savedImagePath1 = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",strdt1]];
    UIImage *image1 ;
    image1 =[cameraBtn2 currentBackgroundImage]; 
    NSData *imageData1 = UIImagePNGRepresentation(image1);
    [imageData1 writeToFile:savedImagePath1 atomically:YES]; 
   
    // Finally saved to Database
    databaseObj=[[DAL alloc]initDatabase:@"AddTicketDatabase"];
    [databaseObj insertRecord:recordDic inTable:@"Ticket_Detail"];
    [databaseObj release];
    
   
    // Local Notification Set Reminder 1
   
    // Find the Date

    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    
    if (remainder1Int >5) {
        [offsetComponents setMonth:-(remainder1Int-4)];
        [offsetComponents setMinute:1];

    }else{
    [offsetComponents setWeek:-(remainder1Int+1)]; // note that I'm setting it to -1
    }
    
    NSDate *notificaDate = [gregorian dateByAddingComponents:offsetComponents toDate:expiryDate options:0];
    [offsetComponents release];
    [gregorian release];
	//NSLog(@"Weekend: %@", dateString_first);
   
    
    // Local Notification Set Here

    UIApplication *app = [UIApplication sharedApplication];
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate  = notificaDate;
    notification.timeZone  = [NSTimeZone systemTimeZone];
    notification.alertBody =  [NSString stringWithFormat:@"Your ticket %@ will be expire on %@.", [ticketNameBtn currentTitle],[expiryDateBtn currentTitle]];
    notification.soundName = UILocalNotificationDefaultSoundName;

    [app scheduleLocalNotification:notification];
    [notification release];
    
    // Local Notification Set

    
    NSCalendar *gregorian1 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offsetComponents1 = [[NSDateComponents alloc] init];
    
    if (remainder2Int >5) {
        [offsetComponents1 setMonth:-(remainder2Int-4)];
        
    }else{
        [offsetComponents1 setWeek:-(remainder2Int+1)]; // note that I'm setting it to -1
    }
    
    NSDate *notificaDate1 = [gregorian1 dateByAddingComponents:offsetComponents1 toDate:expiryDate options:0];
    NSLog(@" Faizan2 %@", notificaDate1);
    [offsetComponents1 release];
    [gregorian1 release];
	//NSLog(@"Weekend: %@", dateString_first);
    // Local Notification Set Here
    
    UILocalNotification *notification1 = [[UILocalNotification alloc] init];
    notification1.fireDate  = notificaDate1;
    notification1.timeZone  = [NSTimeZone systemTimeZone];
    notification1.alertBody = [NSString stringWithFormat:@"Your ticket %@ will be expire on %@.", [ticketNameBtn currentTitle],[expiryDateBtn currentTitle]];
        notification1.soundName = UILocalNotificationDefaultSoundName;
    [app scheduleLocalNotification:notification1];
    [notification1 release];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Your Ticket has been saved." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    alert.tag=1;
    [alert show];
    [alert release];
    recordDic = nil;
    [recordDic release];
    
}


-(IBAction)noticePeriod:(id)sender{
    
    UIButton *btn = (UIButton*)sender;
    
    if (btn.tag==3) {
        [[remainder1Btn retain] setTitle:reminder1 forState:UIControlStateNormal];  
        pickerRemainder.tag=btn.tag;
        toolBar.hidden =FALSE;
        pickerRemainder.hidden=FALSE;
        
        [appDelegate.dictinory setObject:reminder1 forKey:@"ramainder1"];
        [appDelegate.dictinory setObject:@"set" forKey:@"edited"];

        
    }
    if (btn.tag==4) {
        [[remainder2Btn retain] setTitle:reminder2  forState:UIControlStateNormal];
        pickerRemainder.tag=btn.tag;
        toolBar.hidden =FALSE;
        pickerRemainder.hidden=FALSE;
        [appDelegate.dictinory setObject:reminder2 forKey:@"ramainder2"];
        [appDelegate.dictinory setObject:@"set" forKey:@"edited"];

    }
    
    
}


-(IBAction)done:(id)sender{
    pickerRemainder.hidden=TRUE;
    toolBar.hidden =TRUE;
    datePicker.hidden=TRUE;
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
    [txt release];
    [alert release];
    
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
        [txt release];
        [alert release];
    }
    if ([ticketIssuerBtn isTouchInside]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Enter Ticket Issuer Name" message:@"\n\n" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:@"Cancel", nil]; 
        UITextField *txt = [[UITextField alloc]initWithFrame:CGRectMake(30, 50, 230, 27)];
        txt.backgroundColor = [UIColor whiteColor];
        txt.tag=2;
        [txt becomeFirstResponder];
        [txt addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        [alert addSubview:txt];
        [alert show];
        [txt release];
        [alert release];


    }

}

-(void)textChanged:(id)sender{

    UITextField *texting = (UITextField *)sender;
    
    if (texting.tag==1) {
    [[ticketNameBtn retain] setTitle:texting.text forState:UIControlStateNormal];
        [appDelegate.dictinory setObject:[ticketNameBtn currentTitle] forKey:@"ticketName"];
        [appDelegate.dictinory setObject:@"set" forKey:@"edited"];

    }
    if (texting.tag==2) {
        [[ticketIssuerBtn retain] setTitle:texting.text forState:UIControlStateNormal];
        [appDelegate.dictinory setObject:[ticketIssuerBtn currentTitle] forKey:@"ticketIssuer"];
        [appDelegate.dictinory setObject:@"set" forKey:@"edited"];

    }
    if (texting.tag==3) {
        [[lsdLocationBtn retain] setTitle:texting.text forState:UIControlStateNormal];
        [appDelegate.dictinory setObject:[lsdLocationBtn currentTitle] forKey:@"location"];
        [appDelegate.dictinory setObject:@"set" forKey:@"edited"];
    }

}

-(IBAction)dueDateChanged:(id)sender {
    
    UIDatePicker *picker = (UIDatePicker*)sender;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"dd MMM yyyy"];    
    
    if (picker.tag == 1) {
        
        [issueDateBtn setTitle:[dateFormatter stringFromDate:picker.date] forState:UIControlStateNormal];
        issueDate = [picker.date  retain];
        [appDelegate.dictinory setObject:[dateFormatter stringFromDate:picker.date] forKey:@"issueDate"];
        [appDelegate.dictinory setObject:@"set" forKey:@"edited"];

        
    }
    if (picker.tag == 2) {
        [expiryDateBtn setTitle:[dateFormatter stringFromDate:picker.date] forState:UIControlStateNormal];
        expiryDate=[picker.date retain];
        
        [appDelegate.dictinory setObject:[dateFormatter stringFromDate:picker.date] forKey:@"expDateBtn"];
        [appDelegate.dictinory setObject:expiryDate forKey:@"expDateValue"];
        [appDelegate.dictinory setObject:@"set" forKey:@"edited"];

    }
    [dateFormatter release];
}


-(IBAction)dateSelection:(id)sender{
   
    UIButton *btn = (UIButton*)sender;
    datePicker.tag= btn.tag;
    
    if (btn.tag==1) {
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd MMM yyyy"];    
        [issueDateBtn  setTitle:[dateFormatter stringFromDate:[NSDate date]] forState:UIControlStateNormal];
        [dateFormatter release];
        issueDate = [[NSDate date] retain] ;
        datePicker.minimumDate=nil;
        datePicker.maximumDate = [NSDate date];
        datePicker.hidden = FALSE;
        toolBar.hidden=FALSE;
        
    }
    if (btn.tag==2) {
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd MMM yyyy"];    
        [expiryDateBtn  setTitle:[dateFormatter stringFromDate:[NSDate date]] forState:UIControlStateNormal];
        [dateFormatter release];
        expiryDate=[[NSDate date] retain];
        datePicker.maximumDate = nil;
        datePicker.minimumDate =issueDate ;   
        datePicker.hidden = FALSE;
        toolBar.hidden=FALSE;

    }
      
}
-(IBAction)cameraBtnPressed:(id)sender{
    UIButton *btn = (UIButton*)sender;
    cameraBtnTag = btn.tag;
    
    UIActionSheet *ExpArea = [[UIActionSheet alloc] initWithTitle:@"Select Photo From" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Photo Album", nil];
	ExpArea.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    ExpArea.tag=2;
	[ExpArea showInView:self.view];
    [ExpArea release];

}


@end
