//
//  Style1TableViewCell.m
//  LiveTV
//
//  Created by Charlies Wang on 15/12/19.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import "Style1TableViewCell.h"
#import "Masonry.h"

@implementation Style1TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

/**
 设置cell的布局
 **/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat spacing = 12.0f;
        self.cubeView = [[UIView alloc] init];
        [self.contentView addSubview:self.cubeView];
        [self.cubeView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).with.offset(spacing);
            make.size.mas_equalTo(CGSizeMake(48.0, 48.0));
        }];
        self.cubeLabel = [[UILabel alloc] init];
        self.cubeLabel.textAlignment = NSTextAlignmentCenter;
        self.cubeLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Medium" size:30];
        [self.cubeView  addSubview:self.cubeLabel];
        [self.cubeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.cubeView );
            make.edges.equalTo(self.cubeView ).with.insets(UIEdgeInsetsMake(4, 4, 4, 4));
        }];
        self.titleLabel = [UILabel new];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:17.0];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).with.priorityLow();
            make.left.equalTo(self.cubeView .mas_right).with.offset(spacing);
            make.right.equalTo(self.contentView.mas_right).with.offset(-spacing);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
