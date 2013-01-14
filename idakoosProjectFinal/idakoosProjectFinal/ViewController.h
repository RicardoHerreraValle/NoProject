//
//  ViewController.h
//  idakoosProjectFinal
//
//  Created by Ricardo Herrera Valle on 23/12/12.
//  Copyright (c) 2012 Idakoos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    
    NSArray *arrayOptions;
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollMenu;

- (void)putMenuButtons;
- (void)onSelectOption:(id)Sender;

@end
