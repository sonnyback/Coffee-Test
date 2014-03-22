//
//  BaseViewController.m
//  Coffee App
//
//  Created by Sonny Back on 3/14/14.
//  Copyright (c) 2014 Sonny Back. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController()
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (strong, nonatomic) NSMutableArray *arrayOfImages; // just for testing - will move to model later
@property (nonatomic) NSInteger index; // index for tracking the array images
@end

@implementation BaseViewController

// getter with lazy instantiation
- (NSMutableArray *)arrayOfImages {
    
    if (!_arrayOfImages) {
        _arrayOfImages = [[NSMutableArray alloc] init];
    }
    
    return _arrayOfImages;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"BaseViewController.viewDidLoad!");
    /** TODO: Put nav bar attributes in a NSDictionary **/
    //self.navigationBar.title = @"Search box goes here";
    self.scrollView.alwaysBounceHorizontal = YES;
    [self.scrollView setScrollEnabled:YES];
    UIColor *barColor = [UIColor colorWithRed:0.5 green:0.6 blue:0.8 alpha:1.0];
    self.navigationController.navigationBar.barTintColor = barColor;
    self.index = 0; // set the index to 0
    
    [self createImageViewer];
}

/**
 * Method to recognize and handle tap gesture for image
 *
 * @param UITapGestureRecognizer*
 * @return void
 */
- (void)touchImage:(UITapGestureRecognizer *)gesture
{
    NSLog(@"Entered touchImage!");
    if (gesture.state == UIGestureRecognizerStateEnded) {
        //[self updateUI];
        NSLog(@"Image touch recognized!");
    }
}

/**
 * Method to animate rendered images. This is just for testing and will go away
 * after implementing swipe gesture
 *
 * @param UIImageView *imgView
 * @return void
 */
- (void)animateImages:(UIImageView *)imgView {
    
    NSLog(@"Entered animateImages");
    self.arrayOfImages = [self loadImages]; // load the images to render
    imgView.animationImages = self.arrayOfImages;
    imgView.animationDuration = 6.0;
    [imgView startAnimating];
}


- (void)displayInitialImage:(UIImageView *)imgView {
    
    NSLog(@"Entered displayImage");
    self.arrayOfImages = [self loadImages];
    //imgView.image = [self.arrayOfImages firstObject]; // displays first object in the array for initial rendering
    imgView.image = [self.arrayOfImages firstObject];
}

/**
 * Method to create the UIImageView to contain the images to display
 *
 * @return void
 */
- (void)createImageViewer {
    
    NSLog(@"Entered createImageViewer");
    // size attributes of the main view and scroll view
    CGFloat mainViewHeight = self.mainView.frame.size.height; // height of the main view
    CGFloat mainViewWidth = self.mainView.frame.size.width; // width of the the main view
    CGFloat scrollViewHeight = self.scrollView.frame.size.height; // height of the scroll view
    CGFloat scrollViewWidth = self.scrollView.frame.size.width; // width of the scroll view
    
    // location of the scroll view
    CGFloat scrollViewLocationX = self.scrollView.frame.origin.x;
    CGFloat scrollViewLocationY = self.scrollView.frame.origin.y;
    
    NSLog(@"imageView width: %f, imageView height: %f", mainViewWidth, mainViewHeight);
    NSLog(@"scrollView width: %f, scrollView height: %f", scrollViewWidth, scrollViewHeight);
    
    // create the image view and set its location equal to the scroll view
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(scrollViewLocationX, scrollViewLocationY, scrollViewWidth, scrollViewHeight)];
    [imgView setUserInteractionEnabled:YES]; // let the user interact with the view
    NSLog(@"imgView width: %f, imgView height: %f", imgView.bounds.size.width, imgView.bounds.size.height);
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES; // neccessary to keep images from spilling past the bounds
    self.scrollView.contentSize = imgView.frame.size;
    
    /** HARD CODED JUST FOR TESTING PURPOSES
    //imgView.backgroundColor = [UIColor blackColor]; // just for testing
    //UIImage *testImage = [UIImage imageNamed:[NSString stringWithFormat:@"creamy_frozen_coffee"]]; // hard coded for testing only
    //imgView.image = testImage; // set the image in the view
    **/
    // set up left swipe - foward swipe gesture
    /*UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeImage:)];
    [swipeLeft setNumberOfTouchesRequired:1];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [imgView addGestureRecognizer:swipeLeft]; // add gesture to the view
    
    // set up right swipe - backwards swipe gesture
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeImage:)];
    [swipeRight setNumberOfTouchesRequired:1];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [imgView addGestureRecognizer:swipeRight]; // add gesture to the view*/
    
    
    //[self.mainView addSubview:imgView]; // add the image view to the main view (imageView)
    [self.mainView addSubview:self.scrollView];
    [self.scrollView addSubview:imgView];

    //[self animateImages:imgView]; // call method to animate the images - just for testing
    [self displayInitialImage:imgView];
}

- (NSMutableArray *)loadImages {
    
    NSLog(@"Entered loadImages!");
    NSMutableArray *arrayOfUIImages = [[NSMutableArray alloc] init];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *directoryFilePath = @"/Users/Sonny/Desktop/images/";
    BOOL success = [fileManager fileExistsAtPath:directoryFilePath];
    
    if (success) {
        NSLog(@"Directory exists!");
        NSArray *imageNamesFromDirectory = [fileManager contentsOfDirectoryAtPath:directoryFilePath error:nil];
        NSString *searchString = @".png";
    
        for (int i = 0; i < [imageNamesFromDirectory count]; i++) {
            //NSLog(@"contents from directory %@", imageNamesFromDirectory[i]);
            // file name creation requires full path to create the UIImage based off the file name
            NSString *nameOfImageFromFile = [directoryFilePath stringByAppendingString:[imageNamesFromDirectory[i] description]];
            NSLog(@"file name:%@", nameOfImageFromFile);
            NSRange range = [nameOfImageFromFile rangeOfString:searchString];
            if (range.location != NSNotFound) {
                NSLog(@"found search string!");
                //UIImage *image = [UIImage imageNamed:nameOfImageFromFile];
                UIImage *image = [UIImage imageWithContentsOfFile:nameOfImageFromFile];
                NSLog(@"image is %@", [image description]);
                [arrayOfUIImages addObject:image];
                NSLog(@"%@ added to array", nameOfImageFromFile);
            }
        }
    }
    
    //NSLog(@"arrayOfImages size: %d", [self.arrayOfImages count]);
    
    return arrayOfUIImages;
}

- (void)loadNextImage:(NSUInteger)index forView:(UIImageView *)imgView {
    
    NSLog(@"Entered LoadNextImage! index: %d view: %@", index, imgView);
}

- (IBAction)swipeImage:(UISwipeGestureRecognizer *)swipe {
    
    //NSLog(@"Entered swipeImage!");
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        NSLog(@"Left/forward swipe!");
        self.index++; // increment the index
        NSLog(@"index: %d", self.index);
        //[self loadNextImage:self.index forView:];
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        
        NSLog(@"Right/backwards swipe!");
        self.index--; // decremement the index
         NSLog(@"index: %d", self.index);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
