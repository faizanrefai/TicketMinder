//
//  BackUpData.m
//  TicketMinder
//
//  Created by openxcell121 on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BackUpData.h"

@implementation BackUpData
@synthesize segmentControl;
@synthesize myTableView;

#pragma mark - View lifecycle


- (void)dealloc {
    [segmentControl release];
    [myTableView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.title=@"Export Data";
    [segmentControl addTarget:self action:@selector(segmentControlIndexes:) forControlEvents:UIControlEventValueChanged];
    myTableView.indicatorStyle=UIScrollViewIndicatorStyleWhite;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    DAL *databaseObject = [[DAL alloc]initDatabase:@"AddTicketDatabase"];
    databaseResponseArray=  [[NSMutableArray alloc]initWithArray:[databaseObject SelectWithStar:@"Ticket_Detail"]];
    [databaseObject release];
    NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"Ticket_Name" ascending:YES];
    [databaseResponseArray sortUsingDescriptors:[NSArray arrayWithObject:nameSort]];
 
    arrayToMail = [[NSMutableArray alloc]init];
    selectedItem_arr=[[NSMutableArray alloc] init];

    for(int i =0;i<[databaseResponseArray count];i++){
        NSMutableDictionary *t =[[[NSMutableDictionary alloc] init]autorelease];
        [t setValue:@"0" forKey:@"mail"];
        [arrayToMail addObject:t];
    }


    
   // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewDidUnload
{
    [self setSegmentControl:nil];
    [self setMyTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(IBAction)backGo:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for(int i =0;i<[databaseResponseArray count];i++){
        NSMutableDictionary *t =[[[NSMutableDictionary alloc] init]autorelease];
        [t setValue:@"0" forKey:@"selected"];
        [selectedItem_arr addObject:t];
      
    }
  

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [databaseResponseArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    // Configure the cell...
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    UIImageView *ima = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellBack.png"]];
    [cell setBackgroundView:ima];
    [ima release];
    tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBack.png"]];
    cell.detailTextLabel.text = [[databaseResponseArray objectAtIndex:indexPath.row]valueForKey:@"Ticket_Name"];
    cell.detailTextLabel.backgroundColor=[UIColor clearColor];
    
    switch (segmentControl.selectedSegmentIndex) {
        case 0:{
            cell.textLabel.text = [[databaseResponseArray objectAtIndex:indexPath.row]valueForKey:@"Ticket_Name"]; 
            break;
        }
        case 1:{
            cell.textLabel.text = [[databaseResponseArray objectAtIndex:indexPath.row]valueForKey:@"Ticket_Issuer"];
            break;
        }
        case 2:{
           
            cell.textLabel.text = [[databaseResponseArray objectAtIndex:indexPath.row]valueForKey:@"Expiry_Date"];
            cell.detailTextLabel.text = [[databaseResponseArray objectAtIndex:indexPath.row]valueForKey:@"Ticket_Name"]; 

            break;
        }
        case 3:{
            cell.textLabel.text = [[databaseResponseArray objectAtIndex:indexPath.row]valueForKey:@"Location"];
            break;
        }
        default:
            break;
   
    }
   
    // Date comparision
    
    NSDate *Date1 = [NSDate date];
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init]autorelease];
    [dateFormat  setDateFormat:@"dd MMM yyyy"];    
    
    NSDate *Date2 = [dateFormat dateFromString:[[databaseResponseArray objectAtIndex:indexPath.row]valueForKey:@"Expiry_Date"]];  
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20.0];
    
    NSComparisonResult result = [Date1 compare:Date2];
    
    if (result==NSOrderedAscending) {
        
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.textColor = [UIColor whiteColor];

      //  NSLog(@"Date1 is in the future");
        
    } else if (result==NSOrderedDescending) {
       // NSLog(@"Expired dates ");
        cell.textLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.textColor = [UIColor redColor];
    } else {
        
       // NSLog(@"Both dates are the same");
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
    }
    if([[[selectedItem_arr objectAtIndex:indexPath.row]valueForKey:@"selected"] isEqualToString:@"1"]){
        cell.accessoryType =UITableViewCellAccessoryCheckmark;
    }
    else{
         cell.accessoryType =UITableViewCellAccessoryNone;
    }
    
    return cell;

}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSMutableDictionary *t =[[[NSMutableDictionary alloc] init]autorelease];
    NSMutableDictionary *t1 =[[[NSMutableDictionary alloc] init]autorelease];

    if([[[selectedItem_arr objectAtIndex:indexPath.row]valueForKey:@"selected"] isEqualToString:@"1"])
    {
       // NSMutableDictionary *t =[[NSMutableDictionary alloc] init];
        [t setValue:@"0" forKey:@"selected"];
        //[t1 setValue:@"0" forKey:@"mail"];
    }
    else{
            [t setValue:@"1" forKey:@"selected"];
        [t1 setDictionary:[databaseResponseArray objectAtIndex:indexPath.row]];
      //  [selectedItem_arr replaceObjectAtIndex:indexPath.row withObject:t];
       // t =nil;
       // [t release];
         
    }
   
    [arrayToMail replaceObjectAtIndex:indexPath.row withObject:t1];
    [selectedItem_arr replaceObjectAtIndex:indexPath.row withObject:t];

    [myTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    
}

