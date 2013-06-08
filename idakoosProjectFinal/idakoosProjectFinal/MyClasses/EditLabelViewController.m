//
//  EditLabelViewController.m
//  idakoosProjectFinal
//
//  Created by Ricardo Herrera Valle on 17/05/13.
//  Copyright (c) 2013 Idakoos. All rights reserved.
//

#import "EditLabelViewController.h"

@interface EditLabelViewController ()

@end

@implementation EditLabelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
          labelToEdit:(IDACustomLabel *)lblToEdit
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        lblTexto = lblToEdit;
        state = KEditingLabel;
        
        if (!lblTexto) {
            state = KCreatingLabel;
            _size = 16.0f;
            _posColor = 1;
            _font = @"60sekuntia";
            
        }else{
            _size = lblTexto._textSize;
            _posColor = lblTexto._PosColor;
            _font = lblTexto._font;
        }
    }
    return self;
}

- (void)customizeLabel:(NSString *)text{
    
    NSDictionary *color = [arrayTextColor objectAtIndex:_posColor];
    IDACustomLabel *lblNew = [[IDACustomLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
    
    [lblNew setText:text];
    [lblNew set_Red:[[color objectForKey:@"Red"] floatValue]];
    [lblNew set_Green:[[color objectForKey:@"Green"] floatValue]];
    [lblNew set_Blue:[[color objectForKey:@"Blue"] floatValue]];
    [lblNew setTextColor:[UIColor colorWithRed:[[color objectForKey:@"Red"] floatValue]/255
                                           green:[[color objectForKey:@"Green"] floatValue]/255
                                            blue:[[color objectForKey:@"Blue"] floatValue]/255
                                           alpha:1.0]];
    [lblNew setBackgroundColor:[UIColor clearColor]];
    [lblNew setNumberOfLines:1];
    [lblNew setTextAlignment:NSTextAlignmentCenter];
    [lblNew setFont:[UIFont fontWithName:_font size:_size]];
    lblNew._textSize = _size;
    lblNew._PosColor = _posColor;
    lblNew._font = _font;
    [lblNew setUserInteractionEnabled:TRUE];
    [lblNew sizeToFit];
    
    [arrayLabel addObject:lblNew];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //initialize variables
    arrayLabel = [[NSMutableArray alloc] init];
    arraytextEdit = [[NSMutableArray alloc] init];
    [arraytextEdit addObject:_txtTexto];
    
    //obtener colores y tallas del plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DetailsProduct" ofType:@"plist"];
    NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:path];
    arrayTextColor = [[NSArray alloc] initWithArray:[root objectForKey:@"TextColor"]];
    
    [self putTextColors];
    
    _txtTexto.text = lblTexto.text;
    _txtTexto.font = [UIFont fontWithName:@"System" size:_size];
    
    if (lblTexto) {
        [self.btnRemoveText setHidden:TRUE];
        [self.btnAddText setHidden:TRUE];
        [self customizeTextFields];
        self.lblSize.text = [NSString stringWithFormat:@"%.2f", _size];
    }
    
    [self.lblFont setFont:[UIFont fontWithName:_font size:30.0f]];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:TRUE];
    
    if (_fontPickerPopover) {
        [_fontPickerPopover dismissPopoverAnimated:YES];
        _fontPickerPopover = nil;
    }
}

#pragma mark customize text

- (IBAction)onTapModifyTextSize:(id)sender {
    
    float constant = 2;
    
    switch ([sender tag]) {
        case 0:
            constant *= -1;
            if (_size + constant <= 5) {
                return;
            }
            break;
            
        default:
            
            if (_size + constant > 40) {
                return;
            }
            break;
    }
    
    
    _size += constant;

    self.lblSize.text = [NSString stringWithFormat:@"%.2f", _size];
    
}

- (void)onTapTextColor:(id)Sender{
    
    
    _posColor = [Sender tag];
    
    [self customizeTextFields];
}

- (void)customizeTextFields{
    
    NSDictionary *color = [arrayTextColor objectAtIndex:_posColor];
    
    for (int i = 0; i < [arraytextEdit count]; i++) {
        UITextField *aTxt = [arraytextEdit objectAtIndex:i];
        [aTxt setTextColor:[UIColor colorWithRed:[[color objectForKey:@"Red"] floatValue]/255
                                           green:[[color objectForKey:@"Green"] floatValue]/255
                                            blue:[[color objectForKey:@"Blue"] floatValue]/255
                                           alpha:1.0]];
    }
}

- (IBAction)onTapSelectFont:(id)sender {
    
    UIButton *aButton = (UIButton *)sender;
    
    //Hide popover
    if (_fontPickerPopover) {
        [_fontPickerPopover dismissPopoverAnimated:YES];
        _fontPickerPopover = nil;
    }
    
    if (_fontPicker == nil) {
        //Create the FontPickerViewController.
        _fontPicker = [[FontsPickerViewController alloc] initWithStyle:UITableViewStylePlain];
        
        //Set this VC as the delegate.
        _fontPicker.delegate = self;
    }
    
    if (_fontPickerPopover == nil) {
        //The font picker popover is not showing. Show it.
        _fontPickerPopover = [[UIPopoverController alloc] initWithContentViewController:_fontPicker];
        [_fontPickerPopover presentPopoverFromRect:aButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:TRUE];
    } else {
        //The font picker popover is showing. Hide it.
        [_fontPickerPopover dismissPopoverAnimated:YES];
        _fontPickerPopover = nil;
    }
}

