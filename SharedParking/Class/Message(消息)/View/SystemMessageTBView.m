//
//  SystemMessageTBView.m
//  SharedParking
//
//  Created by galaxy on 2017/12/9.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "SystemMessageTBView.h"
#import "SystemMessageTBCell.h"
#import "MessageModel.h"
@interface SystemMessageTBView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SystemMessageTBView

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
    self.rowHeight = 270;
    self.tableFooterView = [[UIView alloc]init];
    self.backgroundColor = kBackGroundGrayColor;
    self.separatorColor = kBackGroundGrayColor;
    
    [self registerClass:[SystemMessageTBCell class] forCellReuseIdentifier:@"SystemMessageTBCell"];
    
}

#pragma mark ---------------event ---------------------/

#pragma mark -------------tableView--delegate-------------/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
//    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SystemMessageTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SystemMessageTBCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
    MessageModel *model = self.dataArr[indexPath.section];
    
    WKWebViewController *vc = [[WKWebViewController alloc]initWithWebStr:model.url withTitle:@""];
    [self.Controller.navigationController pushViewController:vc animated:YES];
}

#pragma mark -----------------Lazy---------------------/
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}

@end
