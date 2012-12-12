//
//  IDAViewController.h
//  IdakoosProject
//
//  Created by NSS MAC2 on 12/12/12.
//  Copyright (c) 2012 Idakoos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDAViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgContentSpace;
@property (weak, nonatomic) IBOutlet UIImageView *imgClothPreview;

- (IBAction)onTapLoadImage:(id)sender;

@end
