//
//  FeedbackVC.m
//  yimaxingtianxia
//
//  Created by lingbao on 2017/6/2.
//  Copyright © 2017年 lingbao. All rights reserved.
//
#define kMaxLength 100
#import "FeedbackVC.h"
@interface FeedbackVC ()<UIScrollViewDelegate>
@property (nonatomic , strong) UIView *bgView;
@property (nonatomic , strong) UITextView *textView;
@property (nonatomic , strong) UIButton *submitBtn;

@end

@implementation FeedbackVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)loadView
{
    [super loadView];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.alwaysBounceVertical = YES;
    scrollView.delegate = self;
    self.view = scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView{
    self.title = @"意见反馈";

    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.textView];
    [self.view addSubview:self.submitBtn];

}

#pragma mark ---------------Event-------------------------/
- (void)submitAction{
    if ([NSString isNull:self.textView.text]) {
        [WSProgressHUD showImage:nil status:@"请填写反馈信息"];
        return;
    }
    
    kSelfWeak;
    [UserModel feedbackWithContent:self.textView.text success:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            [WSProgressHUD showImage:nil status:@"提交成功"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [strongSelf backToSuperView];
            });
        }else{
            [WSProgressHUD showImage:nil status:@"提交失败"];
        }
    }];
}

#pragma mark ---------------Lazy-------------------------/
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(kMargin15, kMargin15, kScreenWidth - kMargin15 * 2, 145)];
        _bgView.backgroundColor = kColorWhite;
        _bgView.layer.cornerRadius = 5;
    }
    return _bgView;
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(kMargin15, 5, self.bgView.width - 2 * kMargin15, self.bgView.height - 2 * 5)];
//        _textView.delegate = self;
        _textView.placeholder = @"请填写您的建议，帮助我们成长";
        _textView.textColor = kColor333333;
        _textView.font = kFontSize14;
    }
    return _textView;
}

- (UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = kFontSize15;
        [_submitBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_submitBtn setBackgroundColor:kNavBarColor];
        [_submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
        
        _submitBtn.layer.cornerRadius = 20;
        _submitBtn.frame = CGRectMake((kScreenWidth - 185)/2.0, self.bgView.bottom + 30, 185, 40);
    }
    return _submitBtn;
}

@end
