//
//  MineVC.m
//  SharedParking
//
//  Created by galaxy on 2017/10/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//
#define kHeadBgHeight (450/750.0*kScreenWidth)
#import "MineVC.h"
#import "MineHeaderView.h"
@interface MineVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) MineHeaderView *headerView;
@property (nonatomic , strong) UITableView *tbView;
@property (nonatomic , strong) NSArray *firstArr;
@property (nonatomic , strong) UIView *navView;
@property (nonatomic , strong) UILabel *titleLab;
@end

@implementation MineVC
#pragma mark ---------------LifeCycle-------------------------/
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

    self.firstArr = @[@{kImgKey:@"mine_parking",kTitleKey:@"我的求助"},
                      @{kImgKey:@"mine_release",kTitleKey:@"我的发布"},
                      @{kImgKey:@"mine_reserve",kTitleKey:@"我的预订"},
                      @{kImgKey:@"mine_record",kTitleKey:@"停车记录"},
                      @{kImgKey:@"mine_set",kTitleKey:@"设置"}];
    
}

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

#pragma mark -------------tableView--delegate-------------/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.firstArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = kFontSizeBold16;
    cell.textLabel.textColor = kColorBlack;
    
    NSDictionary *dic = self.firstArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[dic objectForKey:kImgKey]];
    cell.textLabel.text = [dic objectForKey:kTitleKey];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self loginVerifySuccess:^{

    }];
}


#pragma mark ---------------Lazy-------------------------/
- (MineHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[MineHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeadBgHeight + 80)];
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
        _tbView.backgroundColor = kColorWhite;
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
