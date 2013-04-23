//
//  MainViewController.m
//  HubbleApp
//
//  Created by Paul Stefan Ort on 4/11/13.
//  Copyright (c) 2013 Paul Stefan Ort. All rights reserved.
//

#import "MainViewController.h"
#include <stdlib.h>

@interface MainViewController ()
@property NSArray *imageUrls;
@property UIImage *currentImage;
@end

@implementation MainViewController

@synthesize imageUrls, currentImage, imageView, changeImageButton;

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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)changeImage:(id)sender {
    [changeImageButton setBackgroundColor:[UIColor grayColor]];
    int newImageIndex = arc4random() % imageUrls.count;
    NSString *imageUrl = [imageUrls objectAtIndex:newImageIndex];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        currentImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [imageView setImage:currentImage];
            [changeImageButton setBackgroundColor:nil];
        });
    });
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

@end
