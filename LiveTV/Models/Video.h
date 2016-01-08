//
//  Video.h
//  LiveTV
//
//  Created by Charlies Wang on 15/12/19.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Video : MTLModel<MTLJSONSerializing>

@property (assign, nonatomic) NSInteger aid;
@property (strong, nonatomic) NSString *recommendTip;
@property (strong, nonatomic) NSString *videoName;
@property (strong, nonatomic) NSString *albumName;
@property (strong, nonatomic) NSString *picture16;
@property (strong, nonatomic) NSString *cateName;
@property (strong, nonatomic) NSString *scoreTip;
@property (strong, nonatomic) NSString *picture12;

@property (strong, nonatomic) NSString *director;
@property (strong, nonatomic) NSString *albumDesc;
@property (strong, nonatomic) NSString *year;
@property (strong, nonatomic) NSString *area;
@property (strong, nonatomic) NSString *mainActor;
@property (strong, nonatomic) NSString *tip;
@property (strong, nonatomic) NSString *countTip;

@property (strong, nonatomic) NSString *showDate;
@property (strong, nonatomic) NSString *guest;

@end
