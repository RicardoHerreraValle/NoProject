//
//  ViewController.m
//  idakoosProjectFinal
//
//  Created by Ricardo Herrera Valle on 23/12/12.
//  Copyright (c) 2012 Idakoos. All rights reserved.
//

#import "ViewController.h"
#import "CustomizeProductViewController.h"

@interface ViewController ()

@end

@implementation ViewController


#pragma mark onTapButton
- (void)onSelectOption:(id)Sender{
    
    NSDictionary *theOption = [arrayOptions objectAtIndex:[Sender tag]];
    
    if (![[theOption objectForKey:@"Active"] boolValue]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"IDakoos" message:@"This product will be avaible soon" delegate:nil cancelButtonTitle:@"Accept" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    [self performSegueWithIdentifier:@"CustomizeView" sender:Sender];
    
}

#pragma mark storyboardMethods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"CustomizeView"]) {
        CustomizeProductViewController *destinationView = segue.destinationViewController;
        destinationView.selectedProduct = [sender tag];
    }
    
}

#pragma mark initialization
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //
    [self putMenuButtons];
    
}

- (void)putMenuButtons{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MenuOptions" ofType:@"plist"];
    
    NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:path];
    
    arrayOptions = [[NSArray alloc] initWithArray:[root objectForKey:@"Options"]];
    
    for (int i=0; i<[arrayOptions count]/2; i++) {
        
        NSDictionary *anOption = [arrayOptions objectAtIndex:i];
        
        UIButton *btnOption = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btnOption setFrame:CGRectMake(77, 57*(i+1)+236*i, 230, 236)];
        
        [btnOption setImage:[UIImage imageNamed:[NSString stringWithFormat:@"custom_%@",[anOption objectForKey:@"Name"]]] forState:UIControlStateNormal];
        [btnOption setTag:i];
        
        [btnOption addTarget:self action:@selector(onSelectOption:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollMenu addSubview:btnOption];
        btnOption = nil;
        
    }
    int i = 0;
    for (int j=[arrayOptions count]/2; j<[arrayOptions count]; j++) {
        
        NSDictionary *anOption = [arrayOptions objectAtIndex:j];
        
        UIButton *btnOption = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btnOption setFrame:CGRectMake(461, 57*(i+1) +236*i, 230, 236)];
        
        [btnOption setImage:[UIImage imageNamed:[NSString stringWithFormat:@"custom_%@",[anOption objectForKey:@"Name"]]] forState:UIControlStateNormal];
        [btnOption setTag:j];
        
        [btnOption addTarget:self action:@selector(onSelectOption:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollMenu addSubview:btnOption];
        
        btnOption = nil;
        
        i++;
        
    }
    
    [self.scrollMenu setContentSize:CGSizeMake(768, 57*([arrayOptions count]/2 +1) +236*[arrayOptions count]/2)];
}

- (void)viewDidUnload
{
    [self setScrollMenu:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


#pragma mark orientation support
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
