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

#import "IDALogoImage.h"
#import "IDACustomLabel.h"

@interface CustomizeProductViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UIPopoverControllerDelegate, MFMailComposeViewControllerDelegate, UITextFieldDelegate>{
    
    int selectedProduct;
    UIView *viewContentSpace;
    
    NSMutableArray *arrayImages;
    NSMutableArray *arrayLabels;
    
    UITextField *txtMessage;
    
    BOOL isLastTouchedObjectLabel;
    
    IDALogoImage *lastImageTouched;
    IDACustomLabel *lasLabelTouched;
    
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

-(void)removeImage:(NSNotification *)notification;
-(void)removeLabel:(NSNotification *)notification;

-(void)touchedImage:(NSNotification *)notification;
-(void)touchedLabel:(NSNotification *)notification;


@end
