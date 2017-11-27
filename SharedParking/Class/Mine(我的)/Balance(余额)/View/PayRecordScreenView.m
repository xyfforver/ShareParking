//
//  PayRecordScreenView.m
//  yimaxingtianxia
//
//  Created by galaxy on 2017/9/26.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import "PayRecordScreenView.h"
@interface PayRecordScreenView()<UIGestureRecognizerDelegate>
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UIView *bgView;
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic , strong) UIButton *selectedBtn;

@end
@implementation PayRecordScreenView

- (instancetype)initWithType:(NSInteger )type Confirm:(ScreenBlock )selectConfirm{
    
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _type = type;
        _selectConfirm = [selectConfirm copy];
        [self initView];
    }
    return self;
}

- (void)initView
{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    
    tap.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tap];
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.titleLab];
    [self.bgView addSubview:self.cancleBtn];
    
    self.bgView.frame = CGRectMake(0, kScreenHeight - 300, kScreenWidth, 300);
    self.titleLab.frame = CGRectMake(0, 0, self.bgView.width, 70);
    self.cancleBtn.frame = CGRectMake(0, self.bgView.height - 50, self.bgView.width, 50);
    NSArray *titleArr = @[@"充值入账",@"账户提现",@"消费",@"退款",@"全部"];
    
    CGFloat top = 0;
    CGFloat left = 10;
    CGFloat itemWidth = (self.bgView.width - 4 * left)/3.0;
    CGFloat itemHeight = 60;
    CGFloat count = 0;
    for (int i = 0; i < titleArr.count; i++) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        [item setBackgroundImage:[UIImage createImageWithColor:kColorWhite] forState:UIControlStateNormal];
        [item setBackgroundImage:[UIImage createImageWithColor:kNavBarColor] forState:UIControlStateSelected];
        [item setTitleColor:kColor333333 forState:UIControlStateNormal];
        [item setTitleColor:kColorWhite forState:UIControlStateSelected];
        [item addTarget:self action:@selector(selectItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [item setTitle:titleArr[i] forState:UIControlStateNormal];
        item.titleLabel.font = kFontSize14;
        item.tag = 101 + i;
        count = i;
        top = 80;
        
        if (i + 1 == self.type) {
            item.selected = YES;
            self.selectedBtn = item;
        }
        
        if (i >= 3) {
            top += itemHeight + left;
            count = i - 3;
        }
        item.frame = CGRectMake(left + (left + itemWidth)* count, top, itemWidth, itemHeight);
        [self.bgView addSubview:item];
    }
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.cancleBtn.top - 10, self.bgView.width, 10)];
    lineView.backgroundColor = kBackGroundGrayColor;
    [self.bgView addSubview:lineView];
    
}

#pragma mark - Master show/dismiss methods
- (void)show
{
    if(!self.superview){
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows){
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
            BOOL windowHasSubviews = window.subviews.count != 0;
            if (windowOnMainScreen && windowIsVisible && windowLevelNormal && windowHasSubviews) {
                [window addSubview:self];
                break;
            }
        }
    } else {
        [self.superview bringSubviewToFront:self];
    }
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (void)cancleBtnClick
{
    [self dismiss];
}

- (void)tapGesture:(UITapGestureRecognizer *)tapGesture
{
    CGPoint tapPointInBgView = [tapGesture locationInView:self];
    CGRect collectionViewRect = self.bgView.frame;
    
    if (!CGRectContainsPoint(collectionViewRect, tapPointInBgView)) {

        [self dismiss];
    }
}

- (void)selectItemAction:(UIButton *)button{
    self.selectedBtn.selected = NO;
    
    //改变现状按钮颜色
    button.selected = YES;
    self.selectedBtn = button;
    
    if(self.selectConfirm){
        self.selectConfirm(button.tag - 100);
    }
    
    [self dismiss];
}

#pragma mark - Getters
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = kColorf4f4f4;
    }
    return _bgView;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSizeBold16;
        _titleLab.textColor = kColor333333;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.text = @"选择交易类型";
    }
    return _titleLab;
}

- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = kFontSizeBold15;
        [_cancleBtn setTitleColor:kColor6B6B6B forState:UIControlStateNormal];
        _cancleBtn.backgroundColor = kColorWhite;
        [_cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

@end
