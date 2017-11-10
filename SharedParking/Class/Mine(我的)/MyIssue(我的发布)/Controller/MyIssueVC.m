//
//  MyIssueVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/10.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "MyIssueVC.h"
#import "BaseTBView.h"
#import "MyIssueTBCell.h"
@interface MyIssueVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) BaseTBView *tbView;
@end

@implementation MyIssueVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];

}

- (void)initView{
    self.title = @"我的发布";
    
    [self.view addSubview:self.tbView];
}

#pragma mark ---------------NetWork-------------------------/


#pragma mark ---------------Event-------------------------/


#pragma mark -------------tableView--delegate-------------/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyIssueTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIssueTBCell" forIndexPath:indexPath];
    
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
        _tbView.tableFooterView = [[UIView alloc]init];
        _tbView.separatorColor = kColorClear;
        _tbView.rowHeight = [MyIssueTBCell getHeight];
        _tbView.backgroundColor = kBackGroundGrayColor;
        
        [_tbView registerClass:[MyIssueTBCell class] forCellReuseIdentifier:@"MyIssueTBCell"];
    }
    return _tbView;
}


@end
