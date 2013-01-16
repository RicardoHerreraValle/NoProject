//
//  IDACustomLabel.h
//  idakoosProjectFinal
//
//  Created by Ricardo Herrera Valle on 15/01/13.
//  Copyright (c) 2013 Idakoos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDACustomLabel : UILabel{
    
    UIImageView *imgContentSpace;
}

- (id)initWithFrame:(CGRect)frame withContenSpace:(UIImageView *)imgSpace;

//gestures
- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer;
- (void)handleRotate:(UIRotationGestureRecognizer *)recognizer;
- (void)handlePan:(UIPanGestureRecognizer *)recognizer;

@end
