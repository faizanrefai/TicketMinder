//
//  ViewTicket.m
//  TicketMinder
//
//  Created by openxcell121 on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewTicket.h"
#define kAnimationKey @"transitionViewAnimation"

@implementation ViewTicket
@synthesize segmentControl;
@synthesize myTableView;



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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    [segmentControl addTarget:self action:@selector(segmentControlIndexes:) forControlEvents:UIControlEventValueChanged];
    self.title = @"View Ticket";
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    myTableView.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editPressed)];
    self.navigationItem.rightBarButtonItem = edit;
    [edit release];
}
-(void)editPressed{

    if (![myTableView isEditing]) {
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
        [myTableView setEditing:YES animated:YES];
   
    }else{
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStylePlain];
        [myTableView setEditing:NO animated:YES];
    }
}
-(IBAction)edit:(id)sender{
    if ([myTableView isEditing]) {
        [self.myTableView setEditing:FALSE animated:YES];

    }else{
        [self.myTableView setEditing:TRUE animated:YES];
    }
}
-(IBAction)backGo:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [self setSegmentControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    // loadedStringDate has the value "08-12-2010"
    self.title = @"View Ticket";
    DAL *databaseObject = [[[DAL alloc]initDatabase:@"AddTicketDatabase"]autorelease];
    databaseResponseArray=  [[NSMutableArray alloc]initWithArray:[databaseObject SelectWithStar:@"Ticket_Detail"]];
    NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"Ticket_Name" ascending:YES];
    [databaseResponseArray sortUsingDescriptors:[NSArray arrayWithObject:nameSort]];
    [myTableView reloadData];
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.title=@"Back";
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
   // [tableView reloadSections: withRowAnimation:UITableViewRowAnimationAutomatic];
    
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
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20.0 ];;

    UIImageView *ima = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellBack.png"]];
    [cell setBackgroundView:ima];
    [ima release];
    tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBack.png"]];
   UIImageView *arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow.png"]];
    cell.accessoryView = arrow;
    [arrow release];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.detailTextLabel.text=[[databaseResponseArray objectAtIndex:indexPath.row]valueForKey:@"Expiry_Date"];
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
    
    NSComparisonResult result = [Date1 compare:Date2];
    
    if (result==NSOrderedAscending) {
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.textColor = [UIColor whiteColor];  
        
       // NSLog(@"Date1 is in the future");
        
    } else if (result==NSOrderedDescending) {
       // NSLog(@"Expired dates ");
        cell.textLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.textColor = [UIColor redColor];
    } else {
        
       // NSLog(@"Both dates are the same");
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
    }

//    CATransition *animation = [CATransition animation];
//    [animation setDelegate:self];
//    // Set the type and if appropriate direction of the transition, 
//    [animation setType:kCATransitionFade];
//    // Set the duration and timing function of the transtion -- duration is passed in as a parameter, use ease in/ease out as the timing function
//    [animation setDuration:0.5];
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    [cell.layer addAnimation:animation forKey:@"transitionViewAnimation"];
    
    return cell;
}

-(void)segmentControlIndexes:(id)sender{
    
    UISegmentedControl *segCtrl = (UISegmentedControl*)sender;
    switch (segCtrl.selectedSegmentIndex) {
        case 0:{
            NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"Ticket_Name" ascending:YES];
            [databaseResponseArray sortUsingDescriptors:[NSArray arrayWithObject:nameSort]];
            
            break;
        }
        case 1:{
            
            NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"Ticket_Issuer" ascending:YES];
            [databaseResponseArray sortUsingDescriptors:[NSArray arrayWithObject:nameSort]];
            
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
            nameSort=nil;
            NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
            [dateFormat1  setDateFormat:@"dd MMM yyyy"];    
            
            for (int i=0;[ databaseResponseArray count]>i; i++) {
                dateStr = [[dateFormat1 stringFromDate:[[databaseResponseArray objectAtIndex:i]valueForKey:@"Expiry_Date"]] retain];  
                [[databaseResponseArray objectAtIndex:i]setObject:dateStr forKey:@"Expiry_Date"];
            }
            [dateFormat1 release];
            dateStr=nil;
              break;
        }
        case 3:{
            NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"Location" ascending:YES];
            [databaseResponseArray sortUsingDescriptors:[NSArray arrayWithObject:nameSort]];
            
            break;
        }
            
        default:
            break;
    }
    
    [myTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    // [self.tableView reloadData];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSString *str =[NSString stringWithFormat:@"%@",[[databaseResponseArray objectAtIndex:indexPath.row]valueForKey:@"id"]] ;
        DAL *databaseObject = [[DAL alloc]initDatabase:@"AddTicketDatabase"];
        [databaseObject deleteFromTable:@"Ticket_Detail" WhereField:@"id=" Condition:str];
        [databaseObject release];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];  
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
        NSString *documentsDirectory = [paths objectAtIndex:0];  
         
        NSString *fullPath1 = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", [[databaseResponseArray objectAtIndex:indexPath.row]valueForKey:@"Ticket_Image"]]];  
        [fileManager removeItemAtPath: fullPath1 error:NULL];  
       
        NSString *fullPath2 = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", [[databaseResponseArray objectAtIndex:indexPath.row]valueForKey:@"Ticket_Image2"]]];  
        [fileManager removeItemAtPath: fullPath2 error:NULL];  
          NSLog(@"image removed");  
        [databaseResponseArray removeObjectAtIndex:[indexPath row]];
        // Delete the row from the data source
       
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
//{
//
//
//}
//
//// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}


#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Navigation logic may go here. Create and push another view controller.
    
     TicketDetailView *detailViewController = [[TicketDetailView alloc] initWithNibName:@"TicketDetailView" bundle:nil];
     // ...
    [detailViewController setDictinaryForDetail:[databaseResponseArray objectAtIndex:indexPath.row]];
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     
}

- (void)dealloc {
    [segmentControl release];
    
    [super dealloc];
}
@end
