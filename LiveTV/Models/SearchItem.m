//
//  SearchItem.m
//  LiveTV
//
//  Created by Koudai on 15/12/29.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import "SearchItem.h"

@implementation SearchItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"aid": @"aid",
             @"albumName": @"album_name",
             @"area": @"area",
             @"director": @"director",
             @"highPic": @"hor_high_pic",
             @"mainActor": @"main_actor",
             @"cateName": @"second_cate_name",
             @"updateNotification": @"updateNotification",
             @"moderator": @"moderator",
             @"tvSource": @"tv_source",
             @"picture12" : @"ver_high_pic"
             };
}

@end
