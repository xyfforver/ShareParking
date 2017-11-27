//
//  PayRecordVC.m
//  yimaxingtianxia
//
//  Created by galaxy on 2017/9/8.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import "PayRecordVC.h"
#import "BaseTBView.h"
#import "PayRecordTBCell.h"
#import "PayRecordHeaderView.h"
#import "QFDatePickerView.h"
#import "PayRecordScreenView.h"

#import "PayRecordGroupModel.h"
#import "PayRecordModel.h"
@interface PayRecordVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) BaseTBView *tbView;
@property (nonatomic , strong) NSMutableArray *dataArr;
@property (nonatomic , assign) NSInteger page;
@property (nonatomic , assign) NSInteger type;
@property (nonatomic , copy) NSString *timeStr;

@end

@implementation PayRecordVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
//    [self loadData];
}

- (void)initView{
    self.title = @"支付明细";
    self.page = 1;
    self.type = 5;
    self.timeStr = @"";
    
    self.navigationItem.rightBarButtonItem = [[self class] rightBarButtonWithName:@"筛选" imageName:nil target:self action:@selector(screenAction)];
    
    [self.view addSubview:self.tbView];
}

#pragma mark ---------------NetWork-------------------------/
- (void)loadData{
    kSelfWeak;
    [PayRecordModel getPayRecordListWithAddTime:self.timeStr type:self.type page:self.page success:^(StatusModel *statusModel) {
        kSelfStrong;
        [strongSelf.tbView.mj_header endRefreshing];
        [strongSelf.tbView.mj_footer endRefreshing];
        if (strongSelf.page == 1) [strongSelf.dataArr removeAllObjects];
        
        if (statusModel.flag == kFlagSuccess) {
            StatusRecordListModel *model = statusModel.data;
            if (model.list.count > 0) {
                for (PayRecordModel *itemModel in model.list) {
                    NSString *addTime = itemModel.addtime;
                    if (addTime.length > 8) {
                        NSInteger year = [[addTime substringWithRange:NSMakeRange(0,4)] integerValue];
                        NSInteger month = [[addTime substringWithRange:NSMakeRange(5,2)] integerValue];
//                        DLog(@"%ld年%ld月",year,month);
                        
                        NSInteger count = 0;//标记
                        for (int i = 0; i < strongSelf.dataArr.count;i++) {
                            PayRecordGroupModel *groupModel = strongSelf.dataArr[i];
                            if (groupModel.year == year && groupModel.month == month) {
                                NSMutableArray *arr = [NSMutableArray array];
                                [arr addObjectsFromArray:groupModel.list];
                                [arr addObject:itemModel];
                                groupModel.list = arr;
                                [strongSelf.dataArr replaceObjectAtIndex:i withObject:groupModel];
                                count = 1;
                                break;
                            }
                        }
                        if (count == 0) {
                            PayRecordGroupModel *model = [[PayRecordGroupModel alloc]init];
                            model.year = year;
                            model.month = month;
                            NSMutableArray *arr = [[NSMutableArray alloc]init];
                            [arr addObject:itemModel];
                            model.list = arr;
                            model.sprice = itemModel.sprice;
                            model.zprice = itemModel.zprice;
                            [strongSelf.dataArr addObject:model];
                        }
                    }
                }
            }
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
        [strongSelf.tbView reloadData];
    }];
}


#pragma mark ---------------Event-------------------------/
- (void)screenAction{
    PayRecordScreenView *view = [[PayRecordScreenView alloc]initWithType:self.type Confirm:^(NSInteger selectCount) {
        self.type = selectCount;
        if (self.type == 5) {
            self.timeStr = @"";
        }
        self.page = 1;
        [self.tbView.mj_header beginRefreshing];
    }];
    [view show];
    
}

- (void)selectDate{
    QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initDatePackerWithResponse:^(NSString *dateStr) {
        NSString *string = dateStr;
        if ([string isEqualToString:@"至今"]) {
            string = @"";
        }
        self.timeStr = string;
        self.page = 1;
        [self.tbView.mj_header beginRefreshing];
        NSLog(@"str = %@",string);
    }];
    [datePickerView show];
}


#pragma mark -------------tableView--delegate-------------/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PayRecordGroupModel *model = self.dataArr[section];
    return model.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    PayRecordHeaderView *headerView = [[PayRecordHeaderView alloc]init];
    headerView.groupModel = self.dataArr[section];
    [headerView zzh_addTapGestureWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self selectDate];
    }];
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PayRecordTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayRecordTBCell" forIndexPath:indexPath];
    PayRecordGroupModel *model = self.dataArr[indexPath.section];
    cell.model = model.list[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark ---------------Lazy-------------------------/
- (BaseTBView *)tbView{
    if (!_tbView) {
        _tbView = [[BaseTBView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kBodyHeight) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.tableFooterView = [[UIView alloc]init];
        _tbView.rowHeight = 60;
        _tbView.separatorColor = kBackGroundGrayColor;
        _tbView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        [_tbView registerClass:[PayRecordTBCell class] forCellReuseIdentifier:@"PayRecordTBCell"];
        
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
        _tbView.reloadDataBlock = ^{
            kSelfStrong;
            strongSelf.page = 1;
            strongSelf.timeStr = @"";
            strongSelf.type = 5;
            [strongSelf loadData];
        };
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
