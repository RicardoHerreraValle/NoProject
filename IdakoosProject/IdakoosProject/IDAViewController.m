//
//  IDAViewController.m
//  IdakoosProject
//
//  Created by NSS MAC2 on 12/12/12.
//  Copyright (c) 2012 Idakoos. All rights reserved.
//

#import "IDAViewController.h"
#import "IDALogoImage.h"

@interface IDAViewController ()

@end

@implementation IDAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    arrayImages = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark IBAction Methods
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

- (IBAction)sendPhoto:(id)sender {
    /*
    CALayer *layer;
    layer = self.view.layer;
    UIGraphicsBeginImageContext(self.view.bounds.size);
    CGContextClipToRect (UIGraphicsGetCurrentContext(),_imgContentSpace.frame);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    */
    
    UIGraphicsBeginImageContext(_imgContentSpace.frame.size);
    [_imgContentSpace.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    MFMailComposeViewController *mailView = [[MFMailComposeViewController alloc] init];
    mailView.delegate = self;
    
    [mailView setToRecipients:[NSArray arrayWithObject:@"aherreric@gmail.com"]];
    [mailView addAttachmentData:UIImagePNGRepresentation(viewImage) mimeType:@"image/png" fileName:@"CameraImage"];
    
    [self presentModalViewController:mailView animated:TRUE];
    
    
}
     
#pragma mark MFMailCompose Delegate
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error description] delegate:nil cancelButtonTitle:@"Accept" otherButtonTitles:nil];
        [alert show];
    }
    
    [self dismissModalViewControllerAnimated:TRUE];
}
     
     
#pragma mark UIImagePickerViewDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [_libraryPopoverController dismissPopoverAnimated:TRUE];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    [self dismissViewControllerAnimated:TRUE completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        IDALogoImage *anImage = [[IDALogoImage alloc] initWithFrame:CGRectMake(arc4random()%580, arc4random()%400, 20, 20)];
        
        [anImage setImage:image];
        
        [_imgContentSpace addSubview:anImage];
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

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    //return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
    return YES;
}

@end
