//
//  FuelCounterVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/1.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "FuelCounterVC.h"
#import "FuelAverageView.h"
@interface FuelCounterVC ()
@property (nonatomic , strong) FuelAverageView *averageView;
@end

@implementation FuelCounterVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];

}

- (void)initView{
    self.title = @"油耗计算器";
    self.view.backgroundColor = kBackGroundGrayColor;
    
    [self.view addSubview:self.averageView];
}

#pragma mark ---------------NetWork-------------------------/


#pragma mark ---------------Event-------------------------/


#pragma mark ---------------Lazy-------------------------/
- (FuelAverageView *)averageView{
    if (!_averageView) {
        _averageView = [[[NSBundle mainBundle] loadNibNamed:@"FuelAverageView" owner:nil options:nil] lastObject];
        _averageView.frame = CGRectMake( 0, 10, kScreenWidth, 300);
//        _averageView.backgroundColor = kColorWhite;
    }
    return _averageView;
}

@end
