//
//  MessageTBCell.m
//  SharedParking
//
//  Created by galaxy on 2017/11/30.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "MessageTBCell.h"
@interface MessageTBCell ()
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *timeLab;
@property (nonatomic , strong) UILabel *infoLab;
@end

@implementation MessageTBCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initView];
        
    }
    return self;
}

- (void)initView{
    self.contentView.backgroundColor = kColorWhite;
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.timeLab];
    [self.contentView addSubview:self.infoLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.top.mas_equalTo(kMargin15);
        make.right.mas_equalTo(-40);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(3);
    }];
    
    [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab);
        make.right.mas_equalTo(-kMargin15);
        make.top.mas_equalTo(self.timeLab.mas_bottom).offset(10);
    }];
    
    self.titleLab.text = @"车位预订提醒";
    self.timeLab.text = @"2017-10-23 22：22：22";
    self.infoLab.text = @"您成功预订了一个车位，请在20分钟内停车";
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

- (UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = kFontSize13;
        _timeLab.textColor = kColor6B6B6B;
    }
    return _timeLab;
}

- (UILabel *)infoLab{
    if (!_infoLab) {
        _infoLab = [[UILabel alloc]init];
        _infoLab.font = kFontSize14;
        _infoLab.textColor = kColor333333;
    }
    return _infoLab;
}
@end
