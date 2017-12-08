//
//  MyRequestRentHeadView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/9.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "MyRequestRentHeadView.h"
#import "RequestCarportVC.h"
@interface MyRequestRentHeadView ()
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UIButton *requestBtn;
@end

@implementation MyRequestRentHeadView

- (instancetype)initWithType:(JMHeaderType)type frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        
        [self initView];
        
    }
    return self;
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    [self addSubview:self.titleLab];
    [self addSubview:self.requestBtn];
    
    self.titleLab.frame = CGRectMake(kMargin15, 75, self.width - kMargin15 * 2, 20);
    self.requestBtn.frame = CGRectMake((self.width - 190) / 2.0, self.titleLab.bottom + 30, 190, 40);
    
    
    if (self.type == JMHeaderRequestRentType) {
        self.titleLab.text = @"当前没有您的求租车位信息";
        [self.requestBtn setTitle:@"求租车位" forState:UIControlStateNormal];
    }else if (self.type == JMHeaderReserveParkingSpaceType){
        self.titleLab.text = @"当前没有您的预订信息";
        [self.requestBtn setTitle:@"去预订" forState:UIControlStateNormal];
    }
}

#pragma mark ---------------event ---------------------/
- (void)requestAction:(UIButton *)button{
    if (self.type == JMHeaderRequestRentType) {
        RequestCarportVC *vc = [[RequestCarportVC alloc]init];
        kSelfWeak;
        vc.reloadBlock = ^{
            kSelfStrong;
            if (strongSelf.reloadBlock) {
                strongSelf.reloadBlock();
            }
        };
        [self.Controller.navigationController pushViewController:vc animated:YES];
    }else if (self.type == JMHeaderReserveParkingSpaceType){

    }
}

#pragma mark -----------------Lazy---------------------/
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSize14;
        _titleLab.textColor = kColor6B6B6B;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        
    }
    return _titleLab;
}

- (UIButton *)requestBtn{
    if (!_requestBtn) {
        _requestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _requestBtn.titleLabel.font = kFontSizeBold15;
        [_requestBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_requestBtn setBackgroundColor:kNavBarColor];
        [_requestBtn addTarget:self action:@selector(requestAction:) forControlEvents:UIControlEventTouchUpInside];
        _requestBtn.layer.cornerRadius = 20;
        _requestBtn.layer.masksToBounds = YES;
    }
    return _requestBtn;
}

+ (CGFloat)getHeight{
    return 200;
}
@end
