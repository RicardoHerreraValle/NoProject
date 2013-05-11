//
//  CustomizeProductViewController.m
//  idakoosProjectFinal
//
//  Created by Ricardo Herrera Valle on 13/01/13.
//  Copyright (c) 2013 Idakoos. All rights reserved.
//

#import "CustomizeProductViewController.h"

@interface CustomizeProductViewController ()

@end

@implementation CustomizeProductViewController

@synthesize selectedProduct;
@synthesize viewContentSpace, imgProduct;
@synthesize aToolBar;

#pragma mark notification methods
-(void)removeImage:(NSNotification *)notification{
    IDALogoImage *anImage = (IDALogoImage *)[notification object];
    
    [anImage removeFromSuperview];
    [arrayImages removeObject:anImage];
    
    //lastImageTouched = NULL;
    state = KNonState;
    
}

-(void)removeLabel:(NSNotification *)notification{
    IDACustomLabel *anLabel = (IDACustomLabel *)[notification object];
    
    [anLabel removeFromSuperview];
    [arrayLabels removeObject:anLabel];
    
    [self _setVisibleItemsForText:TRUE];
    
    state = KNonState;
}

-(void)touchedImage:(NSNotification *)notification{
    
    lastImageTouched = (IDALogoImage *)[notification object];
    isLastTouchedObjectLabel = FALSE;
    
    [self _setVisibleItemsForText:TRUE];
    
    state = KEditingImage;
}

-(void)touchedLabel:(NSNotification *)notification{
    
    lastLabelTouched = (IDACustomLabel *)[notification object];
    isLastTouchedObjectLabel = TRUE;
    
    [self _setVisibleItemsForText:false];
    
    state = KEditingLabel;
}
#pragma mark show methods
- (void)_setVisibleItemsForText:(BOOL)showItems{
    
    
    [self.scrollTextColors setHidden:showItems];
    if (!showItems) {
        [self.lblFontSize setText:[NSString stringWithFormat:@"%.1f", [lastLabelTouched _textSize]] ];
        
        
        if (txtMessage) {
            [txtMessage setDelegate:nil];
            [txtMessage removeFromSuperview];
            txtMessage = nil;
        }
        txtMessage = [[UITextField alloc] initWithFrame:CGRectMake(50, 50, 300, 40)];
        
        txtMessage.borderStyle = UITextBorderStyleRoundedRect;
        txtMessage.font = [UIFont systemFontOfSize:lastLabelTouched._textSize];
        txtMessage.text = lastLabelTouched.text;
        txtMessage.autocorrectionType = UITextAutocorrectionTypeNo;
        txtMessage.keyboardType = UIKeyboardTypeDefault;
        txtMessage.returnKeyType = UIReturnKeyDone;
        txtMessage.clearButtonMode = UITextFieldViewModeWhileEditing;
        txtMessage.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        txtMessage.delegate = self;
        
        [self.view addSubview:txtMessage];
        
        [txtMessage setCenter:CGPointMake(768/2, 1024/2)];
        [txtMessage becomeFirstResponder];
    }
    if (showItems && txtMessage) {
        [txtMessage setDelegate:nil];
        [txtMessage removeFromSuperview];
        txtMessage = nil;
    }
    
    [self.lblFontSize setHidden:showItems];
    [self.btnLessFont setHidden:showItems];
    [self.btnMoreFont setHidden:showItems];
}

