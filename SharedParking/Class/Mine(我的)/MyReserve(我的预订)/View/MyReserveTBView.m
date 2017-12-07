//
//  MyReserveTBView.m
//  SharedParking
//
//  Created by galaxy on 2017/12/7.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "MyReserveTBView.h"
#import "MyReserveTBCell.h"
@interface MyReserveTBView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MyReserveTBView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    self.dataSource = self;
    self.delegate = self;
    self.rowHeight = [MyReserveTBCell getHeight];
    self.separatorColor = kBackGroundGrayColor;
    self.backgroundColor = kBackGroundGrayColor;
    
    [self registerClass:[MyReserveTBCell class] forCellReuseIdentifier:@"MyReserveTBCell"];
}


#pragma mark -------------tableView--delegate-------------/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyReserveTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyReserveTBCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.reserveModel = self.dataArr[indexPath.row];
    kSelfWeak;
    cell.reloadBlock = ^{
        kSelfStrong;
        [strongSelf.mj_header beginRefreshing];
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark ---------------lazy ---------------------/
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
@end
