//
//  IDALogoImage.h
//  IdakoosProject
//
//  Created by NSS MAC2 on 12/13/12.
//  Copyright (c) 2012 Idakoos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDALogoImage : UIImageView{
    
    UIImageView *imgContentSpace;
}

- (id)initWithFrame:(CGRect)frame withContenSpace:(UIImageView *)imgSpace;

//gestures
- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer;
- (void)handleRotate:(UIRotationGestureRecognizer *)recognizer;
- (void)handlePan:(UIPanGestureRecognizer *)recognizer;

@end
