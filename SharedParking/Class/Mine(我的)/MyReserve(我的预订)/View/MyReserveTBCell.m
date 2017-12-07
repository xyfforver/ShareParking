//
//  MyReserveTBCell.m
//  SharedParking
//
//  Created by galaxy on 2017/12/7.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "MyReserveTBCell.h"
#import "NavigationVC.h"
@interface MyReserveTBCell ()
@property (nonatomic , strong) UIView *infoBgView;
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *carNumLab;
@property (nonatomic , strong) UIButton *locationBtn;

@property (nonatomic , strong) UIView *btnBgView;
@property (nonatomic , strong) UIButton *cancelBtn;
@property (nonatomic , strong) UIButton *gpsBtn;
@property (nonatomic , strong) UIView *lineView;
@end

@implementation MyReserveTBCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initView];
        
    }
    return self;
}

- (void)setReserveModel:(MyReserveModel *)reserveModel{
    _reserveModel = reserveModel;
    
    self.titleLab.text = reserveModel.park_title;
    NSString *str = [NSString stringWithFormat:@"车位号：%@",reserveModel.parking_number];
    NSMutableAttributedString *contentMuStr = [[NSMutableAttributedString alloc]initWithString:str];
    [contentMuStr addAttribute:NSForegroundColorAttributeName value:kColorDD9900 range:NSMakeRange(4, str.length - 4)];
    self.carNumLab.attributedText = contentMuStr;
    
    [self.locationBtn setTitle:reserveModel.park_address forState:UIControlStateNormal];
    
    self.cancelBtn.userInteractionEnabled = NO;
    if (reserveModel.reserve_status == 0) {
        //预订
        self.cancelBtn.userInteractionEnabled = YES;
        [self.cancelBtn setTitle:@"取消预订" forState:UIControlStateNormal];
    }else if (reserveModel.reserve_status == 1){
        //已取消
        [self.cancelBtn setTitle:@"已取消" forState:UIControlStateNormal];
    }else{
        //已完成
        [self.cancelBtn setTitle:@"已完成" forState:UIControlStateNormal];
    }
    
}

#pragma mark ---------------network ---------------------/
- (void)cancelReserve{
    kSelfWeak;
    [MyReserveModel cancelReserveWithId:self.reserveModel.id success:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            if (strongSelf.reloadBlock) {
                strongSelf.reloadBlock();
            }
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
    }];
}

#pragma mark ---------------init ---------------------/
- (void)initView{
    self.contentView.backgroundColor = kBackGroundGrayColor;
    
    [self.contentView addSubview:self.infoBgView];
    [self.infoBgView addSubview:self.titleLab];
    [self.infoBgView addSubview:self.carNumLab];
    [self.infoBgView addSubview:self.locationBtn];
    
    [self.contentView addSubview:self.btnBgView];
    [self.btnBgView addSubview:self.cancelBtn];
    [self.btnBgView addSubview:self.lineView];
    [self.btnBgView addSubview:self.gpsBtn];
    
    
    [self.btnBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.right.mas_equalTo(-kMargin15);
        make.bottom.mas_equalTo(-kMargin15);
        make.height.mas_equalTo(50);
    }];
    
    [self.infoBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.btnBgView);
        make.top.mas_equalTo(kMargin10);
        make.bottom.mas_equalTo(self.btnBgView.mas_top).offset(-5);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.btnBgView.mas_width).multipliedBy(0.5);
    }];
    
    [self.gpsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.mas_equalTo(self.cancelBtn);
        make.right.mas_equalTo(0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kMargin15);
        make.left.mas_equalTo(self.cancelBtn.mas_right).offset(-1);
        make.width.mas_equalTo(1);
        make.centerY.mas_equalTo(self.btnBgView);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.right.mas_equalTo(-kMargin15);
        make.top.mas_equalTo(30);
    }];
    
    [self.carNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(25);
    }];
    
    [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.carNumLab.mas_bottom).offset(20);
    }];
    [self.locationBtn lc_imageTitleHorizontalAlignmentWithSpace:10];
    
}

#pragma mark ---------------event ---------------------/
- (void)cancelAction:(UIButton *)button{
    [UIAlertView alertViewWithTitle:@"提示" message:@"确定要取消该车位吗？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] onDismiss:^(int buttonIndex, NSString *buttonTitle) {
        [self cancelReserve];
    } onCancel:nil];
}

- (void)gpsAction:(UIButton *)button{
    NavigationVC *vc = [[NavigationVC alloc]initWithLatitude:self.reserveModel.latitude longitude:self.reserveModel.longitude];
    [self.Controller.navigationController pushViewController:vc animated:YES];
}


#pragma mark -----------------Lazy---------------------/
- (UIView *)infoBgView{
    if (!_infoBgView) {
        _infoBgView = [[UIView alloc]init];
        _infoBgView.backgroundColor = kColorWhite;
        _infoBgView.layer.cornerRadius = 3;
        _infoBgView.layer.masksToBounds = YES;
    }
    return _infoBgView;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSize18;
        _titleLab.textColor = kColorBlack;
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UILabel *)carNumLab{
    if (!_carNumLab) {
        _carNumLab = [[UILabel alloc]init];
        _carNumLab.font = kFontSize15;
        _carNumLab.textColor = kColor333333;
        _carNumLab.textAlignment = NSTextAlignmentCenter;
    }
    return _carNumLab;
}

- (UIButton *)locationBtn{
    if (!_locationBtn) {
        _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_locationBtn setTitle:@"位置" forState:UIControlStateNormal];
        _locationBtn.titleLabel.font = kFontSize15;
        [_locationBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
        [_locationBtn setImage:[UIImage imageNamed:@"mine_location"] forState:UIControlStateNormal];
    }
    return _locationBtn;
}

- (UIView *)btnBgView{
    if (!_btnBgView) {
        _btnBgView = [[UIView alloc]init];
        _btnBgView.backgroundColor = kColorWhite;
        _btnBgView.layer.cornerRadius = 3;
        _btnBgView.layer.masksToBounds = YES;
    }
    return _btnBgView;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消预订" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = kFontSize15;
        [_cancelBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)gpsBtn{
    if (!_gpsBtn) {
        _gpsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_gpsBtn setTitle:@"导航" forState:UIControlStateNormal];
        _gpsBtn.titleLabel.font = kFontSize15;
        [_gpsBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
        [_gpsBtn addTarget:self action:@selector(gpsAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gpsBtn;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kColor6B6B6B;
    }
    return _lineView;
}

+ (CGFloat )getHeight{
    return 240;
}


@end
