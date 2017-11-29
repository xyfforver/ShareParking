//
//  CarportDetailShortCLCell.m
//  SharedParking
//
//  Created by galaxy on 2017/11/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportDetailShortCLCell.h"
@interface CarportDetailShortCLCell ()

@end

@implementation CarportDetailShortCLCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;

    [self addSubview: self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}



#pragma mark ---------------lazy ---------------------/
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSizeBold18;
        _titleLab.textColor = kColorWhite;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.backgroundColor = kNavBarColor;
    }
    return _titleLab;
}


@end
