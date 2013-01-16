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

@interface CustomizeProductViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UIPopoverControllerDelegate, MFMailComposeViewControllerDelegate, UITextFieldDelegate>{
    
    int selectedProduct;
    UIView *viewContentSpace;
    
    NSMutableArray *arrayImages;
    NSMutableArray *arrayLabels;
    
    UITextField *txtMessage;
    
}

@property(nonatomic) int selectedProduct;
@property (strong, nonatomic) IBOutlet UIImageView *imgProduct;
@property (strong, nonatomic) IBOutlet UIView *viewContentSpace;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) UIPopoverController *libraryPopoverController;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnCamara;

- (IBAction)onTouchCancel;
- (void)putImageProduct;
- (IBAction)onTapLoadImage:(id)sender;
- (IBAction)onTapWriteMessage:(id)sender;
- (void)onTapCancelCustomLabel:(id)Sender;


@end
