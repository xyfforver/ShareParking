//
//  MessageVC.m
//  SharedParking
//
//  Created by galaxy on 2017/10/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "MessageVC.h"
#import "MessageHeaderView.h"
#import "MyMessageTBView.h"
#import "SystemMessageTBView.h"

#import "MessageModel.h"
@interface MessageVC ()<UIScrollViewDelegate>
@property (nonatomic , strong) MessageHeaderView *headerView;
@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) MyMessageTBView *myTbView;
@property (nonatomic , strong) SystemMessageTBView *systemTBView;

@end

@implementation MessageVC
#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self loadData];
    [self loadSystemData];
    
}

- (void)initView{
    self.navigationItem.title = @"消息";
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.scrollView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.scrollView addSubview:self.myTbView];
    [self.scrollView addSubview:self.systemTBView];
    
}

#pragma mark ---------------network ---------------------/
- (void)loadData{
    kSelfWeak;
    [MessageModel myMessageWithPage:self.myTbView.page success:^(StatusModel *statusModel) {
        kSelfStrong;
        [strongSelf.myTbView.mj_header endRefreshing];
        [strongSelf.myTbView.mj_footer endRefreshing];
        
        if (strongSelf.myTbView.page == 1) {
            [strongSelf.myTbView.dataArr removeAllObjects];
        }
        
        if (statusModel.flag == kFlagSuccess) {
            NSArray *dataArr = statusModel.data;
            if (dataArr.count > 0) {
                [strongSelf.myTbView.dataArr addObjectsFromArray:dataArr];
            }
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
        [strongSelf.myTbView reloadData];
    }];
}

- (void)loadSystemData{
    kSelfWeak;
    [MessageModel systemMessageWithPage:self.systemTBView.page success:^(StatusModel *statusModel) {
        kSelfStrong;
        [strongSelf.systemTBView.mj_header endRefreshing];
        [strongSelf.systemTBView.mj_footer endRefreshing];
        
        if (strongSelf.systemTBView.page == 1) {
            [strongSelf.systemTBView.dataArr removeAllObjects];
        }
        
        if (statusModel.flag == kFlagSuccess) {
            NSArray *dataArr = statusModel.data;
            if (dataArr.count > 0) {
                [strongSelf.systemTBView.dataArr addObjectsFromArray:dataArr];
            }
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
        [strongSelf.systemTBView reloadData];
    }];
}

#pragma mark ---------------event ---------------------/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/kScreenWidth;
    
    self.headerView.selectedSegmentIndex = index;

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

- (MyMessageTBView *)myTbView{
    if (!_myTbView) {
        _myTbView = [[MyMessageTBView alloc]initWithFrame:CGRectMake(0, 0, self.scrollView.width, self.scrollView.height) style:UITableViewStylePlain];

        kSelfWeak;
        _myTbView.mj_header = [JMRefreshHeader headerWithRefreshingBlock:^{
            kSelfStrong;
            strongSelf.myTbView.page = 1;
            [strongSelf loadData];
        }];
        _myTbView.mj_footer = [JMRefreshFooter footerWithRefreshingBlock:^{
            kSelfStrong;
            strongSelf.myTbView.page ++;
            [strongSelf loadData];
        }];
    }
    return _myTbView;
}

- (SystemMessageTBView *)systemTBView{
    if (!_systemTBView) {
        _systemTBView = [[SystemMessageTBView alloc]initWithFrame:CGRectMake(self.scrollView.width, 0, self.scrollView.width, self.scrollView.height) style:UITableViewStylePlain];
        
        kSelfWeak;
        _systemTBView.mj_header = [JMRefreshHeader headerWithRefreshingBlock:^{
            kSelfStrong;
            strongSelf.systemTBView.page = 1;
            [strongSelf loadData];
        }];
        _systemTBView.mj_footer = [JMRefreshFooter footerWithRefreshingBlock:^{
            kSelfStrong;
            strongSelf.systemTBView.page ++;
            [strongSelf loadData];
        }];
    }
    return _systemTBView;
}

@end
