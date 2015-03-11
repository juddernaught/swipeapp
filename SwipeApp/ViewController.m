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
    
    NSArray *imageUrls = [RedditDownloaderService downloadMessagesFromReddit];
    NSLog(imageUrls.description);
    // PUT THIS IN NEW THREAD?
    NSString *urlString = [imageUrls objectAtIndex:0];
    
    UIImageView *imageView = [self urlToImageView:urlString];
    NSString *urlString2 = [imageUrls objectAtIndex:1];

    UIImageView *backgroundImageView = [self urlToImageView:urlString2];

    imageView.frame = self.view.frame;
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    imageView.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pgr = [[UIPanGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(handlePan:)];
    
    [imageView addGestureRecognizer:pgr];
    [self.view addSubview:backgroundImageView];
    [self.view addSubview:imageView];
    
    

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self.view];

    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
//        NSLog(@"center: %f width: %f translation: %f", recognizer.view.center.x, self.view.frame.size.width, translation.x);
        if (recognizer.view.center.x < 20) {
            NSLog(@"panned halfway");
            recognizer.view.center = self.view.center;
            [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
        }
        else {
            recognizer.view.center = self.view.center;
            [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
        }
        NSLog(@"finished panning");
        //All fingers are lifted.
    }
    
    
    
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
}

- (UIImageView*) urlToImageView: (NSString*)urlString {
    if (!([urlString containsString:@".jpg"] || [urlString containsString:@".png"])){
        urlString = [urlString stringByAppendingString:@".jpg"];
    }
    NSURL *url = [NSURL URLWithString:urlString];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    return imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
