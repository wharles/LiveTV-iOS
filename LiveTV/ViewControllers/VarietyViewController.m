//
//  VarietyViewController.m
//  LiveTV
//
//  Created by Charlies Wang on 15/12/20.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import "VarietyViewController.h"
#import "RequestManager.h"

@implementation VarietyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //监听并请求数据
    RACSignal *signal = [RACObserve([RequestManager sharedManager], varietyArray) ignore:nil];
    [self registerRequestWithSignal:signal requestId:RequestTypeVideo channelId:7];
}

@end
