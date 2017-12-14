//
//  FuelCounterTBView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/13.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "FuelCounterTBView.h"
#import "FuelCounterTBCell.h"

#import "FuelAddRecordVC.h"
@interface FuelCounterTBView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FuelCounterTBView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    self.delegate = self;
    self.dataSource = self;
    self.rowHeight = 100;
    self.tableFooterView = [[UIView alloc]init];
    self.separatorColor = kColorClear;
    self.backgroundColor = kBackGroundGrayColor;
    [self registerClass:[FuelCounterTBCell class] forCellReuseIdentifier:@"FuelCounterTBCell"];
    
}

#pragma mark ---------------event ---------------------/
- (void)moreAction:(UIButton *)button{
    FuelAddRecordVC *vc = [[FuelAddRecordVC alloc]init];
    [self.Controller.navigationController pushViewController:vc animated:YES];
}


#pragma mark -------------tableView--delegate-------------/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FuelCounterTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FuelCounterTBCell" forIndexPath:indexPath];
    
    cell.fuelModel = self.dataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.type == 0) {
        return 55;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = kBackGroundGrayColor;
    
    if (self.type == 0 && self.dataArr.count > 0) {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
        lineView.backgroundColor = kColorWhite;
        [headerView addSubview:lineView];
        
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin15, kMargin15, 100, 20)];
        titleLab.text = @"加油记录";
        titleLab.textColor = kColor333333;
        titleLab.font = kFontSizeBold14;
        [headerView addSubview:titleLab];
        
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
        [moreBtn setTitleColor:kColorDD9900 forState:UIControlStateNormal];
        [moreBtn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
        moreBtn.titleLabel.font = kFontSize14;
        moreBtn.frame = CGRectMake(kScreenWidth - kMargin15 - 60, titleLab.top, 60, 20);
        [headerView addSubview:moreBtn];
        
        return headerView;
    }
    return headerView;
}
#pragma mark -----------------Lazy---------------------/
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}


@end
