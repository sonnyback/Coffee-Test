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
    UIColor *barColor = [UIColor colorWithRed:0.5 green:0.6 blue:0.8 alpha:1.0];
    self.navigationController.navigationBar.barTintColor = barColor;
    
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
    NSLog(@"imgView width: %f, imgView height: %f", imgView.bounds.size.width, imgView.bounds.size.height);
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    //imgView.backgroundColor = [UIColor blackColor]; // just for testing
    //UIImage *testImage = [UIImage imageNamed:[NSString stringWithFormat:@"creamy_frozen_coffee"]]; // hard coded for testing only
    //imgView.image = testImage; // set the image in the view
    
    self.arrayOfImages = [self loadImages];
    imgView.animationImages = self.arrayOfImages;
    imgView.animationDuration = 5.0;
    
    [self.mainView addSubview:imgView]; // add the image view to the main view (imageView)
    [imgView startAnimating];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
