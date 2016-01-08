//
//  Style2TableViewCell.m
//  LiveTV
//
//  Created by Charlies Wang on 15/12/19.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import "Style2TableViewCell.h"
#import "Masonry.h"
#import "GlobalMacro.h"

@implementation Style2TableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat spacing = 8.0f;
        //先来左右两边大小相等的view作为容器
        UIView *leftView = [[UIView alloc] init];
        UIView *rightView = [[UIView alloc] init];
        [self.contentView addSubview:leftView];
        [self.contentView addSubview:rightView];
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).with.offset(spacing);
            make.right.equalTo(rightView.mas_left).with.offset(-spacing);
            make.height.mas_equalTo(@(150));
            make.width.equalTo(rightView);
        }];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.equalTo(leftView.mas_right).with.offset(spacing);
            make.right.equalTo(self.contentView.mas_right).with.offset(-spacing);
            make.height.mas_equalTo(@(150));
            make.width.equalTo(leftView);
        }];
        //左边的图
        self.leftImageView = [[UIImageView alloc] init];
        [leftView addSubview:self.leftImageView];
        [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.right.equalTo(leftView);
            make.height.mas_equalTo(@(100));
        }];
        //图片的文字说明
        self.leftImageLabel = [[UILabel alloc] init];
        self.leftImageLabel.textColor = MAINCOLOR;
        self.leftImageLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:12.0];
        self.leftImageLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [leftView addSubview:self.leftImageLabel];
        [self.leftImageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.bottom.and.right.equalTo(self.leftImageView);
            make.height.mas_equalTo(@(20));
        }];
        //左边标题
        self.leftTitle = [[UILabel alloc] init];
        self.leftTitle.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:15.0];
        [leftView addSubview:self.leftTitle];
        [self.leftTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(leftView);
            make.top.equalTo(self.leftImageView.mas_bottom).with.offset(spacing);
            make.height.mas_equalTo(@(21));
        }];
        //左边描述
        self.leftDetail = [[UILabel alloc] init];
        [leftView addSubview:self.leftDetail];
        self.leftDetail.font =  [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:15.0];
        self.leftDetail.textColor = [UIColor grayColor];
        [self.leftDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(leftView);
            make.top.equalTo(self.leftTitle.mas_bottom);
            make.height.mas_equalTo(@(21));
        }];
        
        //左边的图
        self.rightImageView = [[UIImageView alloc] init];
        [rightView addSubview:self.rightImageView];
        [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.right.equalTo(rightView);
            make.height.mas_equalTo(@(100));
        }];
        //图片的文字说明
        self.rightImageLabel = [[UILabel alloc] init];
        self.rightImageLabel.textColor = MAINCOLOR;
        self.rightImageLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:12.0];
        self.rightImageLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [rightView addSubview:self.rightImageLabel];
        [self.rightImageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.bottom.and.right.equalTo(self.rightImageView);
            make.height.mas_equalTo(@(20));
        }];
        //右边标题
        self.rightTitle = [[UILabel alloc] init];
        self.rightTitle.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:15.0];
        [rightView addSubview:self.rightTitle];
        [self.rightTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(rightView);
            make.top.equalTo(self.rightImageView.mas_bottom).with.offset(spacing);
            make.height.mas_equalTo(@(21));
        }];
        //右边描述
        self.rightDetail = [[UILabel alloc] init];
        self.rightDetail.font =  [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:15.0];
        self.rightDetail.textColor = [UIColor grayColor];
        [rightView addSubview:self.rightDetail];
        [self.rightDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(rightView);
            make.top.equalTo(self.rightTitle.mas_bottom);
            make.height.mas_equalTo(@(21));
        }];
        
        //对view增加处理事件，代替cell selected
        UITapGestureRecognizer* leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftTap:)];
        [leftView addGestureRecognizer:leftTap];
        leftTap.delegate = self;
        leftTap.cancelsTouchesInView = NO;
        
        UITapGestureRecognizer* rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightTap:)];
        [rightView addGestureRecognizer:rightTap];
        rightTap.delegate = self;
        rightTap.cancelsTouchesInView = NO;
    }
    return self;
}

-(void)handleLeftTap:(UITapGestureRecognizer *)sender{
    if (self.leftClicked != nil) {
        self.leftClicked(sender);
    }
}

-(void)handleRightTap:(UITapGestureRecognizer *)sender{
    if (self.rightClicked != nil) {
        self.rightClicked(sender);
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
