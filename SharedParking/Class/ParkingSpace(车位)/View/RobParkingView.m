//
//  RobParkingView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/29.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "RobParkingView.h"
#import "CarportDetailVC.h"
@interface RobParkingView ()
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *countLab;
@property (nonatomic , strong) UILabel *infoLab;
@property (nonatomic , strong) UIButton *robBtn;
@end

@implementation RobParkingView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)setShortModel:(CarportShortListModel *)shortModel{
    _shortModel = shortModel;
    
    self.titleLab.text = shortModel.park_title;
    self.infoLab.text = [NSString stringWithFormat:@"距您%@",[HelpTool stringWithDistance: shortModel.distance]];
    self.countLab.text = [NSString stringWithFormat:@"剩余车位 %ld/%ld",shortModel.zongnum - shortModel.zhanyongnum,shortModel.zongnum];
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    self.backgroundColor = kColorWhite;
    self.layer.cornerRadius = 5;
//    self.layer.masksToBounds = YES;
    self.layer.shadowColor = [[UIColor grayColor] colorWithAlphaComponent:0.8].CGColor;
    self.layer.shadowOffset = CGSizeMake(2,2);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 2;
    
    [self addSubview:self.titleLab];
    [self addSubview:self.countLab];
    [self addSubview:self.infoLab];
    [self addSubview:self.robBtn];
    
    [self.robBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.top.mas_equalTo(kMargin15);
    }];
    
    [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(5);
        make.right.mas_equalTo(-kMargin15);
    }];
    
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-kMargin15);
        make.left.mas_equalTo(self.titleLab.mas_right);
    }];
    
//    self.titleLab.text = @"蓝山国际停车场";
//    self.infoLab.text = @"距您3km 开车约8分钟";
//    self.countLab.text = @"剩余车位12/65";
}

#pragma mark ---------------event ---------------------/
- (void)robParkingAction:(UIButton *)button{
    CarportDetailVC *vc = [[CarportDetailVC alloc]initWithCarportId:self.shortModel.id type:CarportShortRentType];
    [self.Controller.navigationController pushViewController:vc animated:YES];
}

#pragma mark -----------------Lazy---------------------/
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSize18;
        _titleLab.textColor = kColor333333;
    }
    return _titleLab;
}

- (UILabel *)infoLab{
    if (!_infoLab) {
        _infoLab = [[UILabel alloc]init];
        _infoLab.font = kFontSize14;
        _infoLab.textColor = kColor6B6B6B;
    }
    return _infoLab;
}

- (UILabel *)countLab{
    if (!_countLab) {
        _countLab = [[UILabel alloc]init];
        _countLab.font = kFontSize15;
        _countLab.textColor = kColorDD9900;
        _countLab.textAlignment = NSTextAlignmentRight;
//        _countLab.backgroundColor = kColorBlue;
    }
    return _countLab;
}

- (UIButton *)robBtn{
    if (!_robBtn) {
        _robBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_robBtn setTitle:@"抢车位" forState:UIControlStateNormal];
        _robBtn.titleLabel.font = kFontSizeBold15;
        [_robBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_robBtn setBackgroundColor:kNavBarColor];
        [_robBtn setImage:[UIImage imageNamed:@"home_nav"] forState:UIControlStateNormal];
        [_robBtn lc_imageTitleHorizontalAlignmentWithSpace:10];
        [_robBtn addTarget:self action:@selector(robParkingAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _robBtn;
}


+ (CGFloat)getHeight{
    return 120;
}
@end
