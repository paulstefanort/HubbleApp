//
//  PhotoView.m
//  HubbleApp
//
//  Created by Paul Stefan Ort on 4/29/13.
//  Copyright (c) 2013 Paul Stefan Ort. All rights reserved.
//

#import "PhotoView.h"
#import <QuartzCore/QuartzCore.h>

@implementation PhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"PhotoView" owner:self options:nil];
        [self addSubview:self.view];
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

- (UIImage *)imageByRenderingView {
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

@end
