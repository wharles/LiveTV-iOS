//
//  VideoDetail.h
//  LiveTV
//
//  Created by Charlies Wang on 15/12/20.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface VideoDetail : MTLModel<MTLJSONSerializing>

@property (strong, nonatomic) NSString *videoName;
@property (strong, nonatomic) NSString *tip;
@property (strong, nonatomic) NSString *urlNormal;
@property (strong, nonatomic) NSString *urlHigh;
@property (strong, nonatomic) NSString *urlSuper;
@property (strong, nonatomic) NSString *downloadURL;
@property (assign, nonatomic) NSInteger videoOrder;

@end
