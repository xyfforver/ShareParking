//
//  OrderPayMethodView.m
//  yimaxingtianxia
//
//  Created by lingbao on 2017/6/8.
//  Copyright © 2017年 lingbao. All rights reserved.
//
#define kItemHeight 50.0

#import "OrderPayMethodView.h"
//#import "PayPasswordView.h"
//#import "OrdersPayRechangeView.h"
//
//#import "MemberCenterModel.h"
//
//#import "OrdersPayFailureVC.h"
//#import "ForgetPasswordVC.h"
#import "RechargeVC.h"
@interface OrderPayMethodView()
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UIView *line;
@property (nonatomic , strong) UIButton *selectBtn;
@property (nonatomic , strong) UIButton *sureBtn;

@end
@implementation OrderPayMethodView
- (instancetype)initWithIsRechange:(BOOL)isRechange frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.isRechange = isRechange;
        [self initView];
    }
    return self;
}

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
    
    [self addSubview:self.titleLab];
    [self addSubview:self.line];
    [self addSubview:self.sureBtn];
    
    NSArray *titleArr = @[@"微信支付",@"支付宝支付",@"余额支付"];
    NSArray *imgArr = @[@"pay_wechat",@"pay_alipay",@"pay_huiyuan"];
    self.titleLab.frame = CGRectMake(kMargin15, 0, kScreenWidth - 100, kItemHeight - 1);
    self.line.frame = CGRectMake(0, self.titleLab.bottom, kScreenWidth, 1);
    [HelpTool drawLineOfDashByCAShapeLayer:self.line lineLength:4 lineSpacing:4 lineColor:kBackGroundGrayColor lineDirection:YES];
    
    NSInteger count = titleArr.count;
    if (self.isRechange) {
        count = titleArr.count - 1;
    }
    for (int i = 0; i < count; i++) {
        UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [itemBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        itemBtn.titleLabel.font = kFontSize15;
        [itemBtn setTitleColor:kColor2b2b2b forState:UIControlStateNormal];
        [itemBtn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        itemBtn.frame = CGRectMake(15, self.line.bottom + i * kItemHeight, kScreenWidth - 15, kItemHeight);
        itemBtn.userInteractionEnabled = NO;
        [itemBtn lc_imageTitleHorizontalAlignmentWithSpace:10];
        itemBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

        
        [self addSubview:itemBtn];
        
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectBtn setImage:[UIImage imageNamed:@"pay_unselect"] forState:UIControlStateNormal];
        [selectBtn setImage:[UIImage imageNamed:@"pay_select"] forState:UIControlStateSelected];
        selectBtn.frame = CGRectMake(kScreenWidth - 30,itemBtn.top + (itemBtn.height - 15)/2.0, 15, 15);
        selectBtn.tag = 200 + i;
        [selectBtn addTarget:self action:@selector(selectPayMethodAction:) forControlEvents:UIControlEventTouchUpInside];
        [selectBtn setEnlargeEdgeWithTop:(itemBtn.height - 15)/2.0 right:15 bottom:(itemBtn.height - 15)/2.0 left:kScreenWidth - 30];
        
        [self addSubview:selectBtn];
        
        if (i == 0) {
            selectBtn.selected = YES;
            self.selectBtn = selectBtn;
        }else{
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, itemBtn.top, kScreenWidth, 1)];
            lineView.backgroundColor = kBackGroundGrayColor;
            [self addSubview:lineView];
        }
    }
    
    self.sureBtn.frame = CGRectMake(0, self.height - kItemHeight, kScreenWidth, kItemHeight);
    
}

#pragma mark ---------------event ---------------------/
- (void)confirmPayAction{
    NSInteger tag = self.selectBtn.tag - 200;
//    if (tag == 2) {
//        kSelfWeak;
//        [MemberCenterModel memberCenterWithSuccess:^(StatusModel *statusModel) {
//            kSelfStrong;
//            if (statusModel.flag == kFlagSuccess) {
//                MemberCenterModel *model = statusModel.data;
//                if ([model.price floatValue] >= [strongSelf.price floatValue]) {
//                    [strongSelf importPayPassword];
//                }else{
//                    [strongSelf lackOfBalance];
//                }
//            }else{
//                [WSProgressHUD showImage:nil status:statusModel.message];
//            }
//        }];
//    }else{
//        if (self.payMethodBlock) {
//            self.payMethodBlock(tag);
//        }
//    }
    if (self.payMethodBlock) {
        self.payMethodBlock(tag);
    }
}

- (void)selectPayMethodAction:(UIButton *)button{
    if (button == self.selectBtn ) {
        return;
    }
    
    self.selectBtn.selected = button.selected;
    button.selected = !button.selected;
    self.selectBtn = button;
}

- (void)importPayPassword{
//    kSelfWeak;
//    PayPasswordView *passwordView = [[PayPasswordView alloc]initWithPasswordType:PayPasswordOrderType confirm:^(NSString *password) {
//        kSelfStrong;
//        if (strongSelf.payMethodBlock) {
//            strongSelf.payMethodBlock([password integerValue]);
//        }
//    }];
//
//    passwordView.forgetBlock = ^{
//        kSelfStrong;
//        ForgetPasswordVC *vc = [[ForgetPasswordVC alloc]init];
//        [strongSelf.Controller.navigationController pushViewController:vc animated:YES];
//    };
//
//    [passwordView show];
}

- (void)lackOfBalance{
//    kSelfWeak;
//    OrdersPayRechangeView *rechangeView = [[OrdersPayRechangeView alloc]initWithConfirm:^{
//        kSelfStrong;
//        RechargeVC *vc = [[RechargeVC alloc]init];
//        [strongSelf.Controller.navigationController pushViewController:vc animated:YES];
//    }];
//    [rechangeView show];
}

#pragma mark -----------------Lazy---------------------/
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSizeBold18;
        _titleLab.textColor = kColor2b2b2b;
        _titleLab.text = @"支付方式";
    }
    return _titleLab;
}

- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
    }
    return _line;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = kFontSizeBold16;
        [_sureBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_sureBtn setBackgroundColor:kNavBarColor];
        [_sureBtn addTarget:self action:@selector(confirmPayAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}


@end
