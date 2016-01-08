//
//  FilmViewController.m
//  LiveTV
//
//  Created by Charlies Wang on 15/12/19.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import "FilmViewController.h"
#import "RequestManager.h"
#import "Video.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface FilmViewController ()

@end

@implementation FilmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //监听并请求数据
    RACSignal *signal = [RACObserve([RequestManager sharedManager], videoArray) ignore:nil];
    [self registerRequestWithSignal:signal requestId:RequestTypeVideo channelId:1];
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
