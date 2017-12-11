//
//  SelectCarportVC.m
//  SharedParking
//
//  Created by galaxy on 2017/12/11.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "SelectCarportVC.h"
#import "BaseTBView.h"
#import "SelectCarportTBCell.h"
#import "ReleaseModel.h"
@interface SelectCarportVC ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *navigationBar;
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UIButton *cancelBtn;

@property (nonatomic , strong) BaseTBView *tbView;
@property (nonatomic , assign) NSInteger page;
@property (nonatomic , strong) NSMutableArray *dataArr;
@property (nonatomic , copy) NSString *searchStr;
@end

@implementation SelectCarportVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
//    [self searchResult:@""];

}

- (void)initView{
    self.view.backgroundColor = kColorWhite;
    self.fd_prefersNavigationBarHidden = YES;
    
    [self.view addSubview:self.navigationBar];
    [self.view addSubview:self.tbView];
}

#pragma mark ---------------NetWork-------------------------/
- (void)searchResult:(NSString *)searchStr{
    kSelfWeak;
    [ReleaseModel releaseShortWithSearchStr:searchStr page:self.page success:^(StatusModel *statusModel) {
        
        kSelfStrong;
        [strongSelf.tbView.mj_header endRefreshing];
        [strongSelf.tbView.mj_footer endRefreshing];

        if (strongSelf.page == 1) {
            [strongSelf.dataArr removeAllObjects];
        }

        if (statusModel.flag == kFlagSuccess) {
            NSArray *dataArr = statusModel.data;
            if (dataArr.count > 0) {
                [strongSelf.dataArr addObjectsFromArray:dataArr];
            }
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
        [strongSelf.tbView reloadData];
    }];
}

#pragma mark -------------tableView--delegate-------------/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectCarportTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectCarportTBCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArr[indexPath.row];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ReleaseModel *model = self.dataArr[indexPath.row];
    if (self.backBlock) {
        self.backBlock(model.id, model.park_title);
    }
    [self backToSuperView];
}

#pragma mark ---------------Event-------------------------/
- (void)cancelButtonAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    
    self.searchStr = searchBar.text;
    [self searchResult:searchBar.text];
    
}


#pragma mark ---------------Lazy-------------------------/
/**
 自定义的导航栏
 */
- (UIView *)navigationBar
{
    if (!_navigationBar) {
        _navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kStatusBarAndNavigationBarHeight)];
        _navigationBar.backgroundColor = kColorWhite;
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _navigationBar.height - 1, _navigationBar.width, 1)];
        lineView.backgroundColor = kBackGroundGrayColor;
        [_navigationBar addSubview:lineView];
        
        //搜索框
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(40, _navigationBar.height - 30 - 7, kScreenWidth-50 - 40, 30)];
        searchBar.placeholder = @"请输入您车位所在小区名称";
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

- (BaseTBView *)tbView{
    if (!_tbView) {
        _tbView = [[BaseTBView alloc]initWithFrame:CGRectMake(0, self.navigationBar.bottom, kScreenWidth, kScreenHeight - self.navigationBar.bottom) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.showsVerticalScrollIndicator = NO;
        _tbView.rowHeight = 60;
        _tbView.backgroundColor = kBackGroundGrayColor;
        _tbView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tbView.tableFooterView = [UIView new];
        
        if (@available(iOS 9.0, *)) {
            _tbView.cellLayoutMarginsFollowReadableWidth = NO;
        }
        
        [_tbView registerClass:[SelectCarportTBCell class] forCellReuseIdentifier:@"SelectCarportTBCell"];
        
        kSelfWeak;
        _tbView.mj_header = [JMRefreshHeader headerWithRefreshingBlock:^{
            kSelfStrong;
            strongSelf.page = 1;
            [strongSelf searchResult:strongSelf.searchStr];
        }];
        _tbView.mj_footer = [JMRefreshFooter footerWithRefreshingBlock:^{
            kSelfStrong;
            strongSelf.page ++;
            [strongSelf searchResult:strongSelf.searchStr];
        }];
    }
    return _tbView;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}

@end
