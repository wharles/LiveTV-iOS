//
//  Video.m
//  LiveTV
//
//  Created by Charlies Wang on 15/12/19.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import "Video.h"

@implementation Video

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"aid" : @"aid",
             @"videoName" : @"video_name",
             @"recommendTip" : @"recommend_tip",
             @"picture16" : @"hor_w16_pic",
             @"cateName" : @"second_cate_name",
             @"scoreTip" : @"score_tip",
             @"picture12" : @"ver_w12_pic",
             @"albumName" : @"album_name",
             @"director" : @"director",
             @"albumDesc" : @"album_desc",
             @"year" : @"year",
             @"area" : @"area",
             @"mainActor" : @"main_actor",
             @"tip" : @"tip",
             @"countTip" : @"latest_video_count_tip",
             @"showDate" : @"show_date",
             @"guest" : @"guest"
             };
}

@end
