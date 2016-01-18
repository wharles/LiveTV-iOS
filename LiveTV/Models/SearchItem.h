//
//  SearchItem.h
//  LiveTV
//
//  Created by Koudai on 15/12/29.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface SearchItem : MTLModel<MTLJSONSerializing>

@property (assign, nonatomic) NSInteger aid;
@property (strong, nonatomic) NSString *albumName;
@property (strong, nonatomic) NSString *area;
@property (strong, nonatomic) NSString *highPic;
@property (strong, nonatomic) NSString *picture12;
@property (strong, nonatomic) NSString *cateName;
@property (strong, nonatomic) NSString *updateNotification;
@property (strong, nonatomic) NSString *tvSource;
@property (strong, nonatomic) NSString *moderator;
@property (strong, nonatomic) NSString *director;
@property (strong, nonatomic) NSString *mainActor;

@end
