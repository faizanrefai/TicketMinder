//
//  TicketImageFullView.h
//  TicketMinder
//
//  Created by openxcell121 on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <QuartzCore/QuartzCore.h>


@interface TicketImageFullView : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>
{
    UIImage *img;
    NSMutableString *imageName;
       UIImagePickerController * imagePickerController;
    int cameraBtn;
    UIImage *selectedImage;
}
@property (retain, nonatomic) IBOutlet UIImageView *ticketImageView;
-(IBAction)backGo:(id)sender;
-(void)setTicket:(UIImageView *)ticketImageView1  cameraBtn:(int)btnNo imageName:(NSString*)imgName;
@property (retain, nonatomic) IBOutlet UIButton *changeBtn;
-(IBAction)changeBtnPressed:(id)sender;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@end
