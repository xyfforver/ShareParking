//
//  ParkingRecordVC.m
//  SharedParking
//
//  Created by galaxy on 2017/10/26.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ParkingRecordVC.h"
#import "BaseTBView.h"
#import "ParkingRecordTBCell.h"

#import "ParkingRecordModel.h"
@interface ParkingRecordVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) BaseTBView *tbView;
@property (nonatomic , strong) NSMutableArray *dataArr;
@property (nonatomic , assign) NSInteger page;

@end

@implementation ParkingRecordVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self loadData];
}

- (void)initView{
    self.title = @"停车记录";
    self.view.backgroundColor = kBackGroundGrayColor;
    self.page = 1;
    
    [self.view addSubview:self.tbView];
}

#pragma mark ---------------NetWork-------------------------/
- (void)loadData{
    kSelfWeak;
    [ParkingRecordModel parkingRecordWithPage:self.page success:^(StatusModel *statusModel) {
        kSelfStrong;
        [strongSelf.tbView.mj_header endRefreshing];
        [strongSelf.tbView.mj_footer endRefreshing];
        
        if (strongSelf.page == 1) {
            [strongSelf.dataArr removeAllObjects];
        }

        if (statusModel.flag == kFlagSuccess) {
            NSArray *dataArr = statusModel.data;
            if (dataArr.count > 0) {
                [strongSelf.dataArr addObjectsFromArray:dataArr];
            }
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
        [strongSelf.tbView reloadData];
    }];
}

#pragma mark ---------------Event-------------------------/


#pragma mark -------------tableView--delegate-------------/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ParkingRecordTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ParkingRecordTBCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.recordModel = self.dataArr[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark ---------------Lazy-------------------------/

- (BaseTBView *)tbView{
    if (!_tbView) {
        _tbView = [[BaseTBView alloc]initWithFrame:kScreenRect style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.showsVerticalScrollIndicator = NO;
        _tbView.rowHeight = 120;
        _tbView.backgroundColor = kBackGroundGrayColor;
        _tbView.separatorColor = kColorClear;
        _tbView.tableFooterView = [UIView new];
        _tbView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 15)];
        
        if (@available(iOS 9.0, *)) {
            _tbView.cellLayoutMarginsFollowReadableWidth = NO;
        }

        [_tbView registerClass:[ParkingRecordTBCell class] forCellReuseIdentifier:@"ParkingRecordTBCell"];
        
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

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
@end
