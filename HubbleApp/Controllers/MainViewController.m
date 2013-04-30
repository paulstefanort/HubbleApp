//
//  MainViewController.m
//  HubbleApp
//
//  Created by Paul Stefan Ort on 4/11/13.
//  Copyright (c) 2013 Paul Stefan Ort. All rights reserved.
//

#import "MainViewController.h"
#import "PhotoView.h"
#include <stdlib.h>

@interface MainViewController () {
    NSArray *imageUrls;
    NSMutableDictionary *images;
    UIImage *currentImage;
}
@end

@implementation MainViewController

@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        imageUrls = @[
            @"http://imgsrc.hubblesite.org/hu/db/images/hs-2013-17-a-web.jpg",
            @"http://imgsrc.hubblesite.org/hu/db/images/hs-2013-06-a-web.jpg",
            @"http://imgsrc.hubblesite.org/hu/db/images/hs-2012-49-a-web.jpg",
            @"http://imgsrc.hubblesite.org/hu/db/images/hs-2012-45-a-web.jpg",
            @"http://imgsrc.hubblesite.org/hu/db/images/hs-2012-24-a-web.jpg",
            @"http://imgsrc.hubblesite.org/hu/db/images/hs-2012-37-a-web.jpg",
            @"http://imgsrc.hubblesite.org/hu/db/images/hs-2012-38-a-web.jpg",
            @"http://imgsrc.hubblesite.org/hu/db/images/hs-2012-30-a-web.jpg",
            @"http://imgsrc.hubblesite.org/hu/db/images/hs-2012-29-a-web.jpg"
        ];
        images = [NSMutableDictionary new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (int i = 0; i < imageUrls.count; i++) {
        NSString *imageUrl = [imageUrls objectAtIndex:i];
        __block UIImage *image;
        __block NSMutableDictionary *imageDictionary = images;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
            [imageDictionary setObject:image forKey:[NSNumber numberWithInt:i]];
            if (i == 0) {
                currentImage = image;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                PhotoView *photoView = [[PhotoView alloc] initWithFrame:CGRectMake(240 * i, 0, 240, 444)];
                photoView.imageView.image = image;
                photoView.imageLabel.text = imageUrl;
                photoView.clipsToBounds = true;
                
                /*
                UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                [imageView setContentMode:UIViewContentModeScaleAspectFill];
                [imageView setClipsToBounds:true];
                CGRect imageViewFrame = CGRectMake(240 * i, 0, 240, 444);
                [imageView setFrame:imageViewFrame];
                 */
                
                [scrollView addSubview:photoView];
                
                [self.view addConstraint:[NSLayoutConstraint constraintWithItem:photoView
                                                                       attribute:NSLayoutAttributeHeight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:scrollView
                                                                       attribute:NSLayoutAttributeHeight
                                                                      multiplier:1
                                                                        constant:0]];
            });
        });
    }
    [scrollView setContentSize:CGSizeMake(imageUrls.count * 240, 0)];
    [scrollView setPagingEnabled:true];
    [scrollView setClipsToBounds:false];
    [scrollView setShowsHorizontalScrollIndicator:false];
}

- (IBAction)printImage:(id)sender {
    if (currentImage) {
        UIPrintInteractionController *printController = [UIPrintInteractionController sharedPrintController];
        printController.printingItem = currentImage;
        UIPrintInfo *printInfo = [UIPrintInfo printInfo];
        printInfo.outputType = UIPrintInfoOutputPhoto;
        printInfo.jobName = @"Hubble Photo";
        [printController presentAnimated:true completionHandler:nil];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Print Image" message:@"Please load an image first." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int currentImageIndex = scrollView.contentOffset.x / 240;
    currentImage = [images objectForKey:[NSNumber numberWithInt:currentImageIndex]];
}

@end
