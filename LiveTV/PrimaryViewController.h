//
//  BaseViewController.h
//  ZhihuDaily
//
//  Created by Koudai on 15/12/9.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

#import "BaseViewController.h"

@interface PrimaryViewController : BaseViewController

@property (strong,nonatomic, nullable) UIRefreshControl *refreshControl;

@property (copy, nonatomic, nullable) void(^refreshRequest)(_Nullable id x);

@property (copy, nonatomic, nullable) void(^loadMore)();

- (void)refreshComplete;

- (void)registerRequestWithSignal:(RACSignal * _Nonnull)signal requestId:(NSInteger)requestId channelId:(NSInteger) channelId;

@end
