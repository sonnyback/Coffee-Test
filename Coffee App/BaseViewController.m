//
//  BaseViewController.m
//  Coffee App
//
//  Created by Sonny Back on 3/14/14.
//  Copyright (c) 2014 Sonny Back. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController()
@property (weak, nonatomic) IBOutlet UIView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"BaseViewController.viewDidLoad!");
    
    [self createImageViewer];
}

/**
 * Method to create the UIImageView to contain the images to display
 *
 * @return void
 */
- (void)createImageViewer {
    
    NSLog(@"Entered createImageViewer");
    // size attributes of the main view and scroll view
    CGFloat imageViewHeight = self.imageView.frame.size.height; // height of the main view
    CGFloat imageViewWidth = self.imageView.frame.size.width; // width of the the main view
    CGFloat scrollViewHeight = self.scrollView.frame.size.height; // height of the scroll view
    CGFloat scrollViewWidth = self.scrollView.frame.size.width; // width of the scroll view
    
    // location of the scroll view
    CGFloat scrollViewLocationX = self.scrollView.frame.origin.x;
    CGFloat scrollViewLocationY = self.scrollView.frame.origin.y;
    
    NSLog(@"imageView width: %f, imageView height: %f", imageViewWidth, imageViewHeight);
    NSLog(@"scrollView width: %f, scrollView height: %f", scrollViewWidth, scrollViewHeight);
    
    // create the image view and set its location equal to the scroll view
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(scrollViewLocationX, scrollViewLocationY, scrollViewWidth, scrollViewHeight)];
    NSLog(@"imgView width: %f, imgView height: %f", imgView.bounds.size.width, imgView.bounds.size.height);
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    //imgView.backgroundColor = [UIColor blackColor]; // just for testing
    UIImage *testImage = [UIImage imageNamed:[NSString stringWithFormat:@"creamy_frozen_coffee"]]; // hard coded for testing only
    imgView.image = testImage;
    
    [self.imageView addSubview:imgView]; // add the image view to the main view (imageView)
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
