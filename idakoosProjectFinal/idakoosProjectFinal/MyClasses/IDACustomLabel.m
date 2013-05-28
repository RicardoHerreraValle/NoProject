//
//  IDACustomLabel.m
//  idakoosProjectFinal
//
//  Created by Ricardo Herrera Valle on 15/01/13.
//  Copyright (c) 2013 Idakoos. All rights reserved.
//

#import "IDACustomLabel.h"

@implementation IDACustomLabel

@synthesize imgContentSpace;
@synthesize _textSize;

- (id)initWithFrame:(CGRect)frame// withContenSpace:(UIView *)imgSpace
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //imgContentSpace = imgSpace;
        
        UIRotationGestureRecognizer *rotateGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotate:)];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
        
        _textSize = 16.0f;
        self._NumLines = 1;
        self._PosColor = 1; // default color Black
        
        [self addGestureRecognizer:rotateGesture];
        [self addGestureRecognizer:panGesture];
        [self addGestureRecognizer:pinchGesture];
        
        [self setUserInteractionEnabled:TRUE];
    }
    return self;
}

#pragma mark touche Methods handling
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"touchLabel_iPad" object:self];
}


#pragma mark UIGestures Method

- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer {
    
    CGSize currentSize = self.frame.size;
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
    
    if (self.frame.size.height > imgContentSpace.frame.size.height ||
        self.frame.size.width > imgContentSpace.frame.size.width) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, currentSize.width, currentSize.height);
    }
}

- (void)handleRotate:(UIRotationGestureRecognizer *)recognizer {
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;//
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        //All fingers are lifted.
        if (self.frame.origin.y + self.frame.size.height > imgContentSpace.frame.size.height) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"removeCustomLabel_iPad" object:self];
        }
    }
    
    CGPoint translation = [recognizer translationInView:imgContentSpace];
    
    CGPoint temp = recognizer.view.center;
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:imgContentSpace];
    
    if ((self.frame.origin.x + self.frame.size.width > imgContentSpace.frame.size.width) ||
        self.frame.origin.x < 0 || self.frame.origin.y < 0) {
        self.center = temp;
    }
}

#pragma mark Setting Characters
-(void)resizeToStretch{
    float width = [self expectedWidth];
    CGRect newFrame = [self frame];
    newFrame.size.width = width;
    [self setFrame:newFrame];
}

-(float)expectedWidth{
    [self setNumberOfLines:1];
    
    CGSize maximumLabelSize = CGSizeMake(9999,self.frame.size.height);
    
    CGSize expectedLabelSize = [[self text] sizeWithFont:[self font]
                                       constrainedToSize:maximumLabelSize
                                           lineBreakMode:[self lineBreakMode]];
    return expectedLabelSize.width;
}
- (void)adjustHeight {
    
    if (self.text == nil) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, 0);
        return;
    }
    
    CGSize aSize = self.bounds.size;
    CGSize tmpSize = CGRectInfinite.size;
    tmpSize.width = aSize.width;
    
    tmpSize = [self.text sizeWithFont:self.font constrainedToSize:tmpSize];
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, aSize.width, tmpSize.height);
}

- (void)modifyTextSize:(float)factor{
    
    _textSize += factor;
    if (_textSize < 0) {
        _textSize = 0;
    }
    self.font = [self.font fontWithSize:_textSize];
    [self setNumberOfLines:__NumLines];
    [self resizeToStretch];
    [self adjustHeight];
}

- (void)modifyTextColor{
    
    [self setTextColor:[UIColor colorWithRed:__Red/255.0f green:__Green/255.0f blue:__Blue/255.0f alpha:1.0f]];
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
