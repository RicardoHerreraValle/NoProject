//
//  SizesPickerViewController.h
//  idakoosProjectFinal
//
//  Created by Ricardo Herrera Valle on 10/05/13.
//  Copyright (c) 2013 Idakoos. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SizesPickerDelegate <NSObject>
@required
-(void)selectedSize:(int)posColor;
@end

@interface SizesPickerViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *sizeNames;
@property (nonatomic, weak) id<SizesPickerDelegate> delegate;
@end
