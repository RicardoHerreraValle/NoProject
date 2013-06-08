//
//  FontsPickerViewController.h
//  idakoosProjectFinal
//
//  Created by Ricardo Herrera Valle on 5/06/13.
//  Copyright (c) 2013 Idakoos. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FontsPickerDelegate <NSObject>
@required
-(void)SelectedFont:(NSString *)theFont;
@end

@interface FontsPickerViewController : UITableViewController{
    
}

@property (nonatomic, strong) NSMutableArray *arrayFonts;
@property(nonatomic, weak) id<FontsPickerDelegate> delegate;

@end
