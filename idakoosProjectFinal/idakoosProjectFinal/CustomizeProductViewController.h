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

#import "ColorPickerViewController.h"
#import "SizesPickerViewController.h"
#import "EditLabelViewController.h"

enum KStateCustomize {
    KNonState = 0,
    KEditingLabel = 1,
    KEditingImage = 2,
    KCreatingLabel = 3,
    KCreatingImage = 4
    };

@interface CustomizeProductViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UIPopoverControllerDelegate, MFMailComposeViewControllerDelegate, UITextFieldDelegate,
    ColorPickerDelegate, SizesPickerDelegate>{
    
    int selectedProduct;
    int selectedTextColor;
    UIView *viewContentSpace;
    
    NSMutableArray *arrayImages;
    NSMutableArray *arrayLabels;
    
    NSArray *arrayColors;
    NSArray *arraySizes;
    
    BOOL isLastTouchedObjectLabel;
    
    IDALogoImage *lastImageTouched;
    IDACustomLabel *lastLabelTouched;
    
    UIToolbar *aToolBar;
        
    int state;
    
}

@property(nonatomic) int selectedProduct;
@property (strong, nonatomic) IBOutlet UIImageView *imgProduct;
@property (strong, nonatomic) IBOutlet UIView *viewContentSpace;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) UIPopoverController *libraryPopoverController;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnCamara;
@property (strong, nonatomic) IBOutlet UIToolbar *aToolBar;
@property (strong, nonatomic) IBOutlet UIButton *btnEditLabel;

@property (nonatomic, strong) ColorPickerViewController *colorPicker;
@property (nonatomic, strong) SizesPickerViewController *sizePicker;
@property (nonatomic, strong) UIPopoverController *colorPickerPopover;

-(IBAction)chooseColorButtonTapped:(id)sender;
-(IBAction)chooseSizeButtonTapped:(id)sender;


- (void)putImageProduct;

- (IBAction)onTouchCancel;
- (IBAction)onTapLoadImage:(id)sender;
- (IBAction)onTapWriteMessage:(id)sender;
- (IBAction)onTapExport:(id)sender;
- (IBAction)onTapRotateObject:(id)sender;
- (IBAction)onTapChangeSizeObject:(id)sender;
- (IBAction)onTapEditLabel:(id)sender;

#pragma mark Notification Methods
-(void)receiveCustomLabel:(NSNotification *)notification;
-(void)removeImage:(NSNotification *)notification;
-(void)removeLabel:(NSNotification *)notification;

-(void)touchedImage:(NSNotification *)notification;
-(void)touchedLabel:(NSNotification *)notification;

#pragma mark show methods
- (void)_setVisibleItemsForText:(BOOL)showItems;

#pragma mark align method
- (IBAction)ontapAlignButton:(id)sender;
- (IBAction)onTapSendTo:(id)sender;




@end
