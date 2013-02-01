//
//  IDACustomLabel.h
//  idakoosProjectFinal
//
//  Created by Ricardo Herrera Valle on 15/01/13.
//  Copyright (c) 2013 Idakoos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDACustomLabel : UILabel{
    
    UIView __unsafe_unretained *imgContentSpace;
}

//- (id)initWithFrame:(CGRect)frame withContenSpace:(UIView *)imgSpacee;

//gestures
- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer;
- (void)handleRotate:(UIRotationGestureRecognizer *)recognizer;
- (void)handlePan:(UIPanGestureRecognizer *)recognizer;

@property(nonatomic, assign) UIView *imgContentSpace;

@end
