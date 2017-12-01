//
//  BindingPlatesVC.m
//  SharedParking
//
//  Created by galaxy on 2017/12/1.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BindingPlatesVC.h"

@interface BindingPlatesVC ()
@property (strong, nonatomic) IBOutlet UITextField *carNumField;
@property (strong, nonatomic) IBOutlet UITextField *engineNumField;
@property (strong, nonatomic) IBOutlet UIButton *saveBtn;


@end

@implementation BindingPlatesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView{
    self.title = @"绑定车牌";
    
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitle:@"以后再说" forState:UIControlStateNormal];
    nextBtn.titleLabel.font = kFontSizeBold16;
    [nextBtn setTitleColor:kColor6B6B6B forState:UIControlStateNormal];
    nextBtn.frame = CGRectMake(0, 0, 70, 20);
    [nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:nextBtn];
    self.navigationItem.rightBarButtonItem = item;
    
}

#pragma mark ---------------event ---------------------/
- (void)nextAction:(UIButton *)button{
    RootViewController *vc = [[RootViewController alloc] init];
    UIApplication.sharedApplication.delegate.window.rootViewController = vc;
}





@end
