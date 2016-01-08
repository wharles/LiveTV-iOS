//
//  ItemCollectionViewCell.m
//  LiveTV
//
//  Created by Charlies Wang on 15/12/20.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import "ItemCollectionViewCell.h"
#import "Masonry.h"
#import "GlobalMacro.h"

#import <HexColors/HexColor.h>

@implementation ItemCollectionViewCell {
    __weak UILabel *_titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [HXColor colorWithHexString:BARTINTCOLOR];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = MAINCOLOR;
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    _titleLabel.text = title;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(@(40));
        make.height.mas_equalTo(@(40));
    }];
}

@end
