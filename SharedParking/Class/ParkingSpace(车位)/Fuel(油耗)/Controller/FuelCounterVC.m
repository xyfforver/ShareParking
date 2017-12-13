//
//  FuelCounterVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/1.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "FuelCounterVC.h"
#import "FuelAverageView.h"
#import "FuelCounterTBView.h"

#import "FuelModel.h"
#import "FuelCounterModel.h"
@interface FuelCounterVC ()
@property (nonatomic , strong) FuelAverageView *averageView;
@property (nonatomic , strong) FuelCounterTBView *tbView;
@end

@implementation FuelCounterVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadData];
}

- (void)initView{
    self.title = @"油耗计算器";
//    self.view.backgroundColor = kBackGroundGrayColor;
    
    [self.view addSubview:self.averageView];
    [self.view addSubview:self.tbView];
}

#pragma mark ---------------NetWork-------------------------/
- (void)loadData{
    [self getAddFuelRecord];
    [self loadFuelListData];
}

- (void)getAddFuelRecord{
    kSelfWeak;
    [FuelCounterModel getAddFuelRecordWithSuccess:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            strongSelf.averageView.fuelModel = statusModel.data;
        }
    }];
}

- (void)loadFuelListData{
    kSelfWeak;
    [FuelModel fuelRecordListWithPage:1 success:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            [strongSelf.tbView.dataArr removeAllObjects];
            NSArray *arr = statusModel.data;
            [strongSelf.tbView.dataArr addObjectsFromArray:arr];
        }
        [strongSelf.tbView reloadData];
    }];
}

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

- (FuelCounterTBView *)tbView{
    if (!_tbView) {
        _tbView = [[FuelCounterTBView alloc]initWithFrame:CGRectMake(0, self.averageView.bottom + kMargin10, kScreenWidth, kBodyHeight - self.averageView.bottom - kMargin10) style:UITableViewStylePlain];
        _tbView.type = 0;
    }
    return _tbView;
}

@end
