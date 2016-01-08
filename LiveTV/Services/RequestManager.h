//
//  RequestManager.h
//  ZhihuDaily
//
//  Created by Koudai on 15/12/3.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

typedef enum : NSUInteger {
    RequestTypeVideo,
    RequestTypeDetail,
    RequestTypeSearch
} RequestType;

@interface RequestManager : NSObject

+ (instancetype)sharedManager;

@property (strong, nonatomic, readonly) NSArray *videoArray;
@property (strong, nonatomic, readonly) NSArray *seriesArray;
@property (strong, nonatomic, readonly) NSArray *varietyArray;
@property (strong, nonatomic, readonly) NSArray *searchResult;

@property (strong, nonatomic, readonly) NSArray *videoDetail;

@property (strong, nonatomic, readonly) NSNumber *requestMap;

- (void)startRequestWithRequestId:(RequestType)requestType;
- (void)startRequestWithRequestId:(RequestType)requestType parameter:(NSArray *)parameter;

@end
