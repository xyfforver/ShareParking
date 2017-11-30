//
//  MessageVC.m
//  SharedParking
//
//  Created by galaxy on 2017/10/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "MessageVC.h"
#import "MessageHeaderView.h"
#import "BaseTBView.h"
#import "MessageTBCell.h"

@interface MessageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) MessageHeaderView *headerView;
@property (nonatomic , strong) BaseTBView *tbView;
@end

@implementation MessageVC
#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
}

- (void)initView{
    self.navigationItem.title = @"消息";
    self.view.backgroundColor = kColorRandom;
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tbView];
    
}



#pragma mark -------------tableView--delegate-------------/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTBCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
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


#pragma mark ---------------lazy ---------------------/
- (MessageHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[MessageHeaderView alloc]initWithItems:@[@"个人消息",@"活动通知"] frame:CGRectMake(0, 0, kScreenWidth, [MessageHeaderView defaultHeight])];
        _headerView.selectedSegmentIndex = 0;
        _headerView.IndexChangeBlock = ^(NSInteger index) {
            
        };
    }
    return _headerView;
}

- (BaseTBView *)tbView{
    if (!_tbView) {
        _tbView = [[BaseTBView alloc]initWithFrame:CGRectMake(0, self.headerView.bottom, kScreenWidth, kBodyHeight - self.headerView.height - kTabBarHeight) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.rowHeight = 100;
        _tbView.tableFooterView = [[UIView alloc]init];
        _tbView.backgroundColor = kBackGroundGrayColor;
        
        [_tbView registerClass:[MessageTBCell class] forCellReuseIdentifier:@"MessageTBCell"];
    }
    return _tbView;
    return _tbView;
}
@end
