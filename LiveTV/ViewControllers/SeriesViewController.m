//
//  SeriesViewController.m
//  LiveTV
//
//  Created by Charlies Wang on 15/12/20.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import "SeriesViewController.h"
#import "RequestManager.h"

@implementation SeriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //监听并请求数据
    RACSignal *signal = [RACObserve([RequestManager sharedManager], seriesArray) ignore:nil];
    [self registerRequestWithSignal:signal requestId:RequestTypeVideo channelId:2];
}

@end
