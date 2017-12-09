//
//  MyMessageTBView.m
//  SharedParking
//
//  Created by galaxy on 2017/12/9.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "MyMessageTBView.h"
#import "MessageTBCell.h"
@interface MyMessageTBView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MyMessageTBView

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
    self.backgroundColor = kBackGroundGrayColor;
    
    [self registerClass:[MessageTBCell class] forCellReuseIdentifier:@"MessageTBCell"];
    
}

#pragma mark ---------------event ---------------------/

#pragma mark -------------tableView--delegate-------------/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTBCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.messageModel = self.dataArr[indexPath.section];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = kBackGroundGrayColor;
    
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark -----------------Lazy---------------------/
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}


@end
