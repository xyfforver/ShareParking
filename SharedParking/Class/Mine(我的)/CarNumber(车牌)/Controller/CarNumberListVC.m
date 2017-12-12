//
//  CarNumberListVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/16.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarNumberListVC.h"
#import "CarNumberAddVC.h"
#import "CarNumberListTBCell.h"

#import "CarportShortItemModel.h"
@interface CarNumberListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) BaseTBView *tbView;
@property (nonatomic , strong) NSMutableArray *dataArr;
@end

@implementation CarNumberListVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self loadData];
}

- (void)initView{
    
    self.title = @"车牌管理";
    self.navigationItem.rightBarButtonItem = [[self class] rightBarButtonWithName:@"添加车牌" imageName:nil target:self action:@selector(addAction:)];
    
    [self.view addSubview:self.tbView];
}

#pragma mark ---------------NetWork-------------------------/
- (void)loadData{
    kSelfWeak;
    [CarportShortItemModel carNumberListWithSuccess:^(StatusModel *statusModel) {
        kSelfStrong;
        [strongSelf.tbView.mj_header endRefreshing];
        [strongSelf.tbView.mj_footer endRefreshing];

        [strongSelf.dataArr removeAllObjects];
        
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
- (void)addAction:(UIButton *)button{
    CarNumberAddVC *vc = [[CarNumberAddVC alloc]initWithType:1];
    kSelfWeak;
    vc.loadBlock = ^{
        kSelfStrong;
        [strongSelf.tbView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -------------tableView--delegate-------------/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CarNumberListTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CarNumberListTBCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.itemModel = self.dataArr[indexPath.row];
    kSelfWeak;
    cell.loadBlock = ^{
        kSelfStrong;
        [strongSelf.tbView.mj_header beginRefreshing];
    };
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectBlock) {
        CarportShortItemModel *model = self.dataArr[indexPath.row];
        self.selectBlock(model.car_chepai, model.car_fadongji);
        
        [self backToSuperView];
    }
}


#pragma mark ---------------Lazy-------------------------/
- (BaseTBView *)tbView{
    if(!_tbView){
        _tbView = [[BaseTBView alloc]initWithFrame:kScreenRect style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.rowHeight = 175;
        
        _tbView.separatorColor = kBackGroundGrayColor;
        _tbView.backgroundColor = kBackGroundGrayColor;
        
        [_tbView registerClass:[CarNumberListTBCell class] forCellReuseIdentifier:@"CarNumberListTBCell"];
        
        kSelfWeak;
        _tbView.mj_header = [JMRefreshHeader headerWithRefreshingBlock:^{
            kSelfStrong;
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
