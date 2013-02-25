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
    
    NSLog(@"array with images: %@", arrayImages);
    NSLog(@"object: %d", [arrayImages containsObject:anImage]);
    
    [anImage removeFromSuperview];
    [arrayImages removeObject:anImage];
    
    //lastImageTouched = NULL;
    
}

-(void)removeLabel:(NSNotification *)notification{
    IDACustomLabel *anLabel = (IDACustomLabel *)[notification object];
    
    NSLog(@"array with labels: %@", arrayLabels);
    NSLog(@"object: %d", [arrayLabels containsObject:anLabel]);
    [anLabel removeFromSuperview];
    [arrayLabels removeObject:anLabel];
    
    [self.scrollTextColors setHidden:TRUE];
}

-(void)touchedImage:(NSNotification *)notification{
    
    lastImageTouched = (IDALogoImage *)[notification object];
    isLastTouchedObjectLabel = FALSE;
    
    [self.scrollTextColors setHidden:TRUE]; 
}

-(void)touchedLabel:(NSNotification *)notification{
    
    lastLabelTouched = (IDACustomLabel *)[notification object];
    isLastTouchedObjectLabel = TRUE;
    
    [self.scrollTextColors setHidden:FALSE];
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
    
    //obtener colores y tallas del plist 
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DetailsProduct" ofType:@"plist"];
    NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:path];
    
    arrayColors = [[NSArray alloc] initWithArray:[root objectForKey:@"Color"]];
    arraySizes = [[NSArray alloc] initWithArray:[root objectForKey:@"Size"]];
    arrayTextColor = [[NSArray alloc] initWithArray:[root objectForKey:@"TextColor"]];
    
    [self putProductDetails];
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
    
    [self.scrollTextColors setHidden:TRUE];
}

- (void)putImageProduct{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MenuOptions" ofType:@"plist"];
    
    NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSArray *options = [root objectForKey:@"Options"];
    
    [imgProduct setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_Customize", [[options objectAtIndex:selectedProduct] objectForKey:@"Name"]]]];
    
}

- (void)putProductDetails{
    
    //color from the plist
    float width = 42;
    float height = 37;
    for (int i=0; i< [arrayColors count]; i++) {
        
        NSDictionary *color = [arrayColors objectAtIndex:i];
        
        UIButton *btnSize = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btnSize setFrame:CGRectMake(17, 10*(i+1) + height*i , width, height)];
        [btnSize setBackgroundColor:[UIColor colorWithRed:[[color objectForKey:@"Red"] floatValue]/255
                                                    green:[[color objectForKey:@"Green"] floatValue]/255
                                                     blue:[[color objectForKey:@"Blue"] floatValue]/255
                                                    alpha:1.0]];
        
        [self.scrollColors addSubview:btnSize];
        
    }
    
    [self.scrollColors setContentSize:CGSizeMake( self.scrollColors.frame.size.width, 10 * [arrayColors count] + height*([arrayColors count]))];
    //sizes from the plist
    width = 42;
    for (int i=0; i< [arraySizes count]; i++) {
        
        UIButton *btnSize = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [btnSize setFrame:CGRectMake(17, 10*(i+1) + height*i , width, height)];
        [btnSize setTitle:[arraySizes objectAtIndex:i] forState:UIControlStateNormal];
        
        [self.scrollSizes addSubview:btnSize];
        
    }
    
    [self.scrollSizes setContentSize:CGSizeMake(self.scrollSizes.frame.size.width, 10 * [arraySizes count] + height*([arraySizes count]) )];
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
    
}

- (void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:@"Failed to saved the image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
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
    
    if (![@"" isEqualToString:txtMessage.text]) {
        
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
}

- (IBAction)onTapWriteMessage:(id)sender {
    
    if (txtMessage) {
        return;
    }
    
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

- (void)onTapCancelCustomLabel:(id)Sender{
    
    [txtMessage setDelegate:nil];
    [txtMessage removeFromSuperview];
    txtMessage = nil;
    
    NSMutableArray *arrayItems = [[NSMutableArray alloc] initWithArray:self.toolBar.items];
    
    [arrayItems removeLastObject];
    
    self.toolBar.items = arrayItems;
    
    [self.scrollTextColors setHidden:TRUE];
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
    
    if (txtMessage == nil) {
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
    [self setScrollSizes:nil];
    [self setScrollColors:nil];
    [self setScrollTextColors:nil];
    [super viewDidUnload];
}
@end
