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
    NSLog(@"BaseViewController.viewDidLoad...");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
