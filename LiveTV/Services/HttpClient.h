//
//  HttpClient.h
//  ZhihuDaily
//
//  Created by Koudai on 15/12/3.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface HttpClient : NSObject

- (RACSignal *)fetchJSONFromURL:(NSURL *)url;

- (RACSignal *)fetchMediaListFromChannelId:(NSInteger)channelId pageIndex:(NSInteger)pageIndex;
- (RACSignal *)fetchMediaFromAId:(NSInteger)aid;
- (RACSignal *)fetchMediaListFromKey:(NSString *)key pageIndex:(NSInteger)pageIndex;

@end
