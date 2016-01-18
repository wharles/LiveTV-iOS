//
//  SearchTableViewCell.m
//  LiveTV
//
//  Created by Koudai on 16/1/18.
//  Copyright © 2016年 Charlies Wang. All rights reserved.
//

#import "SearchTableViewCell.h"
#import "Masonry.h"

@implementation SearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat spacing = 8.0f;
        _pictureImageView = [UIImageView new];
        [self.contentView addSubview:_pictureImageView];
        [_pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(spacing);
            make.top.equalTo(self.contentView.mas_top).with.offset(spacing);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-spacing);
            make.width.mas_equalTo(@(140));
            make.height.mas_equalTo(@(96));
        }];
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:15.0];
        [_nameLabel sizeToFit];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(spacing);
            make.left.equalTo(_pictureImageView.mas_right).with.offset(spacing);
        }];
        _cateNameLabel = [UILabel new];
        _cateNameLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:15.0];
        [_cateNameLabel sizeToFit];
        _cateNameLabel.numberOfLines = 0;
        [self.contentView addSubview:_cateNameLabel];
        [_cateNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nameLabel.mas_bottom).with.offset(spacing);
            make.left.equalTo(_pictureImageView.mas_right).with.offset(spacing);
        }];
//        _areaLabel = [UILabel new];
//        [_areaLabel sizeToFit];
//        [self.contentView addSubview:_areaLabel];
//        [_areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_cateNameLabel.mas_bottom).with.offset(spacing);
//            make.left.equalTo(_pictureImageView.mas_right).with.offset(spacing);
//        }];
        _mainActorLabel = [UILabel new];
        _mainActorLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:15.0];
        [_mainActorLabel sizeToFit];
        _mainActorLabel.numberOfLines = 0;
        [self.contentView addSubview:_mainActorLabel];
        [_mainActorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).with.offset(-spacing);
            make.top.equalTo(_cateNameLabel.mas_bottom).with.offset(spacing);
            make.left.equalTo(_pictureImageView.mas_right).with.offset(spacing);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
