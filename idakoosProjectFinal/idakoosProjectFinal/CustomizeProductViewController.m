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
#pragma mark on touch button
- (IBAction)onTouchCancel{
    [self dismissModalViewControllerAnimated:TRUE];
    
}

#pragma mark notification methods
-(void)removeImage:(NSNotification *)notification{
    IDALogoImage *anImage = (IDALogoImage *)[notification object];
    
    [anImage removeFromSuperview];
    [arrayImages removeObject:anImage];
    
}

-(void)removeLabel:(NSNotification *)notification{
    IDACustomLabel *anLabel = (IDACustomLabel *)[notification object];
    
    [anLabel removeFromSuperview];
    [arrayLabels removeObject:anLabel];
}

-(void)touchedImage:(NSNotification *)notification{
    
    lastImageTouched = (IDALogoImage *)[notification object];
    isLastTouchedObjectLabel = FALSE;
}

-(void)touchedLabel:(NSNotification *)notification{
    
    lasLabelTouched = (IDACustomLabel *)[notification object];
    isLastTouchedObjectLabel = TRUE;
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
    
    //notification intialization
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeImage:) name:@"removeCustomImage_iPad" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeLabel:) name:@"removeCustomLabel_iPad" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchedImage:) name:@"touchImage_iPad" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchedLabel:) name:@"touchLabel_iPad" object:nil];
    
}

- (void)putImageProduct{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MenuOptions" ofType:@"plist"];
    
    NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSArray *options = [root objectForKey:@"Options"];
    
    [imgProduct setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_Customize", [[options objectAtIndex:selectedProduct] objectForKey:@"Name"]]]];
    
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
        
        IDACustomLabel *lblCustom = [[IDACustomLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 80) withContenSpace:viewContentSpace];
        
        [lblCustom setText:txtMessage.text];
        [lblCustom setBackgroundColor:[UIColor whiteColor]];
        [lblCustom setNumberOfLines:2];
        [lblCustom setTextAlignment:NSTextAlignmentCenter];
        [lblCustom setFont:[UIFont fontWithName:@"System" size:17.0f]];
        [lblCustom setCenter:viewContentSpace.center];
        [lblCustom setUserInteractionEnabled:TRUE];
        [self.view addSubview:lblCustom];
        [viewContentSpace setUserInteractionEnabled:TRUE];
        [arrayLabels addObject:lblCustom];
        
    }
    
    [self onTapCancelCustomLabel:nil];
    
    return YES;
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
}

- (void)onTapCancelCustomLabel:(id)Sender{
    
    [txtMessage setDelegate:nil];
    [txtMessage removeFromSuperview];
    txtMessage = nil;
    
    NSMutableArray *arrayItems = [[NSMutableArray alloc] initWithArray:self.toolBar.items];
    
    [arrayItems removeLastObject];
    
    self.toolBar.items = arrayItems;
}

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
    [super viewDidUnload];
}
@end
