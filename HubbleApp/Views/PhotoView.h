//
//  PhotoView.h
//  HubbleApp
//
//  Created by Paul Stefan Ort on 4/29/13.
//  Copyright (c) 2013 Paul Stefan Ort. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoView : UIView

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *imageLabel;
- (UIImage *)imageByRenderingView;

@end
