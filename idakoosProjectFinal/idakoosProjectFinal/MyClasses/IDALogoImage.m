//
//  IDALogoImage.m
//  IdakoosProject
//
//  Created by NSS MAC2 on 12/13/12.
//  Copyright (c) 2012 Idakoos. All rights reserved.
//

#import "IDALogoImage.h"

@implementation IDALogoImage

- (id)initWithFrame:(CGRect)frame withContenSpace:(UIImageView *)imgSpace
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        imgContentSpace = imgSpace;
        
        UIRotationGestureRecognizer *rotateGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotate:)];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
        
        [self addGestureRecognizer:rotateGesture];
        [self addGestureRecognizer:panGesture];
        [self addGestureRecognizer:pinchGesture];
        
        [self setUserInteractionEnabled:TRUE];
    }
    return self;
}

#pragma mark UIGestures Method

- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer {
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
}

- (void)handleRotate:(UIRotationGestureRecognizer *)recognizer {
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:imgContentSpace];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:imgContentSpace];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end