#pragma mark - IBAction Division 
-(void)segmentControlIndexes:(id)sender{
    
    UISegmentedControl *segCtrl = (UISegmentedControl*)sender;
    switch (segCtrl.selectedSegmentIndex) {
        case 0:{
            NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"Ticket_Name" ascending:YES];
            [databaseResponseArray sortUsingDescriptors:[NSArray arrayWithObject:nameSort]];
            for(int i =0;i<[databaseResponseArray count];i++){
                NSMutableDictionary *t =[[[NSMutableDictionary alloc] init]autorelease];
                [t setValue:@"0" forKey:@"selected"];
                [selectedItem_arr replaceObjectAtIndex:i withObject:t];     
                [arrayToMail replaceObjectAtIndex:i withObject:t];
              
            }

            break;
        }
        case 1:{
            NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"Ticket_Issuer" ascending:YES];
            [databaseResponseArray sortUsingDescriptors:[NSArray arrayWithObject:nameSort]];
            for(int i =0;i<[databaseResponseArray count];i++){
                NSMutableDictionary *t =[[[NSMutableDictionary alloc] init]autorelease];
                [t setValue:@"0" forKey:@"selected"];
                [selectedItem_arr replaceObjectAtIndex:i withObject:t];
                [arrayToMail replaceObjectAtIndex:i withObject:t];
               
            }

            break;
        }
        case 2:{
            
            NSDate *date ;
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd MMM yyyy"];    
            
            for (int i=0;[ databaseResponseArray count]>i; i++) {
                date = [dateFormat dateFromString:[[databaseResponseArray objectAtIndex:i]valueForKey:@"Expiry_Date"]];  
                [[databaseResponseArray objectAtIndex:i]setObject:date forKey:@"Expiry_Date"];
            }
            [dateFormat release];
            NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"Expiry_Date" ascending:YES];
            [databaseResponseArray sortUsingDescriptors:[NSArray arrayWithObject:nameSort]];
            
       
            NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
            [dateFormat1  setDateFormat:@"dd MMM yyyy"];    
            
            for (int i=0;[ databaseResponseArray count]>i; i++) {
                dateStr = [[dateFormat1 stringFromDate:[[databaseResponseArray objectAtIndex:i]valueForKey:@"Expiry_Date"]] retain];  
                [[databaseResponseArray objectAtIndex:i]setObject:dateStr forKey:@"Expiry_Date"];
            }
            [dateFormat1 release];
            for(int i =0;i<[databaseResponseArray count];i++){
                NSMutableDictionary *t =[[[NSMutableDictionary alloc] init]autorelease];
                [t setValue:@"0" forKey:@"selected"];
                [selectedItem_arr replaceObjectAtIndex:i withObject:t];
                [arrayToMail replaceObjectAtIndex:i withObject:t];
              
            }

            break;
        }
        case 3:{
            NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"Location" ascending:YES];
            [databaseResponseArray sortUsingDescriptors:[NSArray arrayWithObject:nameSort]];
            for(int i =0;i<[databaseResponseArray count];i++){
                NSMutableDictionary *t =[[[NSMutableDictionary alloc] init]autorelease];
                [t setValue:@"0" forKey:@"selected"];
                [selectedItem_arr replaceObjectAtIndex:i withObject:t];
                [arrayToMail replaceObjectAtIndex:i withObject:t];

            }

            break;
        }
            
        default:
            break;
    }
    
    
    
    [myTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    // [self.tableView reloadData];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissModalViewControllerAnimated:YES];
    
}
-(IBAction) mailSentButtonPresed{
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    for (NSDictionary *itm in arrayToMail) {
        if ([itm valueForKey:@"Ticket_Image"]&&[itm valueForKey:@"Ticket_Image2"]) {
        [temp addObject:[itm valueForKey:@"Ticket_Image"]];
        [temp addObject:[itm valueForKey:@"Ticket_Image2"]];
        }
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    MFMailComposeViewController *mailComposer = [[[MFMailComposeViewController alloc] init] autorelease] ;
    mailComposer.mailComposeDelegate = self;
    if ([MFMailComposeViewController canSendMail]) {
        [mailComposer setToRecipients:nil];
        [mailComposer setSubject:@"Ticket Photo"];
        [mailComposer setMessageBody:@"Here is a copy of my tickets." isHTML:NO];
        for(NSString *name in temp ){
            NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",name] ];
            img = [[UIImage alloc]initWithContentsOfFile:getImagePath];
            [mailComposer addAttachmentData:[NSData dataWithData:UIImagePNGRepresentation(img)] mimeType:@"image/png" fileName:[NSString stringWithFormat:@"Ticket %@",name]];
        }
        mailComposer.navigationBar.tintColor = [UIColor blackColor];
        [self presentModalViewController:mailComposer animated:YES];  
    }
    
    [temp release];
    
}



@end
