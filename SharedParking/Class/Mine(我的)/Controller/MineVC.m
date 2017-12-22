//
//  MineVC.m
//  SharedParking
//
//  Created by galaxy on 2017/10/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//
#define kHeadBgHeight (450/750.0*kScreenWidth)
#import "MineVC.h"
#import "SettingVC.h"
#import "ParkingRecordVC.h"
#import "MyRequestVC.h"
#import "MyReserveVC.h"
#import "MyIssueVC.h"
#import "LoginVC.h"
#import "BalanceVC.h"
#import "EditVC.h"
#import "CarNumberListVC.h"

#import "MineHeaderView.h"
@interface MineVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) MineHeaderView *headerView;
@property (nonatomic , strong) UITableView *tbView;
@property (nonatomic , strong) NSArray *firstArr;
@property (nonatomic , strong) UIView *navView;
@property (nonatomic , strong) UILabel *titleLab;

@property (nonatomic , strong) UserModel *userModel;
@end

@implementation MineVC
#pragma mark ---------------LifeCycle-------------------------/
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
}

- (void)initView{
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = kColorRandom;
    self.fd_prefersNavigationBarHidden = YES;
    
    [self.view addSubview:self.tbView];
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.titleLab];

    self.firstArr = @[@{kImgKey:@"mine_parking",kTitleKey:@"我的求租"},
                      @{kImgKey:@"mine_release",kTitleKey:@"我的发布"},
                      @{kImgKey:@"mine_reserve",kTitleKey:@"我的预订"},
                      @{kImgKey:@"mine_record",kTitleKey:@"停车记录"},
                      @{kImgKey:@"mine_set",kTitleKey:@"设置"}];
    
}

/*--------------------------network---------------------------*/
- (void)loadData{
    kSelfWeak;
    [UserModel getMineDataSuccess:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            strongSelf.userModel = statusModel.data;
            GetDataManager.headimg = strongSelf.userModel.headimg;
        }else{
            strongSelf.userModel = nil;
        }
        
        strongSelf.headerView.userModel = strongSelf.userModel;
        [strongSelf.tbView reloadData];
    }];
}


#pragma mark ---------------event ---------------------/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY + kStatusBarAndNavigationBarHeight <= kHeadBgHeight) {
        CGFloat alpha = 1 - (kHeadBgHeight - kStatusBarAndNavigationBarHeight - offsetY)/(kHeadBgHeight - kStatusBarAndNavigationBarHeight);
        [self adjustNavBarWithAlpha:alpha];
    } else {
        [self adjustNavBarWithAlpha:1];
    }
}

- (void)adjustNavBarWithAlpha:(CGFloat)alpha
{
    DLog(@"%f",alpha);
    self.navView.backgroundColor = [UIColor colorWithWhite:1 alpha:alpha];
    if (alpha <= 0.5) {
        self.titleLab.textColor = kColorWhite;
    } else {
        self.titleLab.textColor = kColorBlack;
    }

}

- (void)pushAction:(NSInteger)type{
    [self loginVerifySuccess:^{
        if (type == 0) {
            EditVC *vc = [[EditVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (type == 1){
            BalanceVC *vc = [[BalanceVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (type == 2){
            CarNumberListVC *vc = [[CarNumberListVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
}

#pragma mark -------------tableView--delegate-------------/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.firstArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = kFontSize16;
    cell.textLabel.textColor = kColorBlack;
    
    NSDictionary *dic = self.firstArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[dic objectForKey:kImgKey]];
    cell.textLabel.text = [dic objectForKey:kTitleKey];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self loginVerifySuccess:^{
        if (indexPath.row == 0) {
            MyRequestVC *vc = [[MyRequestVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1){
            MyIssueVC *vc = [[MyIssueVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2){
            MyReserveVC *vc = [[MyReserveVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 3){
            ParkingRecordVC *vc = [[ParkingRecordVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 4){
            SettingVC *vc = [[SettingVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
}


#pragma mark ---------------Lazy-------------------------/
- (MineHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[MineHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeadBgHeight + 80)];
        kSelfWeak;
        _headerView.pushBlock = ^(NSInteger type) {
            kSelfStrong;
            [strongSelf pushAction:type];
        };
    }
    return _headerView;
}
- (UITableView *)tbView{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.showsVerticalScrollIndicator = NO;
        _tbView.rowHeight = 55;
        _tbView.backgroundColor = kBackGroundGrayColor;
        _tbView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tbView.estimatedRowHeight = 0;
        _tbView.estimatedSectionHeaderHeight = 0;
        _tbView.estimatedSectionFooterHeight = 0;

        if (@available(iOS 9.0, *)) {
            _tbView.cellLayoutMarginsFollowReadableWidth = NO;
        }
        
        _tbView.tableHeaderView = self.headerView;
        _tbView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        [_tbView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tbView;
}

- (UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kStatusBarAndNavigationBarHeight)];
        _navView.backgroundColor = kColorClear;
    }
    return _navView;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSizeBold18;
        _titleLab.textColor = kColorWhite;
        _titleLab.textAlignment = NSTextAlignmentCenter;;
        _titleLab.text = @"我的";
        _titleLab.frame = CGRectMake(0, kStatusBarHeight, kScreenWidth, _navView.height - kStatusBarHeight);
    }
    return _titleLab;
}

@end
