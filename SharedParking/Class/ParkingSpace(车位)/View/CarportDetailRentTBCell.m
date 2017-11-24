//
//  CarportDetailRentTBCell.m
//  SharedParking
//
//  Created by galaxy on 2017/11/24.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportDetailRentTBCell.h"
@interface CarportDetailRentTBCell ()

@end

@implementation CarportDetailRentTBCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initView];
        
    }
    return self;
}

- (void)initView{

    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.subLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.subLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kMargin15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = kBackGroundGrayColor;
    [self.contentView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
}

#pragma mark ---------------lazy ---------------------/
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSize15;
        _titleLab.textColor = kColor333333;
    }
    return _titleLab;
}

- (UILabel *)subLab{
    if (!_subLab) {
        _subLab = [[UILabel alloc]init];
        _subLab.font = kFontSize15;
        _subLab.textColor = kColor6B6B6B;
        _subLab.textAlignment = NSTextAlignmentRight;
    }
    return _subLab;
}
@end
