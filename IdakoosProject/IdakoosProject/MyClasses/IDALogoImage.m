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
    }
    return self;
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
