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

- (void)resizeToStretch;
- (void)adjustHeight;
- (void)modifyTextSize:(float)factor;
- (void)modifyTextColor;

@property(nonatomic, assign) UIView *imgContentSpace;
@property(nonatomic) float _textSize;
@property(nonatomic) float _Red;
@property(nonatomic) float _Green;
@property(nonatomic) float _Blue;
@property(nonatomic) int _NumLines;
@property(nonatomic) int _PosColor;
@property(nonatomic) NSString *_font;

@end
