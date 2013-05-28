//
//  EditLabelViewController.h
//  idakoosProjectFinal
//
//  Created by Ricardo Herrera Valle on 17/05/13.
//  Copyright (c) 2013 Idakoos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDACustomLabel.h"

enum KStateCustomize {
    KNonState = 0,
    KEditingLabel = 1,
    KEditingImage = 2,
    KCreatingLabel = 3,
    KCreatingImage = 4,
    KEditingAll = 5
};

@interface EditLabelViewController : UIViewController{
    
    IDACustomLabel *lblTexto;
    NSArray *arrayTextColor;
    
    NSMutableArray *arrayLabel;
    NSMutableArray *arraytextEdit;
    
    int state;
    
    float _size;
    int _posColor;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollTextColors;
@property (strong, nonatomic) IBOutlet UITextField *txtTexto;
@property (strong, nonatomic) IBOutlet UILabel *lblSize;
@property (strong, nonatomic) IBOutlet UIButton *btnAddText;
@property (strong, nonatomic) IBOutlet UIButton *btnRemoveText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
          labelToEdit:(IDACustomLabel *)lblToEdit;

// customize text
- (IBAction)onTapModifyTextSize:(id)sender;

- (void)customizeLabel:(NSString *)text;
- (void)customizeTextFields;

- (void)onTapTextColor:(id)Sender;
//Customize view
- (void)putTextColors;
- (void)addTextView;
- (void)removeTextView;

//View Action
- (IBAction)onTapCancel:(id)sender;
- (IBAction)onTapSave:(id)sender;

-(IBAction)onTapMoreOrLessLines:(id)sender;

@end
