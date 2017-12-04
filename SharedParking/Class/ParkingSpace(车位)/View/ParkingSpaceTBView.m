//
//  ParkingSpaceTBView.m
//  SharedParking
//
//  Created by galaxy on 2017/10/28.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ParkingSpaceTBView.h"
#import "ParkingSpaceTBCell.h"
#import "CarportDetailVC.h"

#import "CarportShortListModel.h"
#import "CarportLongListModel.h"
@interface ParkingSpaceTBView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ParkingSpaceTBView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    [self registerClass:[ParkingSpaceTBCell class] forCellReuseIdentifier:@"ParkingSpaceTBCell"];
    self.delegate = self;
    self.dataSource = self;
    self.tableFooterView = [UIView new];
    self.separatorColor = kColorC1C1C1;
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark -------------tableView--delegate-------------/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 10;
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ParkingSpaceTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ParkingSpaceTBCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.type == CarportShortRentType) {
        cell.shortModel = self.dataArr[indexPath.row];
    }else{
        cell.longModel = self.dataArr[indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *carportId = nil;
    if (self.type == CarportShortRentType) {
        CarportShortListModel *model = self.dataArr[indexPath.row];
        carportId = model.id;
    }else{
        CarportLongListModel *model = self.dataArr[indexPath.row];
        carportId = model.id;
    }
    
    CarportDetailVC *vc = [[CarportDetailVC alloc]initWithCarportId:carportId type:self.type];
    [self.Controller.navigationController pushViewController:vc animated:YES];
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}



@end
