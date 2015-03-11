//
//  ViewController.m
//  SwipeApp
//
//  Created by Daniel Judd on 3/11/15.
//  Copyright (c) 2015 swipe. All rights reserved.
//

#import "ViewController.h"
#import "RedditDownloaderService.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    RedditDownloaderService *redditDownloaderService = [[RedditDownloaderService alloc] init];
    
    NSArray *images = [RedditDownloaderService downloadMessagesFromReddit];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
