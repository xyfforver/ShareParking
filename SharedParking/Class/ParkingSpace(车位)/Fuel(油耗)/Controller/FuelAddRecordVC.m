//
//  FuelAddRecordVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/13.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "FuelAddRecordVC.h"
#import "FuelCounterTBView.h"
#import "FuelModel.h"
@interface FuelAddRecordVC ()
@property (nonatomic , strong) FuelCounterTBView *tbView;
@property (nonatomic , assign) NSInteger page;
@end

@implementation FuelAddRecordVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self loadFuelListData];

}

- (void)initView{
    self.title = @"加油记录";
    self.page = 1;
    
    [self.view addSubview:self.tbView];
}

#pragma mark ---------------NetWork-------------------------/
- (void)loadFuelListData{
    kSelfWeak;
    [WSProgressHUD show];
    [FuelModel fuelRecordListWithPage:self.page success:^(StatusModel *statusModel) {
        kSelfStrong;
        [strongSelf.tbView.mj_header endRefreshing];
        [strongSelf.tbView.mj_footer endRefreshing];
        [WSProgressHUD dismiss];
        if (strongSelf.page == 1) {
            [strongSelf.tbView.dataArr removeAllObjects];
        }
        
        if (statusModel.flag == kFlagSuccess) {
            NSArray *dataArr = statusModel.data;
            if (dataArr.count > 0) {
                [strongSelf.tbView.dataArr addObjectsFromArray:dataArr];
            }
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
        [strongSelf.tbView reloadData];
    }];
}

#pragma mark ---------------Event-------------------------/


#pragma mark ---------------Lazy-------------------------/
- (FuelCounterTBView *)tbView{
    if (!_tbView) {
        _tbView = [[FuelCounterTBView alloc]initWithFrame:CGRectMake(0, kMargin10, kScreenWidth, kBodyHeight - kMargin10) style:UITableViewStylePlain];
        _tbView.type = 1;
        
        kSelfWeak;
        _tbView.mj_header = [JMRefreshHeader headerWithRefreshingBlock:^{
            kSelfStrong;
            strongSelf.page = 1;
            [strongSelf loadFuelListData];
        }];
        _tbView.mj_footer = [JMRefreshFooter footerWithRefreshingBlock:^{
            kSelfStrong;
            strongSelf.page ++;
            [strongSelf loadFuelListData];
        }];
    }
    return _tbView;
}

@end
