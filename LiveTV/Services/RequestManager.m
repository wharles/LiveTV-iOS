//
//  RequestManager.m
//  ZhihuDaily
//
//  Created by Koudai on 15/12/3.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import "RequestManager.h"
#import "HttpClient.h"
#import "TSMessage.h"

@interface RequestManager ()

@property (strong, nonatomic, readwrite) NSArray *videoArray;
@property (strong, nonatomic, readwrite) NSArray *seriesArray;
@property (strong, nonatomic, readwrite) NSArray *varietyArray;
@property (strong, nonatomic, readwrite) NSArray *searchResult;

@property (strong, nonatomic, readwrite) NSArray *videoDetail;

@property (strong, nonatomic, readwrite) NSNumber *requestMap;
@property (strong, nonatomic) NSArray *parameter;

@property (strong, nonatomic )HttpClient *client;

@end

@implementation RequestManager {
    Reachability *hostReach;
}

/**
 单利模式用于管理数据请求
 **/
+ (instancetype)sharedManager {
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

/**
 初始化
 **/
- (id)init {
    if (self = [super init]) {
        _client = [[HttpClient alloc] init];
        [[[[RACObserve(self, requestMap) ignore:nil] flattenMap:^RACStream *(NSNumber *type) {
            switch ((RequestType)type.integerValue) {
                case RequestTypeVideo:
                    return [self updateVideoList];
                    break;
                case RequestTypeDetail:
                    return [self updateVideoDetail];
                    break;
                case RequestTypeSearch:
                    return [self getSearchResult];
                    break;
                default:
                    return nil;
                    break;
            }
        }] deliverOn:RACScheduler.mainThreadScheduler] subscribeError:^(NSError *error) {
            [TSMessage showNotificationWithTitle:@"错误" subtitle:@"请求出错！" type:TSMessageNotificationTypeError];
        }];
    }
    return self;
}

/**
 检查网络连接
 **/
- (void)startRequestWithRequestId:(RequestType)requestType {
    Reachability* reach = [Reachability reachabilityWithHostname:@"cn.bing.com"];
    reach.reachableOnWWAN = NO;
    NSParameterAssert([reach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [reach currentReachabilityStatus];
    if (status != NotReachable) {
        self.requestMap = @(requestType);
    }
}

/**
 检查网络连接带请求参数
 **/
- (void)startRequestWithRequestId:(RequestType)requestType parameter:(NSArray *)parameter {
    self.parameter = parameter;
    [self startRequestWithRequestId:requestType];
}

- (RACSignal *)updateVideoList {
    //防止参数没有传递
    if (self.parameter.count == 2) {
        NSInteger channelId = [self.parameter[0] integerValue];
        NSInteger pageIndex = [self.parameter[1] integerValue];
        return [[self.client fetchMediaListFromChannelId:channelId pageIndex:pageIndex] doNext:^(NSArray *videos) {
            if (channelId == 1) {
                self.videoArray = videos;
            } else if (channelId == 2) {
                self.seriesArray = videos;
            } else {
                self.varietyArray = videos;
            }
        }];
    } else {
        return nil;
    }
}

- (RACSignal *)updateVideoDetail {
    if (self.parameter.count > 0) {
        NSInteger aid = [self.parameter[0] integerValue];
        return [[self.client fetchMediaFromAId:aid] doNext:^(NSArray *detail) {
            self.videoDetail = detail;
        }];
    } else {
        return nil;
    }
}

- (RACSignal *)getSearchResult {
    //防止参数没有传递
    if (self.parameter.count == 2) {
        NSString *key = self.parameter[0];
        NSInteger pageIndex = [self.parameter[1] integerValue];
        return [[self.client fetchMediaListFromKey:key pageIndex:pageIndex] doNext:^(NSArray *searchResult) {
            self.searchResult = searchResult;
        }];
    } else {
        return nil;
    }
}

@end
