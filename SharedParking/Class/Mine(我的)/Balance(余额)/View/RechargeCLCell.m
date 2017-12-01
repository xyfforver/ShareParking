//
//  RechargeCLCell.m
//  SharedParking
//
//  Created by galaxy on 2017/11/30.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "RechargeCLCell.h"
@interface RechargeCLCell ()

@end

@implementation RechargeCLCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = kColorC1C1C1.CGColor;
    
    [self addSubview:self.titleLab];
    [self addSubview:self.imgView];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(0);
    }];
    
    self.titleLab.text = @"100元";
}



#pragma mark ---------------lazy ---------------------/
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSize15;
        _titleLab.textColor = kColor333333;
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.image = [UIImage imageNamed:@"recharge_select"];
        _imgView.hidden = YES;
    }
    return _imgView;
}
@end
