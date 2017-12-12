//
//  FindBreakRulesView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/16.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "FindBreakRulesView.h"
#import "JMTitleTextfieldView.h"

#import "CarNumberListVC.h"
#import "CarportShortItemModel.h"
@interface FindBreakRulesView ()
@property (nonatomic , strong) JMTitleTextfieldView *carNumView;
@property (nonatomic , strong) JMTitleTextfieldView *endNumView;
@property (nonatomic , strong) UIButton *selectBtn;
@property (nonatomic , strong) UIButton *agreeBtn;
@property (nonatomic , strong) UIButton *submitBtn;
@end

@implementation FindBreakRulesView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    
    [self addSubview:self.carNumView];
    [self addSubview:self.endNumView];
    [self addSubview:self.selectBtn];
    [self addSubview:self.agreeBtn];
    [self addSubview:self.submitBtn];
}

#pragma mark ---------------NetWork-------------------------/
- (void)checkData{
//    kSelfWeak;
    [CarportShortItemModel checkViolationWithCarNum:self.carNumView.textField.text endNum:self.endNumView.textField.text success:^(StatusModel *statusModel) {
//        kSelfStrong;
        [WSProgressHUD showImage:nil status:statusModel.message];
        
        if (statusModel.flag == kFlagSuccess) {

        }
    }];
}

#pragma mark ---------------Event-------------------------/
- (void)selectAction:(UIButton *)button{
    CarNumberListVC *vc = [[CarNumberListVC alloc]init];
    kSelfWeak;
    vc.selectBlock = ^(NSString *carNum, NSString *endNum) {
        kSelfStrong;
        strongSelf.carNumView.textField.text = carNum;
        strongSelf.endNumView.textField.text = endNum;
    };
    [self.Controller.navigationController pushViewController:vc animated:YES];
}

- (void)submitAction:(UIButton *)button{
    if (self.carNumView.textField.text.length < 6 || self.carNumView.textField.text.length > 7) {
        [WSProgressHUD showImage:nil status:@"请输入正确的车牌号码"];
        return;
    }
    
    if(self.endNumView.textField.text.length != 6){
        [WSProgressHUD showImage:nil status:@"请输入正确的发动机尾号"];
        return;
    }
    
    if (!self.agreeBtn.selected) {
        [WSProgressHUD showImage:nil status:@"请阅读并授权协议"];
        return;
    }

    [self checkData];
}

- (void)agreeAction:(UIButton *)button{
    button.selected = !button.selected;
}

#pragma mark ---------------Lazy-------------------------/
- (JMTitleTextfieldView *)carNumView{
    if (!_carNumView) {
        _carNumView = [[JMTitleTextfieldView alloc]initWithFrame:CGRectMake(kMargin15, kMargin15, kScreenWidth - kMargin15 * 2, 45)];
        _carNumView.layer.cornerRadius = 3;
        _carNumView.layer.masksToBounds = YES;
        _carNumView.backgroundColor = kColorWhite;
        _carNumView.titleLab.text = @"车牌号码：";
    }
    return _carNumView;
}

- (JMTitleTextfieldView *)endNumView{
    if (!_endNumView) {
        _endNumView = [[JMTitleTextfieldView alloc]initWithFrame:CGRectMake(kMargin15, self.carNumView.bottom + kMargin10, kScreenWidth - 2 * kMargin15, 45)];
        _endNumView.layer.cornerRadius = 3;
        _endNumView.layer.masksToBounds = YES;
        _endNumView.backgroundColor = kColorWhite;
        _endNumView.titleLab.text = @"发动机尾号后6位：";
    }
    return _endNumView;
}

- (UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setTitle:@"选择已有车牌" forState:UIControlStateNormal];
        _selectBtn.titleLabel.font = kFontSize14;
        [_selectBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"carport_jiantou"] forState:UIControlStateNormal];
        [_selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        _selectBtn.frame = CGRectMake(kScreenWidth - kMargin15 - 110, self.endNumView.bottom + 10, 110, 20);
        [_selectBtn lc_titleImageHorizontalAlignmentWithSpace:7];
        
        
    }
    return _selectBtn;
}

- (UIButton *)agreeBtn{
    if (!_agreeBtn) {
        _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_agreeBtn setTitle:@"我已阅读并授权协议" forState:UIControlStateNormal];
        _agreeBtn.titleLabel.font = kFontSizeBold13;
        [_agreeBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
        [_agreeBtn setImage:[UIImage imageNamed:@"read_unselect"] forState:UIControlStateNormal];
        [_agreeBtn setImage:[UIImage imageNamed:@"read_select"] forState:UIControlStateSelected];
        [_agreeBtn addTarget:self action:@selector(agreeAction:) forControlEvents:UIControlEventTouchUpInside];
        _agreeBtn.frame = CGRectMake(kMargin15, self.selectBtn.bottom + 35, kScreenWidth - kMargin15 * 2, 20);
        [_agreeBtn lc_imageTitleHorizontalAlignmentWithSpace:5];
        
        
    }
    return _agreeBtn;
}

- (UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = kFontSizeBold15;
        [_submitBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_submitBtn setBackgroundColor:kNavBarColor];
        [_submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.frame = CGRectMake((kScreenWidth - 185)/2.0, self.agreeBtn.bottom + kMargin15, 185, 40);
        _submitBtn.layer.cornerRadius = 20;
        _submitBtn.layer.masksToBounds = YES;
    }
    return _submitBtn;
}



@end
