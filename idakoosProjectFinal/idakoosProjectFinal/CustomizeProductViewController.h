//
//  CustomizeProductViewController.h
//  idakoosProjectFinal
//
//  Created by Ricardo Herrera Valle on 13/01/13.
//  Copyright (c) 2013 Idakoos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <QuartzCore/QuartzCore.h>

@interface CustomizeProductViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UIPopoverControllerDelegate, MFMailComposeViewControllerDelegate>{
    
    int selectedProduct;
    UIImageView *imgContentSpace;
    
    NSMutableArray *arrayImages;
    
}

@property(nonatomic) int selectedProduct;
@property (strong, nonatomic) IBOutlet UIImageView *imgProduct;
@property (strong, nonatomic) IBOutlet UIImageView *imgContentSpace;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) UIPopoverController *libraryPopoverController;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnCamara;

- (IBAction)onTouchCancel;
- (void)putImageProduct;
- (IBAction)onTapLoadImage:(id)sender;
- (IBAction)onTapWriteMessage:(id)sender;


@end
