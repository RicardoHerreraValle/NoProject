//
//  IDAViewController.h
//  IdakoosProject
//
//  Created by NSS MAC2 on 12/12/12.
//  Copyright (c) 2012 Idakoos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <QuartzCore/QuartzCore.h>

@class IDALogoImage;
@interface IDAViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UIPopoverControllerDelegate,
                                                 MFMailComposeViewControllerDelegate>

{
    NSMutableArray *arrayImages;
    
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCamara;
@property (weak, nonatomic) IBOutlet UIImageView *imgContentSpace;
@property (weak, nonatomic) IBOutlet UIImageView *imgClothPreview;
@property (strong, nonatomic) UIPopoverController *libraryPopoverController;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

- (IBAction)onTapLoadImage:(id)sender;
- (IBAction)sendPhoto:(id)sender;


@end
