//
//  CarNumberAddVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/16.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarNumberAddVC.h"
#import "JMTitleTextfieldView.h"
#import "WTCarKeyboard.h"
#import "CarportShortItemModel.h"
@interface CarNumberAddVC ()<WTCarKeyboardDelegate>
@property (nonatomic , strong) JMTitleTextfieldView *carNumView;
@property (nonatomic , strong) JMTitleTextfieldView *endNumView;
@property (nonatomic , strong) UIButton *saveBtn;
@end

@implementation CarNumberAddVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];

}

- (void)initView{
    self.title = @"添加车牌";
    
    [self.view addSubview:self.carNumView];
    [self.view addSubview:self.endNumView];
    [self.view addSubview:self.saveBtn];
}

#pragma mark ---------------NetWork-------------------------/
- (void)addCarNumData{
    kSelfWeak;
    [CarportShortItemModel addCarNumberWithNum:self.carNumView.textField.text endNum:self.endNumView.textField.text success:^(StatusModel *statusModel) {
        kSelfStrong;
        [WSProgressHUD showImage:nil status:statusModel.message];
        
        if (statusModel.flag == kFlagSuccess) {
            if (strongSelf.loadBlock) {
                strongSelf.loadBlock();
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [strongSelf backToSuperView];
                });
            }
        }
    }];
}

#pragma mark ---------------Event-------------------------/
- (void)saveAction:(UIButton *)button{
    if (self.carNumView.textField.text.length < 4) {
        [WSProgressHUD showImage:nil status:@"请输入正确的车牌号码"];
        return;
    }
    
    if (self.endNumView.textField.text.length > 0) {
        if(self.endNumView.textField.text.length != 6){
            [WSProgressHUD showImage:nil status:@"请输入正确的发动机尾号"];
            return;            
        }
    }
    
    [self addCarNumData];
}
#pragma mark ---------------WTCarKeyboardDelegate ---------------------/
- (void)carKeyboard:(WTCarKeyboard *)carKeyboard didChangeWithText:(NSString *)textStr;
{
    NSLog(@"%@",textStr);
}

#pragma mark ---------------Lazy-------------------------/
- (JMTitleTextfieldView *)carNumView{
    if (!_carNumView) {
        _carNumView = [[JMTitleTextfieldView alloc]initWithFrame:CGRectMake(kMargin15, kMargin15, kScreenWidth - kMargin15 * 2, 45)];
        _carNumView.layer.cornerRadius = 3;
        _carNumView.layer.masksToBounds = YES;
        _carNumView.backgroundColor = kColorWhite;
        _carNumView.titleLab.text = @"车牌号码：";
        WTCarKeyboard* carKeyboard = [WTCarKeyboard new];
        carKeyboard.delegate = self;
        carKeyboard.inputBlock = ^(NSString* textStr)
        {
            NSLog(@"%@",textStr);
        };
        _carNumView.textField.inputView = carKeyboard;
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
        _endNumView.textField.placeholder = @"选填";
    }
    return _endNumView;
}

- (UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = kFontSizeBold15;
        [_saveBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_saveBtn setBackgroundColor:kNavBarColor];
        [_saveBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.frame = CGRectMake((kScreenWidth - 185)/2.0, self.endNumView.bottom + 30, 185, 40);
        _saveBtn.layer.cornerRadius = 20;
        _saveBtn.layer.masksToBounds = YES;
    }
    return _saveBtn;
}




@end
