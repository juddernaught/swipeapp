//
//  ViewController.m
//  SwipeApp
//
//  Created by Daniel Judd on 3/11/15.
//  Copyright (c) 2015 swipe. All rights reserved.
//

#import "ViewController.h"
#import "RedditDownloaderService.h"
#import <pop/POP.h>

@interface ViewController () {
    int nextBackgroundImageIndex;
    NSArray *imageUrls;
    UIImageView *backgroundView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

//    RedditDownloaderService *redditDownloaderService = [[RedditDownloaderService alloc] init];
    
    imageUrls = [RedditDownloaderService downloadMessagesFromReddit];
    NSLog(imageUrls.description);
    // PUT THIS IN NEW THREAD?
    NSString *urlString = [imageUrls objectAtIndex:0];
    
    UIImageView *imageView = [self urlToImageView:urlString];
 

    imageView.frame = self.view.frame;
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    imageView.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pgr = [[UIPanGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(handlePan:)];
    
    [imageView addGestureRecognizer:pgr];
    nextBackgroundImageIndex = 1;

    [self addBackgroundView];
    [self.view addSubview:imageView];
    nextBackgroundImageIndex = 2;
    
    

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self.view];

    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        CGPoint velocity = [recognizer velocityInView:self.view];
        NSLog(@"%f, %f", velocity.x, velocity.y);
        NSLog(@"center: %f width: %f translation: %f", recognizer.view.center.x, self.view.frame.size.width, translation.x);
        // user has swiped off the screen
        if (recognizer.view.center.x < 20 || recognizer.view.center.x > 350) {
            if (recognizer.view.center.x < 20) {
                POPDecayAnimation *anim = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];

                anim.velocity = @(velocity.x*2);
                [recognizer.view.layer pop_addAnimation:anim forKey:@"slide"];
            }
            else {
           
                POPDecayAnimation *anim = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
                anim.velocity = @(velocity.x*2);
                [recognizer.view.layer pop_addAnimation:anim forKey:@"slide"];
            }
            
            NSLog(@"panned halfway");

            [self addGestureForNewView:backgroundView];
            [self addBackgroundView];
        }
        
        else {
            recognizer.view.center = self.view.center;
            [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
        }
    }
    
    NSLog(@"CHANGE center: %f width: %f translation: %f", recognizer.view.center.x, self.view.frame.size.width, translation.x);

    
    
    
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


- (void) addGestureForNewView: (UIView*) view {
    UIPanGestureRecognizer *pgr = [[UIPanGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(handlePan:)];
    
    [view addGestureRecognizer:pgr];
    view.userInteractionEnabled = YES;
    
}
             
 - (void) addBackgroundView {
     NSString *urlString = [imageUrls objectAtIndex:nextBackgroundImageIndex];
     
     backgroundView = [self urlToImageView:urlString];
     nextBackgroundImageIndex ++;
     
     backgroundView.frame = self.view.frame;
     backgroundView.contentMode = UIViewContentModeScaleToFill;
     
     backgroundView.userInteractionEnabled = NO;
     [self.view insertSubview:backgroundView atIndex:1];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
