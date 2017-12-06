//
//  SearchResultVC.m
//  SharedParking
//
//  Created by galaxy on 2017/12/5.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "SearchResultVC.h"
#import "CarportShortListModel.h"
#import "ParkingSpaceTBView.h"
@interface SearchResultVC ()
@property (nonatomic , strong) ParkingSpaceTBView *tbView;

@property (nonatomic , assign) NSInteger page;
@end

@implementation SearchResultVC

#pragma mark ---------------LifeCycle-------------------------/
- (instancetype)initWithSearchStr:(NSString *)searchStr{
    self = [super init];
    if (self) {
        self.searchStr = searchStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self loadData];
}

- (void)initView{
    
    self.title = self.searchStr;
    self.page = 1;
    
    [self.view addSubview:self.tbView];
}

#pragma mark ---------------NetWork-------------------------/
- (void)loadData{
    kSelfWeak;
    [CarportShortListModel searchWithTitle:self.searchStr success:^(StatusModel *statusModel) {
        kSelfStrong;
        [strongSelf.tbView.mj_header endRefreshing];
        [strongSelf.tbView.mj_footer endRefreshing];
        
        strongSelf.tbView.type = CarportShortRentType;
        
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
- (ParkingSpaceTBView *)tbView{
    if (!_tbView) {
        _tbView = [[ParkingSpaceTBView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kBodyHeight) style:UITableViewStylePlain];
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
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
