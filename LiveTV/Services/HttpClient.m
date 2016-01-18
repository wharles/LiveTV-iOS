//
//  HttpClient.m
//  ZhihuDaily
//
//  Created by Koudai on 15/12/3.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import "HttpClient.h"
#import "Mantle.h"
#import "GlobalMacro.h"
#import "NSDate+Helper.h"
#import "Video.h"
#import "VideoDetail.h"
#import "SearchItem.h"

@interface HttpClient ()

@property (strong,nonatomic)NSURLSession *session;

@end

@implementation HttpClient

- (id)init {
    if (self = [super init]) {
        //设置NSURLSession
        NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}

/**
 通用URL请求获取json并通知
 **/

- (RACSignal *)fetchJSONFromURL:(NSURL *)url {
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                NSError* jsonError = nil;
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                if (!jsonError) {
                    [subscriber sendNext:json[@"data"]];
                } else {
                    [subscriber sendError:jsonError];
                }
            } else {
                [subscriber sendError:error];
            }
        }];
        [dataTask resume];
        //释放请求
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }] doNext:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(RACSignal *)fetchTempleteWithJsonRootName:(NSString *)rootName urlString:(NSString *)urlString modelOfClass:(Class)model {
    NSURL *url = [NSURL URLWithString:urlString];
    return [[self fetchJSONFromURL:url] map:^id(NSDictionary *json) {
        RACSequence *list = [json[rootName] rac_sequence];
        return [[list map:^id(NSDictionary *dict) {
            return [MTLJSONAdapter modelOfClass:model fromJSONDictionary:dict error:nil];
        }] array];
    }];
}

- (RACSignal *)fetchMediaListFromChannelId:(NSInteger)channelId pageIndex:(NSInteger)pageIndex {
    NSString *urlString = CHANNELAPI(20, pageIndex, channelId, [[NSDate date] toTimestamp]);
    return [self fetchTempleteWithJsonRootName:@"videos" urlString:urlString modelOfClass:[Video class]];
}

- (RACSignal *)fetchMediaFromAId:(NSInteger)aid {
    NSString *urlString = VIDEOAPI(aid, [[NSDate date] toTimestamp]);
    return [self fetchTempleteWithJsonRootName:@"videos" urlString:urlString modelOfClass:[VideoDetail class]];
}

- (RACSignal *)fetchMediaListFromKey:(NSString *)key pageIndex:(NSInteger)pageIndex {
    NSString *urlString = SEARCHAPI(key, pageIndex, 20);
    return [self fetchTempleteWithJsonRootName:@"items" urlString:urlString modelOfClass:[SearchItem class]];
}


@end
