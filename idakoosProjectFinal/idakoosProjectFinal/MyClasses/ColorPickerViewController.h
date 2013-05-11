//
//  ColorPickerViewController.h
//  idakoosProjectFinal
//
//  Created by Ricardo Herrera Valle on 10/05/13.
//  Copyright (c) 2013 Idakoos. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorPickerDelegate <NSObject>
@required
-(void)selectedColor:(int)posColor;
@end

@interface ColorPickerViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *colorNames;
@property (nonatomic, weak) id<ColorPickerDelegate> delegate;
@end