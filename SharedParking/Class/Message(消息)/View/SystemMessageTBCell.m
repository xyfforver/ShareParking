//
//  SystemMessageTBCell.m
//  SharedParking
//
//  Created by galaxy on 2017/12/9.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "SystemMessageTBCell.h"
@interface SystemMessageTBCell ()
@property (nonatomic , strong) UIView *bgView;
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *timeLab;
@property (nonatomic , strong) UIImageView *imgView;
@property (nonatomic , strong) UILabel *infoLab;
@end

@implementation SystemMessageTBCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initView];
        
    }
    return self;
}


- (void)setMessageModel:(MessageModel *)messageModel{
    _messageModel = messageModel;
    
    self.titleLab.text = messageModel.message_title;
    self.timeLab.text = [HelpTool timestampSwitchTime:[messageModel.create_time integerValue] andFormatter:nil];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:kImageStringJoint(messageModel.message_img)]];
    
}

- (void)initView{
    self.contentView.backgroundColor = kBackGroundGrayColor;
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLab];
    [self.bgView addSubview:self.timeLab];
    [self.bgView addSubview:self.imgView];
    [self.bgView addSubview:self.infoLab];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.right.mas_equalTo(-kMargin15);
        make.top.bottom.mas_equalTo(0);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(3);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.timeLab.mas_bottom).offset(kMargin10);
        make.bottom.mas_equalTo(-47);
    }];
    
    [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLab);
        make.bottom.mas_equalTo(-kMargin15);
    }];
    
    self.titleLab.text = @"圣诞特惠";
    self.timeLab.text = @"12月9号";
    

}

#pragma mark ---------------lazy ---------------------/
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = kColorWhite;
        _bgView.layer.cornerRadius = 5;
    }
    return _bgView;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSize20;
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

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = kColorRandom;
    }
    return _imgView;
}

- (UILabel *)infoLab{
    if (!_infoLab) {
        _infoLab = [[UILabel alloc]init];
        _infoLab.font = kFontSize14;
        _infoLab.textColor = kColor333333;
        _infoLab.text = @"阅读全文";
    }
    return _infoLab;
}
@end
