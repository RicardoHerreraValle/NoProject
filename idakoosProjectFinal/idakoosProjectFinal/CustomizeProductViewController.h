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
    
    NSArray *arrayColors;
    NSArray *arraySizes;
    
    UITextField *txtMessage;
    
    BOOL isLastTouchedObjectLabel;
    
    IDALogoImage *lastImageTouched;
    IDACustomLabel *lastLabelTouched;
    
    UIToolbar *aToolBar;
    
}

@property(nonatomic) int selectedProduct;
@property (strong, nonatomic) IBOutlet UIImageView *imgProduct;
@property (strong, nonatomic) IBOutlet UIView *viewContentSpace;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) UIPopoverController *libraryPopoverController;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnCamara;
@property (strong, nonatomic) IBOutlet UIToolbar *aToolBar;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollSizes;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollColors;


- (void)putImageProduct;
- (void)putProductDetails;

- (IBAction)onTouchCancel;
- (IBAction)onTapLoadImage:(id)sender;
- (IBAction)onTapWriteMessage:(id)sender;
- (void)onTapCancelCustomLabel:(id)Sender;

-(void)removeImage:(NSNotification *)notification;
-(void)removeLabel:(NSNotification *)notification;

-(void)touchedImage:(NSNotification *)notification;
-(void)touchedLabel:(NSNotification *)notification;

#pragma mark align method
- (IBAction)ontapAlignButton:(id)sender;
- (IBAction)onTapSendTo:(id)sender;




@end
