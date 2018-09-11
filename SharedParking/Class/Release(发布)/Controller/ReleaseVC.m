//
//  ReleaseVC.m
//  SharedParking
//
//  Created by galaxy on 2017/10/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ReleaseVC.h"
#import "JMTitleSelectView.h"
#import "ReleaseDetailView.h"
#import "ReleaseLongView.h"
@interface ReleaseVC ()<UIScrollViewDelegate>
@property (nonatomic , strong) JMTitleSelectView *titleView;
@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) ReleaseDetailView *shortView;
@property (nonatomic , strong) ReleaseLongView *rentView;

@end

@implementation ReleaseVC
#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
}
//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
//}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self.shortView endEditing:YES];
}
- (void)initView{
    
    self.navigationItem.titleView = self.titleView;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.shortView];
    [self.scrollView addSubview:self.rentView];

}

#pragma mark ---------------Event-------------------------/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/kScreenWidth;
    
    self.titleView.selectedSegmentIndex = index;
    
    
}


#pragma mark ---------------lazy ---------------------/
- (JMTitleSelectView *)titleView{
    if (!_titleView) {
        _titleView = [[JMTitleSelectView alloc]init];
        _titleView.selectedSegmentIndex = 0;
        kSelfWeak;
        _titleView.IndexChangeBlock = ^(NSInteger index) {
            kSelfStrong;
            [strongSelf.scrollView setContentOffset:CGPointMake(kScreenWidth*index, 0) animated:YES];
        };
    }
    return _titleView;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kBodyHeight)];
        _scrollView.contentSize = CGSizeMake(kScreenWidth*2, 0);
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (ReleaseDetailView *)shortView{
    if (!_shortView) {
        _shortView = [[[NSBundle mainBundle] loadNibNamed:@"ReleaseDetailView" owner:nil options:nil] lastObject];
        _shortView.frame = CGRectMake(0, 0, self.scrollView.width, self.scrollView.height);
    }
    return _shortView;
}

- (ReleaseLongView *)rentView{
    if (!_rentView) {
        _rentView = [[[NSBundle mainBundle] loadNibNamed:@"ReleaseLongView" owner:nil options:nil] lastObject];
        _rentView.frame = CGRectMake(kScreenWidth, 0, self.scrollView.width, self.scrollView.height);
    }
    return _rentView;
}
@end