#pragma mark initialization
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self putImageProduct];
    arrayImages = [[NSMutableArray alloc] init];
    arrayLabels = [[NSMutableArray alloc] init];
    
    state = KNonState;
    
    //obtener colores y tallas del plist 
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DetailsProduct" ofType:@"plist"];
    NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:path];
    
    arrayColors = [[NSArray alloc] initWithArray:[root objectForKey:@"Color"]];
    arraySizes = [[NSArray alloc] initWithArray:[root objectForKey:@"Size"]];
    arrayTextColor = [[NSArray alloc] initWithArray:[root objectForKey:@"TextColor"]];
    
    //[self putProductDetails];
    [self putTextColors];
    
    //black is the default text color
    selectedTextColor = 1;
    
    //notification intialization
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeImage:) name:@"removeCustomImage_iPad" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeLabel:) name:@"removeCustomLabel_iPad" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchedImage:) name:@"touchImage_iPad" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchedLabel:) name:@"touchLabel_iPad" object:nil];
    
    
    if ([aToolBar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
        [aToolBar setBackgroundImage:[UIImage imageNamed:@"Background_ToolBar.jpg"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    } else {
        [aToolBar insertSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background_ToolBar.jpg"]] atIndex:0];
    }
    
    [self _setVisibleItemsForText:TRUE];
}

- (void)putImageProduct{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MenuOptions" ofType:@"plist"];
    
    NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSArray *options = [root objectForKey:@"Options"];
    
    [imgProduct setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_Customize", [[options objectAtIndex:selectedProduct] objectForKey:@"Name"]]]];
    
}

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
    NSLog(@"width :%d",[arrayTextColor count]/2 +1);
    [self.scrollTextColors setContentSize:CGSizeMake(9 * ([arrayTextColor count]/2 +3) + width*([arrayTextColor count]/2 +1), self.scrollTextColors.frame.size.height)];
}

#pragma mark CameraMethods
- (void)chooseImagePhotoFromLibrary{
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.delegate = self;
    imagePicker.mediaTypes = [NSArray arrayWithObject:(NSString *) kUTTypeImage];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _libraryPopoverController = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
    [self.libraryPopoverController presentPopoverFromBarButtonItem:_btnCamara permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
}

- (void)takePhotoWithCamera{
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.delegate = self;
    imagePicker.mediaTypes = [NSArray arrayWithObject:(NSString *) kUTTypeImage];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing = YES;
    
    [self presentModalViewController:imagePicker animated:TRUE];
}

#pragma mark UIImagePickerViewDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [_libraryPopoverController dismissPopoverAnimated:TRUE];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //[self dismissViewControllerAnimated:TRUE completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        IDALogoImage *anImage = [[IDALogoImage alloc] initWithFrame:CGRectMake(arc4random()%100, arc4random()%100, 80, 80) withContenSpace:viewContentSpace];
        [(UIImageView *)anImage setImage:image];
        [anImage setUserInteractionEnabled:YES];
        [viewContentSpace addSubview:anImage];
        [arrayImages addObject:anImage];
    }
    
    state = KNonState;
    
}

- (void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:@"Failed to saved the image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    state = KNonState;
}

#pragma mark UIActionSheet Delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [actionSheet cancelButtonIndex]) {
        return;
    }
    
    if (buttonIndex == 0) {
        [self takePhotoWithCamera];
        
    }else{
        [self chooseImagePhotoFromLibrary];
    }
    
    
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"texto : %@", textField.text);
    
    if (![@"" isEqualToString:txtMessage.text] ) {
        
        if ( state == KCreatingLabel) {
            NSDictionary *color = [arrayTextColor objectAtIndex:selectedTextColor];
            IDACustomLabel *lblCustom = [[IDACustomLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
            
            [lblCustom setText:txtMessage.text];
            [lblCustom setTextColor:[UIColor colorWithRed:[[color objectForKey:@"Red"] floatValue]/255
                                                    green:[[color objectForKey:@"Green"] floatValue]/255
                                                     blue:[[color objectForKey:@"Blue"] floatValue]/255
                                                    alpha:1.0]];
            [lblCustom setBackgroundColor:[UIColor clearColor]];
            [lblCustom setNumberOfLines:2];
            [lblCustom setTextAlignment:NSTextAlignmentCenter];
            [lblCustom setFont:[UIFont fontWithName:@"System" size:17.0f]];
            [lblCustom setCenter:CGPointMake(viewContentSpace.frame.size.width/2, viewContentSpace.frame.size.height/2)];
            [lblCustom setUserInteractionEnabled:TRUE];
            [lblCustom sizeToFit];
            lblCustom.imgContentSpace = viewContentSpace;
            [viewContentSpace addSubview:lblCustom];
            [viewContentSpace setUserInteractionEnabled:TRUE];
            [arrayLabels addObject:lblCustom];
        }else{
            if (state == KEditingLabel) {
                lastLabelTouched.text = textField.text;
                [lastLabelTouched resizeToStretch];
                [lastLabelTouched adjustHeight];
            }
        }
        
        
    }
    
    [self onTapCancelCustomLabel:nil];
    
    return YES;
}

#pragma mark MFMailCompose Delegate
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error description] delegate:nil cancelButtonTitle:@"Accept" otherButtonTitles:nil];
        [alert show];
    }
    
    [controller removeFromParentViewController];
    [self dismissModalViewControllerAnimated:TRUE];
}

