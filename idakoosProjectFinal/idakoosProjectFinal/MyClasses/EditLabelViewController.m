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
        if (!lblTexto) {
            NSDictionary *color = [arrayTextColor objectAtIndex:0];
            lblTexto = [[IDACustomLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
            
            [lblTexto setText:@""];
            [lblTexto set_Red:[[color objectForKey:@"Red"] floatValue]];
            [lblTexto set_Green:[[color objectForKey:@"Green"] floatValue]];
            [lblTexto set_Red:[[color objectForKey:@"Blue"] floatValue]];
            [lblTexto setTextColor:[UIColor colorWithRed:[[color objectForKey:@"Red"] floatValue]/255
                                                    green:[[color objectForKey:@"Green"] floatValue]/255
                                                     blue:[[color objectForKey:@"Blue"] floatValue]/255
                                                    alpha:1.0]];
            [lblTexto setBackgroundColor:[UIColor clearColor]];
            [lblTexto setNumberOfLines:2];
            [lblTexto setTextAlignment:NSTextAlignmentCenter];
            [lblTexto setFont:[UIFont fontWithName:@"System" size:17.0f]];
            [lblTexto setUserInteractionEnabled:TRUE];
            [lblTexto sizeToFit];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //obtener colores y tallas del plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DetailsProduct" ofType:@"plist"];
    NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:path];
    arrayTextColor = [[NSArray alloc] initWithArray:[root objectForKey:@"TextColor"]];
    
    [self putTextColors];
    
    _txtTexto.text = lblTexto.text;
    _txtTexto.font = [UIFont fontWithName:@"System" size:lblTexto._textSize];
}

#pragma mark customize text

- (IBAction)onTapModifyTextSize:(id)sender {
    
    float constant = 0.5;
    
    switch ([sender tag]) {
        case 0:
            constant *= -1;
            if (lblTexto._textSize + constant <= 5) {
                return;
            }
            break;
            
        default:
            
            if (lblTexto._textSize + constant > 30) {
                return;
            }
            break;
    }
    
    
    
    [lblTexto set_textSize:lblTexto._textSize + constant];

    self.lblSize.text = [NSString stringWithFormat:@"%.2f", lblTexto._textSize];
    
}

- (void)onTapTextColor:(id)Sender{
    NSDictionary *color = [arrayTextColor objectAtIndex:[Sender tag]];
    [lblTexto set_Red:[[color objectForKey:@"Red"] floatValue]];
    [lblTexto set_Green:[[color objectForKey:@"Green"] floatValue]];
    [lblTexto set_Blue:[[color objectForKey:@"Blue"] floatValue]];
    [_txtTexto setTextColor:[UIColor colorWithRed:[[color objectForKey:@"Red"] floatValue]/255
                                           green:[[color objectForKey:@"Green"] floatValue]/255
                                            blue:[[color objectForKey:@"Blue"] floatValue]/255
                                           alpha:1.0]];
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

#pragma mark View Actions

- (IBAction)onTapCancel:(id)sender {
    [self dismissModalViewControllerAnimated:TRUE];
}

- (IBAction)onTapSave:(id)sender {
    
    //send Label modified
    lblTexto.text = _txtTexto.text;
    [lblTexto modifyTextColor];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReceiveCustomLabel_iPad" object:lblTexto];
    [self onTapCancel:NULL];
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
    [super viewDidUnload];
}
@end
