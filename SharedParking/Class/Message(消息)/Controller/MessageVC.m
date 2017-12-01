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
@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) BaseTBView *tbView;
@property (nonatomic , strong) UIButton *activityBtn;
@end

@implementation MessageVC
#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
}

- (void)initView{
    self.navigationItem.title = @"消息";
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.scrollView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.scrollView addSubview:self.tbView];
    [self.scrollView addSubview:self.activityBtn];
    
}

#pragma mark ---------------event ---------------------/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/kScreenWidth;
    
    self.headerView.selectedSegmentIndex = index;

    
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
        kSelfWeak;
        _headerView.IndexChangeBlock = ^(NSInteger index) {
            kSelfStrong;
            [strongSelf.scrollView setContentOffset:CGPointMake(kScreenWidth*index, 0) animated:YES];
        };
    }
    return _headerView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.headerView.bottom, kScreenWidth, kBodyHeight - self.headerView.height - kTabBarHeight)];
        _scrollView.contentSize = CGSizeMake(kScreenWidth*2, 0);
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.tag = 200;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (BaseTBView *)tbView{
    if (!_tbView) {
        _tbView = [[BaseTBView alloc]initWithFrame:CGRectMake(0, 0, self.scrollView.width, self.scrollView.height) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.rowHeight = 100;
        _tbView.tableFooterView = [[UIView alloc]init];
        _tbView.backgroundColor = kBackGroundGrayColor;
        
        [_tbView registerClass:[MessageTBCell class] forCellReuseIdentifier:@"MessageTBCell"];
    }
    return _tbView;
}

- (UIButton *)activityBtn{
    if (!_activityBtn) {
        _activityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_activityBtn setTitle:@"您还没有收到活动通知哟~" forState:UIControlStateNormal];
        _activityBtn.titleLabel.font = kFontSize15;
        [_activityBtn setTitleColor:kColorC1C1C1 forState:UIControlStateNormal];
        [_activityBtn setImage:[UIImage imageNamed:@"message_null"] forState:UIControlStateNormal];
        _activityBtn.frame = CGRectMake(kScreenWidth, (kBodyHeight - kScreenWidth)/2.0 - 50, kScreenWidth, kScreenWidth);
        [_activityBtn lc_imageTitleVerticalAlignmentWithSpace:35];
        
    }
    return _activityBtn;
}

@end