#pragma mark onTapMethods
- (IBAction)onTapLoadImage:(id)sender {
    
    if ([_libraryPopoverController isPopoverVisible]) {
        [_libraryPopoverController dismissPopoverAnimated:TRUE];
    }
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self chooseImagePhotoFromLibrary];
        return;
    }
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [self takePhotoWithCamera];
        return;
    }
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",
                                  @"Choose From Library", nil];
    [actionSheet showInView:self.view];
    
    state = KCreatingImage;
}

- (IBAction)onTapWriteMessage:(id)sender {
    
    if (state == KCreatingLabel) {
        return;
    }
    
    state = KCreatingLabel;
    
    UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onTapCancelCustomLabel:)];
    
    NSMutableArray *arrayItems = [[NSMutableArray alloc] initWithArray:self.toolBar.items];
    
    [arrayItems addObject:btnCancel];
    
    self.toolBar.items = arrayItems;
    
    txtMessage = [[UITextField alloc] initWithFrame:CGRectMake(50, 50, 300, 40)];
    
    txtMessage.borderStyle = UITextBorderStyleRoundedRect;
    txtMessage.font = [UIFont systemFontOfSize:15];
    txtMessage.placeholder = @"enter text";
    txtMessage.autocorrectionType = UITextAutocorrectionTypeNo;
    txtMessage.keyboardType = UIKeyboardTypeDefault;
    txtMessage.returnKeyType = UIReturnKeyDone;
    txtMessage.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtMessage.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtMessage.delegate = self;
    
    [self.view addSubview:txtMessage];
    [txtMessage setCenter:CGPointMake(768/2, 1024/2)];
    [txtMessage becomeFirstResponder];
    
    [self.scrollTextColors setHidden:FALSE];
}

