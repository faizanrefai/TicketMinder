//
//  TicketImageFullView.m
//  TicketMinder
//
//  Created by openxcell121 on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TicketImageFullView.h"

@implementation TicketImageFullView
@synthesize scrollView;
@synthesize changeBtn;
@synthesize ticketImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma  mark -  Picker Camera Delegate


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker1{
    
    imagePickerController=Nil;
    [imagePickerController release];
    [picker1 dismissModalViewControllerAnimated:YES];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker1 didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [picker1 dismissModalViewControllerAnimated:YES];
    picker1=nil;

    
       selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
    if (selectedImage.imageOrientation == UIImageOrientationUp){ 
        
      //  return selectedImage;
    
    }
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
   
    CGAffineTransform transform = CGAffineTransformIdentity;
  
    switch (selectedImage.imageOrientation) {
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
           // transform = CGAffineTransformScale(transform, -1, 1);
            break;
        
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:{
            transform = CGAffineTransformTranslate(transform, selectedImage.size.height, 0);
           // transform = CGAffineTransformScale(transform, -1, 1);
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
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,selectedImage.size.width,selectedImage.size.height), selectedImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
   selectedImage = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);

     
    
    
    if (cameraBtn==1) {
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            //For Image 1
            NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",imageName]];
            UIImage *image =selectedImage ; // imgProfile is the image which you are fetching from url
            NSData *imageData = UIImagePNGRepresentation(image);
            [imageData writeToFile:savedImagePath atomically:YES]; 
                    
            
            
        }else if (cameraBtn==2){
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            //For Image 1
            NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",imageName]];
            UIImage *image =selectedImage ; // imgProfile is the image which you are fetching from url
            NSData *imageData = UIImagePNGRepresentation(image);
            [imageData writeToFile:savedImagePath atomically:YES]; 
            

        }
   
    self.ticketImageView.image = selectedImage;

}





#pragma mark - View lifecycle
-(void)setTicket:(UIImageView *)ticketImageView1  cameraBtn:(int)btnNo  imageName:(NSString *)imgName{

    img = [[UIImage alloc]init];
    imageName = [[NSMutableString alloc]initWithFormat:imgName];
    img = ticketImageView1.image;
    
    cameraBtn =btnNo;

}
-(void)viewWillDisappear:(BOOL)animated{
   // self.navigationController.navigationBarHidden = TRUE;
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
  
        switch (buttonIndex) {
            case 0:{
                
                if (imagePickerController) {
                    imagePickerController=Nil;
                    [imagePickerController release];
                    
                }
                imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.delegate = self;
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
//                imagePickerController.allowsEditing = TRUE;
                NSArray* mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                imagePickerController.mediaTypes = mediaTypes;
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                
                [self.navigationController presentModalViewController:imagePickerController animated:YES];
                
                break;
            }
            default:
                break;
        }
    
    
    
}


-(IBAction)changeBtnPressed:(id)sender{
    
    UIActionSheet *ExpArea = [[UIActionSheet alloc] initWithTitle:@"Select Photo From" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Photo Album", nil];
	ExpArea.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    ExpArea.tag=2;
	[ExpArea showInView:self.view];
    [ExpArea release];
    
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{


}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{

    return ticketImageView;

}
-(IBAction)backGo:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [scrollView setZoomScale:900 animated:YES];
    scrollView.contentSize = CGSizeMake(900, 900);
    scrollView.contentSize = CGSizeMake(ticketImageView.frame.size.width, ticketImageView.frame.size.height);
	scrollView.maximumZoomScale = 4.0;
	scrollView.minimumZoomScale = 0.75;
	scrollView.clipsToBounds = YES;
	scrollView.delegate = self;
    
    
    
   
    
    float hfactor = ticketImageView.frame.size.width / 320;
    float vfactor = ticketImageView.frame.size.height / 440;
    
    float factor = fmax(hfactor, vfactor);
    
    // Divide the size by the greater of the vertical or horizontal shrinkage factor
    float newWidth = ticketImageView.frame.size.width / factor;
    float newHeight = ticketImageView.frame.size.height / factor;
    
    // Then figure out if you need to offset it to center vertically or horizontally
    float leftOffset = (320 - newWidth) / 2;
    float topOffset = (440 - newHeight) / 2;
    
    CGRect newRect = CGRectMake(leftOffset, topOffset, newWidth, newHeight);        
   // NSLog(@"new rect %@",newRect);
    ticketImageView.frame = newRect;
    
    
    
    
   // self.ticketImageView.frame = CGRectMake(0,0, img.size.width, img.size.height);
    self.ticketImageView.image = img;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTicketImageView:nil];
    [self setChangeBtn:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [ticketImageView release];
    [changeBtn release];
    [scrollView release];
    [super dealloc];
}
@end
