//
//  EditLabelViewController.h
//  idakoosProjectFinal
//
//  Created by Ricardo Herrera Valle on 17/05/13.
//  Copyright (c) 2013 Idakoos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDACustomLabel.h"

@interface EditLabelViewController : UIViewController{
    
    IDACustomLabel *lblTexto;
    NSArray *arrayTextColor;
    
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollTextColors;
@property (strong, nonatomic) IBOutlet UITextField *txtTexto;
@property (strong, nonatomic) IBOutlet UILabel *lblSize;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
          labelToEdit:(IDACustomLabel *)lblToEdit;

// customize text
- (IBAction)onTapModifyTextSize:(id)sender;

- (void)onTapTextColor:(id)Sender;
//Customize view
- (void)putTextColors;

//View Action
- (IBAction)onTapCancel:(id)sender;
- (IBAction)onTapSave:(id)sender;

@end