- (IBAction)onTapExport:(id)sender {
    
    UIGraphicsBeginImageContext(viewContentSpace.frame.size);
    [viewContentSpace.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    MFMailComposeViewController *mailView = [[MFMailComposeViewController alloc] init];
    mailView.mailComposeDelegate = self;
    
    [mailView setToRecipients:[NSArray arrayWithObject:@"aherreric@gmail.com"]];
    [mailView addAttachmentData:UIImagePNGRepresentation(viewImage) mimeType:@"image/png" fileName:@"CameraImage"];
    
    [self presentModalViewController:mailView animated:TRUE];
}

- (IBAction)onTapRotateObject:(id)sender {
    
    if (lastImageTouched == NULL && lastLabelTouched == NULL ) {
        return;
    }
    
    switch ([sender tag]) {
        case 0://rotate to the right
            if (isLastTouchedObjectLabel) {
                lastLabelTouched.transform = CGAffineTransformRotate(lastLabelTouched.transform, M_PI/2);
            }else{
                lastImageTouched.transform = CGAffineTransformRotate(lastImageTouched.transform, M_PI/2);
            }
            break;
        case 1://rotate to the left
            if (isLastTouchedObjectLabel) {
                lastLabelTouched.transform = CGAffineTransformRotate(lastLabelTouched.transform, -M_PI/2);
            }else{
                lastImageTouched.transform = CGAffineTransformRotate(lastImageTouched.transform, -M_PI/2);
            }
            break;
            
        default:
            break;
    }
}

- (IBAction)onTapChangeSizeObject:(id)sender {
    
    if (lastImageTouched == NULL && lastLabelTouched == NULL ) {
        return;
    }
    float scaleIncrease = 1.3;
    float scaleDecrease = 1.0 - 0.23;
    
    switch ([sender tag]) {
        case 0://increase size
            if (isLastTouchedObjectLabel) {
                lastLabelTouched.transform = CGAffineTransformScale(lastLabelTouched.transform, scaleIncrease, scaleIncrease);
            }else{
                lastImageTouched.transform = CGAffineTransformScale(lastImageTouched.transform, scaleIncrease, scaleIncrease);
            }
            break;
        case 1://decrease size
            if (isLastTouchedObjectLabel) {
                lastLabelTouched.transform = CGAffineTransformScale(lastLabelTouched.transform, scaleDecrease, scaleDecrease);
            }else{
                lastImageTouched.transform = CGAffineTransformScale(lastImageTouched.transform, scaleDecrease, scaleDecrease);
            }
            break;
            
        default:
            break;
    }
}

- (void)onTapCancelCustomLabel:(id)Sender{
    
    [txtMessage setDelegate:nil];
    [txtMessage removeFromSuperview];
    txtMessage = nil;
    
    NSMutableArray *arrayItems = [[NSMutableArray alloc] initWithArray:self.toolBar.items];
    
    [arrayItems removeLastObject];
    
    self.toolBar.items = arrayItems;
    
    [self _setVisibleItemsForText:TRUE];
    state = KNonState;
}

- (IBAction)onTouchCancel{
    [self dismissModalViewControllerAnimated:TRUE];
    
}

- (IBAction)ontapAlignButton:(id)sender{
    
    if (lastLabelTouched == NULL && lastImageTouched == NULL) {
        return;
    }
    
    float viewWidth = viewContentSpace.frame.size.width;
    float viewHeight = viewContentSpace.frame.size.height;
    
    //align buttons
    switch ([sender tag]) {
        case 0:{//Left
            if (isLastTouchedObjectLabel) {
                [lastLabelTouched setCenter:CGPointMake(lastLabelTouched.frame.size.width/2, lastLabelTouched.center.y)];
            }else{
                [lastImageTouched setCenter:CGPointMake(lastImageTouched.frame.size.width/2, lastImageTouched.center.y)];
            }
            
        }   break;
        case 1:{//Center
            if (isLastTouchedObjectLabel) {
                [lastLabelTouched setCenter:CGPointMake(viewWidth/2 ,
                                                        lastLabelTouched.center.y)];
            }else{
                [lastImageTouched setCenter:CGPointMake(viewWidth/2 ,
                                                        lastImageTouched.center.y)];
            }
            
        }   break;
        case 2:{//Right
            if (isLastTouchedObjectLabel) {
                [lastLabelTouched setCenter:CGPointMake(viewWidth - lastLabelTouched.frame.size.width/2, lastLabelTouched.center.y)];
            }else{
                [lastImageTouched setCenter:CGPointMake(viewWidth - lastImageTouched.frame.size.width/2, lastImageTouched.center.y)];
            }
            
        }   break;
        case 3:{//Top
            if (isLastTouchedObjectLabel) {
                [lastLabelTouched setCenter:CGPointMake(lastLabelTouched.center.x, lastLabelTouched.frame.size.height/2)];
            }else{
                [lastImageTouched setCenter:CGPointMake(lastImageTouched.center.x, lastImageTouched.frame.size.height/2)];
            }
        }   break;
        case 4:{//Middle
            if (isLastTouchedObjectLabel) {
                [lastLabelTouched setCenter:CGPointMake(lastLabelTouched.center.x ,
                                                        viewHeight/2)];
            }else{
                [lastImageTouched setCenter:CGPointMake(lastImageTouched.center.x ,
                                                        viewHeight/2)];
            }
        }   break;
        case 5:{//Bottom
            if (isLastTouchedObjectLabel) {
                [lastLabelTouched setCenter:CGPointMake(lastLabelTouched.center.x,
                                                        viewHeight - lastLabelTouched.frame.size.height/2)];
            }else{
                [lastImageTouched setCenter:CGPointMake(lastImageTouched.center.x ,
                                                        viewHeight - lastImageTouched.frame.size.height/2)];
            }
        }   break;
            
        default:
            break;
    }
}

- (IBAction)onTapSendTo:(id)sender{
    
    if (lastLabelTouched == NULL && lastImageTouched == NULL) {
        return;
    }
    
    switch ([sender tag]) {
        case 0:
            if (isLastTouchedObjectLabel) {
                [viewContentSpace bringSubviewToFront:lastLabelTouched];
            }else{
                [viewContentSpace bringSubviewToFront:lastImageTouched];
            }
            break;
        case 1:
            if (isLastTouchedObjectLabel) {
                [viewContentSpace sendSubviewToBack:lastLabelTouched];
            }else{
                [viewContentSpace sendSubviewToBack:lastImageTouched];
            }
            break;
            
        default:
            break;
    }
}

- (void)onTapTextColor:(id)Sender{
    
    NSDictionary *color = [arrayTextColor objectAtIndex:[Sender tag]];
    
    if (state == KEditingLabel) {
        if (!isLastTouchedObjectLabel || lastLabelTouched == NULL) {
            return;
        }
        [lastLabelTouched setTextColor:[UIColor colorWithRed:[[color objectForKey:@"Red"] floatValue]/255
                                                       green:[[color objectForKey:@"Green"] floatValue]/255
                                                        blue:[[color objectForKey:@"Blue"] floatValue]/255
                                                       alpha:1.0]];
    }else{
        [txtMessage setTextColor:[UIColor colorWithRed:[[color objectForKey:@"Red"] floatValue]/255
                                                 green:[[color objectForKey:@"Green"] floatValue]/255
                                                  blue:[[color objectForKey:@"Blue"] floatValue]/255
                                                 alpha:1.0]];
        selectedTextColor = [Sender tag];
    }
    
}

- (IBAction)onTapChangeFontSize:(id)sender {
    
    if ([sender tag] == 0) {
        [lastLabelTouched modifyTextSize:-1];
    }else{
        [lastLabelTouched modifyTextSize:1];
    }
    
    [self.lblFontSize setText:[NSString stringWithFormat:@"%.0f", [lastLabelTouched _textSize]]];
}

#pragma mark - PopOverMethods
-(IBAction)chooseColorButtonTapped:(id)sender
{
    if (_colorPickerPopover) {
        [_colorPickerPopover dismissPopoverAnimated:YES];
        _colorPickerPopover = nil;
    }
    
    if (_colorPicker == nil) {
        //Create the ColorPickerViewController.
        _colorPicker = [[ColorPickerViewController alloc] initWithStyle:UITableViewStylePlain];
        
        //Set this VC as the delegate.
        _colorPicker.delegate = self;
    }
    
    if (_colorPickerPopover == nil) {
        //The color picker popover is not showing. Show it.
        _colorPickerPopover = [[UIPopoverController alloc] initWithContentViewController:_colorPicker];
        [_colorPickerPopover presentPopoverFromBarButtonItem:(UIBarButtonItem *)sender
                                    permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    } else {
        //The color picker popover is showing. Hide it.
        [_colorPickerPopover dismissPopoverAnimated:YES];
        _colorPickerPopover = nil;
    }
}

-(IBAction)chooseSizeButtonTapped:(id)sender{
    
    if (_colorPickerPopover) {
        [_colorPickerPopover dismissPopoverAnimated:YES];
        _colorPickerPopover = nil;
    }
    
    if (_sizePicker == nil) {
        //Create the ColorPickerViewController.
        _sizePicker = [[SizesPickerViewController alloc] initWithStyle:UITableViewStylePlain];
        
        //Set this VC as the delegate.
        _sizePicker.delegate = self;
    }
    
    if (_colorPickerPopover == nil) {
        //The color picker popover is not showing. Show it.
        _colorPickerPopover = [[UIPopoverController alloc] initWithContentViewController:_sizePicker];
        [_colorPickerPopover presentPopoverFromBarButtonItem:(UIBarButtonItem *)sender
                                    permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    } else {
        //The color picker popover is showing. Hide it.
        [_colorPickerPopover dismissPopoverAnimated:YES];
        _colorPickerPopover = nil;
    }
}

#pragma mark - PickerDelegate method
-(void)selectedColor:(int)posColor
{
    
    //Dismiss the popover if it's showing.
    if (_colorPickerPopover) {
        [_colorPickerPopover dismissPopoverAnimated:YES];
        _colorPickerPopover = nil;
    }
}

-(void)selectedSize:(int)posColor{
    
    if (_colorPickerPopover) {
        [_colorPickerPopover dismissPopoverAnimated:YES];
        _colorPickerPopover = nil;
    }
}

#pragma mark memory handling
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setImgProduct:nil];
    [self setViewContentSpace:nil];
    [self setToolBar:nil];
    [self setBtnCamara:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self setAToolBar:nil];
    [self setScrollTextColors:nil];
    [self setBtnMoreFont:nil];
    [self setBtnLessFont:nil];
    [self setLblFontSize:nil];
    [super viewDidUnload];
}
@end
