//
//  SearchVC.m
//  SharedParking
//
//  Created by galaxy on 2017/10/31.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "SearchVC.h"
#import "YJTagView.h"


@interface SearchVC ()<UISearchBarDelegate,YJTagViewDelegate, YJTagViewDataSource>
@property (nonatomic,strong) UIView *navigationBar;
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UIButton *cancelBtn;

@property (nonatomic, strong) NSMutableArray *historyData;
@end

@implementation SearchVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];

}

- (void)initView{

    self.fd_prefersNavigationBarHidden = YES;
    
    [self.view addSubview:self.navigationBar];
    
    [self.historyData addObjectsFromArray:@[@"小龙虾", @"日本皮皮虾", @"蓝莓", @"美国进口蓝莓", @"意大利拉面", @"西瓜", @"苹果", @"牛肉", @"🐂", @"🍎", @"🍌",]];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin15, self.navigationBar.bottom + kMargin15, 100, 20)];
    titleLab.text = @"历史记录";
    titleLab.font = kFontSize15;
    titleLab.textColor = kColor333333;
    [self.view addSubview:titleLab];
    
    YJTagView *view = [[YJTagView alloc] initWithFrame:CGRectMake(kMargin15, titleLab.bottom + 20, kScreenWidth - kMargin15 * 2, 20)];
    view.dataSource = self;
    view.delegate = self;
    view.themeColor = kColor333333;
    view.tagCornerRadius = 0;
    view.cellHeight = 33;
    [self.view addSubview:view];
}

#pragma mark ---------------NetWork-------------------------/


#pragma mark ---------------tagView-------------------------/
- (NSInteger)numOfItems {
    return self.historyData.count;
}

- (NSString *)tagView:(YJTagView *)tagView titleForItemAtIndex:(NSInteger)index {
    return self.historyData[index];
}

- (void)tagView:(YJTagView *)tagView didSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"点击%@", self.historyData[index]);
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

- (NSMutableArray *)historyData{
    if (!_historyData) {
        _historyData = [NSMutableArray array];
    }
    return _historyData;
}

@end
