//
//  MyReserveVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/10.
//  Copyright © 2017年 galaxy. All rights reserved.
//
//---------------------------我的预订----------------------//
#import "MyReserveVC.h"
#import "MyRequestRentHeadView.h"
#import "MyReserveTBView.h"

#import "MyReserveModel.h"
@interface MyReserveVC ()
@property (nonatomic , strong) MyRequestRentHeadView *headView;
@property (nonatomic , strong) MyReserveTBView *tbView;
@property (nonatomic , assign) NSInteger page;
@end

@implementation MyReserveVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self loadData];
}

- (void)initView{
    self.title = @"我的预订";
    self.page = 1;
    
//    [self.view addSubview:self.headView];
    
    [self.view addSubview:self.tbView];
}

#pragma mark ---------------NetWork-------------------------/
- (void)loadData{
    
    kSelfWeak;
    [MyReserveModel myReserveWithPage:self.page success:^(StatusModel *statusModel) {
        kSelfStrong;
        [strongSelf.tbView.mj_header endRefreshing];
        [strongSelf.tbView.mj_footer endRefreshing];
        
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
- (MyRequestRentHeadView *)headView{
    if (!_headView) {
        _headView = [[MyRequestRentHeadView alloc]initWithType:JMHeaderReserveParkingSpaceType frame:CGRectMake(0, 0, kScreenWidth, [MyRequestRentHeadView getHeight])];
    }
    return _headView;
}

- (MyReserveTBView *)tbView{
    if (!_tbView) {
        _tbView = [[MyReserveTBView alloc]initWithFrame:kScreenRect style:UITableViewStylePlain];
        
        kSelfWeak;
        _tbView.mj_header = [JMRefreshHeader headerWithRefreshingBlock:^{
            kSelfStrong;
            strongSelf.page = 1;
            [strongSelf loadData];
        }];
        _tbView.mj_footer = [JMRefreshFooter footerWithRefreshingBlock:^{
            kSelfStrong;
            strongSelf.page ++;
            [strongSelf loadData];
        }];
    }
    return _tbView;
}

@end
