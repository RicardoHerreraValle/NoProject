//
//  IDALogoImage.h
//  IdakoosProject
//
//  Created by NSS MAC2 on 12/13/12.
//  Copyright (c) 2012 Idakoos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDALogoImage : UIImageView{
    
    UIView *imgContentSpace;
}

- (id)initWithFrame:(CGRect)frame withContenSpace:(UIView *)imgSpace;

//gestures
- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer;
- (void)handleRotate:(UIRotationGestureRecognizer *)recognizer;
- (void)handlePan:(UIPanGestureRecognizer *)recognizer;

@end
