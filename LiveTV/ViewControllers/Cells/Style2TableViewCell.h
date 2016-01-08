//
//  Style2TableViewCell.h
//  LiveTV
//
//  Created by Charlies Wang on 15/12/19.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Style2TableViewCell : UITableViewCell<UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIImageView *leftImageView;
@property (strong, nonatomic) UILabel *leftImageLabel;
@property (strong, nonatomic) UILabel *leftTitle;
@property (strong, nonatomic) UILabel *leftDetail;

@property (strong, nonatomic) UIImageView  *rightImageView;
@property (strong, nonatomic) UILabel *rightImageLabel;
@property (strong, nonatomic) UILabel *rightTitle;
@property (strong, nonatomic) UILabel *rightDetail;

@property (copy, nonatomic) void(^leftClicked)(id x);
@property (copy, nonatomic) void(^rightClicked)(id x);

@end
