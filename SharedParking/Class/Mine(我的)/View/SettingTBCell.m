//
//  SettingTBCell.m
//  SharedParking
//
//  Created by galaxy on 2017/12/22.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "SettingTBCell.h"
@interface SettingTBCell ()

@end

@implementation SettingTBCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initView];
        
    }
    return self;
}

- (void)initView{
    [self addSubview:self.rightLab];
    
    [self.rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(100);
        make.top.bottom.mas_equalTo(0);
    }];
}

#pragma mark ---------------lazy ---------------------/
- (UILabel *)rightLab{
    if (!_rightLab) {
        _rightLab = [[UILabel alloc]init];
        _rightLab.font = kFontSize14;
        _rightLab.textColor = kColorDarkgray;
        _rightLab.textAlignment = NSTextAlignmentRight;
//        _rightLab.backgroundColor = kColorRandom;
    }
    return _rightLab;
}

@end
