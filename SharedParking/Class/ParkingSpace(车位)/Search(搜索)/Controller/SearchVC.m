//
//  SearchVC.m
//  SharedParking
//
//  Created by galaxy on 2017/10/31.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "SearchVC.h"
#import "SearchHistoryView.h"
#import "SearchModel.h"

@interface SearchVC ()<UISearchBarDelegate>
@property (nonatomic,strong) UIView *navigationBar;
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UIButton *cancelBtn;

@property (nonatomic,strong) SearchHistoryView *historyView;



@end

@implementation SearchVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    [self loadData];
}

- (void)initView{
    self.view.backgroundColor = kColorWhite;
    self.fd_prefersNavigationBarHidden = YES;
    
    [self.view addSubview:self.navigationBar];
    [self.view addSubview:self.historyView];
    

    
   
}


#pragma mark ---------------NetWork-------------------------/
- (void)loadData{
    [SearchModel searchWithTitle:@"" success:^(StatusModel *statusModel) {
        
    }];
}

#pragma mark ---------------Event-------------------------/
- (void)cancelButtonAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ---------------Lazy-------------------------/
/**
 自定义的导航栏
 */
- (UIView *)navigationBar
{
    if (!_navigationBar) {
        _navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        _navigationBar.backgroundColor = kColorWhite;
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _navigationBar.height - 1, _navigationBar.width, 1)];
        lineView.backgroundColor = kBackGroundGrayColor;
        [_navigationBar addSubview:lineView];
        
        //搜索框
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(40, _navigationBar.height - 30 - 7, kScreenWidth-50 - 40, 30)];
        searchBar.placeholder = @"查找地点";
        searchBar.backgroundColor = kBackGroundGrayColor;
        searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
        searchBar.layer.cornerRadius = 15;
        searchBar.layer.masksToBounds = YES;
        searchBar.delegate = self;
        [[[[searchBar.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
        UITextField * searchField = [searchBar valueForKey:@"_searchField"];
        searchField.backgroundColor = kBackGroundGrayColor;
        [searchField setValue:kFontSize14 forKeyPath:@"_placeholderLabel.font"];
        _searchBar = searchBar;
        [_navigationBar addSubview:searchBar];
        
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 50, _navigationBar.height - 44, 40, 44)];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = kFontSizeBold14;
        [cancelBtn setTitleColor:kColor6B6B6B forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setEnlargeEdge:5];
        _cancelBtn = cancelBtn;
        //        cancelBtn.backgroundColor = kColorRed;
        [_navigationBar addSubview:cancelBtn];
        
    }
    return _navigationBar;
}

- (SearchHistoryView *)historyView{
    if (!_historyView) {
        _historyView = [[SearchHistoryView alloc]initWithFrame:CGRectMake(0, self.navigationBar.bottom, kScreenWidth, kScreenHeight - self.navigationBar.bottom)];
    }
    return _historyView;
}

@end
