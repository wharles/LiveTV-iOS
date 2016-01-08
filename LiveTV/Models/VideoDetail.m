//
//  VideoDetail.m
//  LiveTV
//
//  Created by Charlies Wang on 15/12/20.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import "VideoDetail.h"

@implementation VideoDetail

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"videoName" : @"video_name",
             @"tip" : @"tip",
             @"urlNormal" : @"url_nor",
             @"urlHigh" : @"url_high",
             @"urlSuper" : @"url_super",
             @"downloadURL" : @"download_url",
             @"videoOrder" : @"video_order"
             };
}

@end