#pragma mark customize view
- (void)putTextColors{
    
    float width = 43;
    
    for (int i=0; i<[arrayTextColor count]/2; i++) {
        NSDictionary *color = [arrayTextColor objectAtIndex:i];
        
        UIButton *btnTextColor = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btnTextColor setFrame:CGRectMake(10 * (i+1) + width * i, 10, width, 43)];
        [btnTextColor setBackgroundColor:[UIColor colorWithRed:[[color objectForKey:@"Red"] floatValue]/255
                                                         green:[[color objectForKey:@"Green"] floatValue]/255
                                                          blue:[[color objectForKey:@"Blue"] floatValue]/255
                                                         alpha:1.0]];
        
        
        [btnTextColor setTag:i];
        [btnTextColor addTarget:self action:@selector(onTapTextColor:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollTextColors addSubview:btnTextColor];
    }
    
    int i = 0;
    
    for (int k=[arrayTextColor count]/2; k<[arrayTextColor count]; k++) {
        NSDictionary *color = [arrayTextColor objectAtIndex:k];
        
        UIButton *btnTextColor = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btnTextColor setFrame:CGRectMake(10 * (i+1) + width * i, 64, width, 43)];
        [btnTextColor setBackgroundColor:[UIColor colorWithRed:[[color objectForKey:@"Red"] floatValue]/255
                                                         green:[[color objectForKey:@"Green"] floatValue]/255
                                                          blue:[[color objectForKey:@"Blue"] floatValue]/255
                                                         alpha:1.0]];
        
        [btnTextColor setTag:k];
        [btnTextColor addTarget:self action:@selector(onTapTextColor:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollTextColors addSubview:btnTextColor];
        i++;
    }
    
    [self.scrollTextColors setContentSize:CGSizeMake(9 * ([arrayTextColor count]/2 +3) + width*([arrayTextColor count]/2 +1), self.scrollTextColors.frame.size.height)];
}

- (void)addTextView{
    
    if ([arraytextEdit count] < 5) {
        UITextField *txtToAdd = [[UITextField alloc] initWithFrame:CGRectMake(61, 43 + ((30+10)*[arraytextEdit count]), 299, 30)];
        
        [txtToAdd setText:@""];
        [txtToAdd setTextAlignment:NSTextAlignmentCenter];
        [txtToAdd setBorderStyle:UITextBorderStyleRoundedRect];
        NSDictionary *color = [arrayTextColor objectAtIndex:_posColor];
        [txtToAdd setTextColor:[UIColor colorWithRed:[[color objectForKey:@"Red"] floatValue]/255
                                           green:[[color objectForKey:@"Green"] floatValue]/255
                                            blue:[[color objectForKey:@"Blue"] floatValue]/255
                                           alpha:1.0]];
        
        [self.btnAddText setCenter:CGPointMake(self.btnAddText.center.x, txtToAdd.center.y)];
        [self.btnRemoveText setCenter:CGPointMake(self.btnRemoveText.center.x, txtToAdd.center.y)];
        [self.view addSubview:txtToAdd];
        [arraytextEdit addObject:txtToAdd];
        
    }
    
}

- (void)removeTextView{
    
    if ([arraytextEdit count] > 1) {
        UITextField *txtCampo  = [arraytextEdit lastObject];
        [txtCampo removeFromSuperview];
        [arraytextEdit removeLastObject];
        
        [self.btnAddText setCenter:CGPointMake(_btnAddText.center.x, ((UITextField* )[arraytextEdit lastObject]).center.y)];
        [self.btnRemoveText setCenter:CGPointMake(_btnRemoveText.center.x, ((UITextField* )[arraytextEdit lastObject]).center.y)];
    }
}

#pragma mark View Actions

- (IBAction)onTapCancel:(id)sender {
    [self dismissModalViewControllerAnimated:TRUE];
}

- (IBAction)onTapSave:(id)sender {
    
    for (int i = 0; i< [arraytextEdit count]; i++) {
        UITextField *txtTemp = [arraytextEdit objectAtIndex:i];
        if (![@"" isEqualToString:txtTemp.text]) {
            [self customizeLabel:txtTemp.text];
            IDACustomLabel *aLabel = [arrayLabel lastObject];
            [aLabel modifyTextColor];
        }
    
    }
    if ([arrayLabel count] > 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReceiveCustomLabel_iPad" object:arrayLabel];
    }
    [self onTapCancel:NULL];
}

-(IBAction)onTapMoreOrLessLines:(id)sender{
    
    if ([sender tag] == 0) {
        [self addTextView];
    }else{
        [self removeTextView];
    }
}

#pragma mark fontDelegate
-(void)SelectedFont:(NSString *)theFont{
    _font = [theFont substringToIndex:theFont.length - 4];
    [self.lblFont setFont:[UIFont fontWithName:_font size:30.0f]];
}


#pragma mark memory handling
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {

    [self setScrollTextColors:nil];
    [self setTxtTexto:nil];
    [self setLblSize:nil];
    [self setBtnAddText:nil];
    [self setBtnRemoveText:nil];
    [self setLblFont:nil];
    [super viewDidUnload];
}
@end
