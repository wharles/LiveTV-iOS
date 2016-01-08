//
//  TVPlayerViewController.m
//  LiveTV
//
//  Created by Koudai on 15/12/17.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import "TVPlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface TVPlayerViewController ()

@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;

@end

@implementation TVPlayerViewController {
    UIActivityIndicatorView *loadingAni;    //加载动画
    UILabel *label;                            //加载提醒
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.name;
    
    loadingAni = [[UIActivityIndicatorView alloc] init];
    loadingAni.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.view addSubview:loadingAni];
    
    label = [[UILabel alloc] init];
    label.text = @"Loading...";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:15.0];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [loadingAni startAnimating];
    [self.view addSubview:label];
    
    self.moviePlayer =  [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.url]];
    if ([self.moviePlayer respondsToSelector:@selector(loadState)]) {
        // Set movie player layout
        [self.moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
        //满屏
        [self.moviePlayer setFullscreen:YES];
        // 有助于减少延迟
        [self.moviePlayer prepareToPlay];
        // Register that the load state changed (movie is ready)
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerLoadStateChanged:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    } else {
        [self.moviePlayer play];
    }
    
    // Register to receive a notification when the movie has finished playing.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:)   name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
}

- (void)viewWillLayoutSubviews {
    self.moviePlayer.view.frame = self.view.bounds;
    loadingAni.frame = CGRectMake(self.view.bounds.size.width / 2 - 15, self.view.bounds.size.height / 2 - 15, 30, 30);
    label.frame = CGRectMake(self.view.bounds.size.width / 2 - 40, loadingAni.frame.origin.y + 35, 80, 20);
}

- (void) moviePlayerLoadStateChanged:(NSNotification*)notification
{
    [loadingAni stopAnimating];
    [label removeFromSuperview];
    
    // Unless state is unknown, start playback
    if ([self.moviePlayer loadState] != MPMovieLoadStateUnknown)
    {
        // Remove observer
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification  object:nil];
        [[self view] addSubview:[self.moviePlayer view]];
        [self.moviePlayer play];
    }
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    //还原状态栏为默认状态
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    // Remove observer
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
