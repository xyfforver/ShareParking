//
//  CarportDetailHeaderView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//
#define kHeadWidth 70
#define kInfoHeight 110
#import "CarportDetailHeaderView.h"
@interface CarportDetailHeaderView ()
@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *locationLab;
@property (nonatomic,strong) UIImageView *headImgView;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *personalLab;
@property (nonatomic,strong) UILabel *buildingLab;
@end

@implementation CarportDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    self.backgroundColor = kColorWhite;
    
    [self addSubview:self.imgView];
    [self addSubview:self.backBtn];
    [self addSubview:self.titleLab];
    [self addSubview:self.locationLab];
    [self addSubview:self.timeLab];
    [self addSubview:self.personalLab];
    [self addSubview:self.buildingLab];
    [self addSubview:self.headImgView];

    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-kInfoHeight);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.top.mas_equalTo(kStatusBarHeight + 15);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.top.mas_equalTo(self.imgView.mas_bottom).offset(25);
    }];
    
    [self.locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right).offset(10);
        make.centerY.mas_equalTo(self.titleLab.mas_centerY);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(5);
    }];
    
    [self.personalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.top.mas_equalTo(self.timeLab.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(45);
    }];
    
    [self.buildingLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.personalLab.mas_right).offset(5);
        make.centerY.height.mas_equalTo(self.personalLab);
        make.width.mas_equalTo(50);
    }];
    
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kMargin15);
        make.height.width.mas_equalTo(kHeadWidth);
        make.centerY.mas_equalTo(self.imgView.mas_bottom);
    }];
    
    
    self.titleLab.text = @"萧山写字楼";
    self.locationLab.text = @"距您3km";
    self.timeLab.text = @"一天前 23人浏览";
    self.personalLab.text = @"个人";
    self.buildingLab.text = @"写字楼";
    
}

#pragma mark ---------------event ---------------------/
- (void)backAction:(UIButton *)button{
    [self.Controller.navigationController popViewControllerAnimated:YES];
}

#pragma mark -----------------Lazy---------------------/

- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"goback"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [_backBtn setEnlargeEdge:10];
    }
    return _backBtn;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = kColorGreen;
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

- (UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = kFontSize13;
        _timeLab.textColor = kColor6B6B6B;
    }
    return _timeLab;
}

- (UIImageView *)headImgView{
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc]init];
        _headImgView.backgroundColor = kBackGroundGrayColor;
        _headImgView.layer.cornerRadius = kHeadWidth / 2.0;
        _headImgView.layer.masksToBounds = YES;
        _headImgView.layer.borderWidth = 3.0;
        _headImgView.layer.borderColor = kColorWhite.CGColor;
    }
    return _headImgView;
}

- (UILabel *)personalLab{
    if (!_personalLab) {
        _personalLab = [[UILabel alloc]init];
        _personalLab.font = kFontSize12;
        _personalLab.textColor = kColorWhite;
        _personalLab.textAlignment = NSTextAlignmentCenter;
        _personalLab.layer.cornerRadius = 10;
        _personalLab.layer.masksToBounds = YES;
        _personalLab.backgroundColor = kColorBlack;
    }
    return _personalLab;
}

- (UILabel *)buildingLab{
    if (!_buildingLab) {
        _buildingLab = [[UILabel alloc]init];
        _buildingLab.font = kFontSize12;
        _buildingLab.textColor = kColorWhite;
        _buildingLab.textAlignment = NSTextAlignmentCenter;
        _buildingLab.layer.cornerRadius = 10;
        _buildingLab.layer.masksToBounds = YES;
        _buildingLab.backgroundColor = kColorBlack;
    }
    return _buildingLab;
}

+ (CGFloat)getHeight{
    return 280/750.0*kScreenWidth + kTabbarSafeBottomMargin + kInfoHeight;
}
@end
