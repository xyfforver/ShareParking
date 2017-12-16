//
//  ParkingSpaceTBCell.m
//  SharedParking
//
//  Created by galaxy on 2017/10/28.
//  Copyright © 2017年 galaxy. All rights reserved.
//
#define kImageWidth 50.0

#import "ParkingSpaceTBCell.h"

@interface ParkingSpaceTBCell ()
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *locationLab;
@property (nonatomic,strong) UILabel *numberLab;
@property (nonatomic,strong) UILabel *typeLab;

@property (nonatomic,strong) UILabel *reserveLab;
@property (nonatomic,strong) UILabel *spaceLab;
@property (nonatomic,strong) UILabel *timeLab;
@end

@implementation ParkingSpaceTBCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initView];
        
    }
    return self;
}

- (void)setShortModel:(CarportShortListModel *)shortModel{
    _shortModel = shortModel;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:kImageStringJoint(shortModel.park_img)]];
    
    self.titleLab.text = shortModel.park_title;
    self.typeLab.text = @"错时";
    
    NSString *distance = [HelpTool stringWithDistance:shortModel.distance];
    
    self.locationLab.text = [NSString stringWithFormat:@"距您%@",distance];
    self.numberLab.text = [NSString stringWithFormat:@"剩余车位 %ld/%ld",shortModel.zongnum - shortModel.zhanyongnum,shortModel.zongnum];
    
    self.reserveLab.text = @"预订";
    self.spaceLab.text = @"地锁";
    self.spaceLab.hidden = shortModel.park_type == 0;

}

- (void)setLongModel:(CarportLongListModel *)longModel{
    _longModel = longModel;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:kImageStringJoint(longModel.park_img)]];
    
    
    self.titleLab.text = longModel.parking_title;
    self.typeLab.text = @"长租";
    
    NSString *distance = [HelpTool stringWithDistance:longModel.distance];
    
    self.locationLab.text = [NSString stringWithFormat:@"距您%@ %ld次浏览",distance,longModel.views];
    self.numberLab.text = [NSString stringWithFormat:@"￥%.2f/月",longModel.parking_fee];
    
    self.reserveLab.text = longModel.parking_fabutype ? @"个人" : @"商户";
    //车位类型 0小区 1写字楼 2 其他
    self.spaceLab.text = [HelpTool getRentCarportWithType:longModel.parking_cheweitype];

    self.timeLab.hidden = NO;
    self.timeLab.text = longModel.time_since;
}

- (void)initView{
//    self.backgroundColor = kColorRandom;
    
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.locationLab];
    [self.contentView addSubview:self.numberLab];
    [self.contentView addSubview:self.typeLab];
    
    [self.contentView addSubview:self.reserveLab];
    [self.contentView addSubview:self.spaceLab];
    [self.contentView addSubview:self.timeLab];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(20);
        make.width.height.mas_equalTo(kImageWidth);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgView.mas_right).offset(10);
        make.top.mas_equalTo(self.imgView);
        make.right.mas_equalTo(self.numberLab.mas_left).offset(-5);
    }];
    
    [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_top).offset(2);
        make.right.mas_equalTo(-15);
    }];
    
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numberLab.mas_bottom).offset(10);
        make.right.mas_equalTo(self.numberLab);
        make.width.mas_equalTo(60);
    }];
    
    [self.locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(10);
        make.right.mas_equalTo(self.typeLab.mas_left).offset(-5);
    }];
    
    [self.reserveLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.locationLab.mas_bottom).offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    
    [self.spaceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.reserveLab.mas_right).offset(5);
        make.top.width.height.mas_equalTo(self.reserveLab);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kMargin15);
        make.top.mas_equalTo(self.typeLab.mas_bottom).offset(5);
    }];
    

}

#pragma mark ---------------lazy ---------------------/
- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = kColorC1C1C1;
        _imgView.layer.cornerRadius = kImageWidth/2.0;
        _imgView.layer.masksToBounds = YES;
    }
    return _imgView;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSize15;
        _titleLab.textColor = kColor333333;
    }
    return _titleLab;
}

- (UILabel *)locationLab{
    if (!_locationLab) {
        _locationLab = [[UILabel alloc]init];
        _locationLab.font = kFontSize13;
        _locationLab.textColor = kColor6B6B6B;
    }
    return _locationLab;
}

- (UILabel *)numberLab{
    if (!_numberLab) {
        _numberLab = [[UILabel alloc]init];
        _numberLab.font = kFontSize15;
        _numberLab.textColor = kColorDD9900;
        _numberLab.textAlignment = NSTextAlignmentRight;
//        _numberLab.backgroundColor = kColorBlue;
    }
    return _numberLab;
}

- (UILabel *)typeLab{
    if (!_typeLab) {
        _typeLab = [[UILabel alloc]init];
        _typeLab.font = kFontSize15;
        _typeLab.textColor = kColor333333;
        _typeLab.textAlignment = NSTextAlignmentRight;
    }
    return _typeLab;
}
//
- (UILabel *)reserveLab{
    if (!_reserveLab) {
        _reserveLab = [[UILabel alloc]init];
        _reserveLab.font = kFontSizeBold12;
        _reserveLab.textColor = kColorWhite;
        _reserveLab.backgroundColor = kColorDeepBlack;
        _reserveLab.textAlignment = NSTextAlignmentCenter;
        
        _reserveLab.layer.masksToBounds = YES;
        _reserveLab.layer.cornerRadius = 10;
//        _reserveLab.text = @"预订";
    }
    return _reserveLab;
}

- (UILabel *)spaceLab{
    if (!_spaceLab) {
        _spaceLab = [[UILabel alloc]init];
        _spaceLab.font = kFontSizeBold12;
        _spaceLab.textColor = kColorWhite;
        _spaceLab.backgroundColor = kColorDeepBlack;
        _spaceLab.textAlignment = NSTextAlignmentCenter;
        
        _spaceLab.layer.masksToBounds = YES;
        _spaceLab.layer.cornerRadius = 10;
    }
    return _spaceLab;
}

- (UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = kFontSize13;
        _timeLab.textColor = kColor6B6B6B;
        _timeLab.textAlignment = NSTextAlignmentRight;
        _timeLab.hidden = YES;
    }
    return _timeLab;
}

@end
