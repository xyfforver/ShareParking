//
//  FKAllOrderViewController.m
//  SharedParking
//
//  Created by 尉超 on 2018/1/16.
//  Copyright © 2018年 galaxy. All rights reserved.
//

#import "FKAllOrderViewController.h"
#import "FKAllOrderHeaderView.h"

@interface FKAllOrderViewController ()<UIScrollViewDelegate>
@property (nonatomic , strong) FKAllOrderHeaderView *headerView;
@property (nonatomic , strong) UIScrollView *scrollView;


@end

@implementation FKAllOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    // Do any additional setup after loading the view.
}


- (void)initView{
    self.title = @"我的订单";
    self.view.backgroundColor = kColorWhite;
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.scrollView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    //加入
//    [self.scrollView addSubview:self.useView];
//    [self.scrollView addSubview:self.commentView];
//    [self.scrollView addSubview:self.refundView];
//    [self.scrollView addSubview:self.allView];
}
#pragma mark ---------------NetWork-------------------------/




#pragma mark ---------------Event-------------------------/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/kScreenWidth;
    
    self.headerView.selectedSegmentIndex = index;
    
   // [self loadData:index];
    
}


#pragma mark ---------------Lazy-------------------------/
- (FKAllOrderHeaderView *)headerView{
    if (!_headerView) {
        NSArray *dataArr = @[@"进行中",@"已完成",@"已取消",@"全部"];
        _headerView = [[FKAllOrderHeaderView alloc]initWithItems:dataArr frame:CGRectMake(0, 0, kScreenWidth,50)];
        _headerView.selectedSegmentIndex = 0;
        kSelfWeak;
        _headerView.IndexChangeBlock = ^(NSInteger index) {
            kSelfStrong;
            [strongSelf.scrollView setContentOffset:CGPointMake(kScreenWidth*index, 0) animated:YES];
        };
    }
    return _headerView;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.headerView.bottom, kScreenWidth, kBodyHeight - self.headerView.height)];
        _scrollView.contentSize = CGSizeMake(kScreenWidth*4, 0);
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.tag = 200;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = kColorLightgrayBackground;
    }
    return _scrollView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
