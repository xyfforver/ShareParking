//
//  ParkingSpaceVC.m
//  SharedParking
//
//  Created by galaxy on 2017/10/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ParkingSpaceVC.h"
#import "CarportPayVC.h"

#import "ParkingSpaceHeaderView.h"
#import "ParkingSpaceMapView.h"
#import "ParkingSpaceTBView.h"
#import "JMTitleSelectView.h"


#import "CarportShortListModel.h"
#import "CarportLongListModel.h"
@interface ParkingSpaceVC ()

@property (nonatomic , strong) JMTitleSelectView *titleView;
@property (nonatomic , strong) ParkingSpaceHeaderView *headerView;
@property (nonatomic , strong) ParkingSpaceMapView *mapView;
@property (nonatomic , strong) ParkingSpaceTBView *tbView;
@property (nonatomic , strong) UIButton *selectedBtn;
@property (nonatomic , assign) CarportRentType type;



@property (nonatomic , assign) NSInteger page;

@end

@implementation ParkingSpaceVC
#pragma mark ---------------LifeCycle-------------------------/
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.mapView setUpMapDelegate];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.mapView cancelMapDelegate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
}

- (void)initView{
    [self initNavBarView];
    self.page = 1;
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.tbView];
    
    self.tbView.hidden = YES;
    
    self.type = CarportShortRentType;
}

- (void)setType:(CarportRentType)type{
    _type = type;
    
    self.mapView.type = type;
    
    if (!self.tbView.hidden) {
        [self.tbView.mj_header beginRefreshing];
    }else{
        [self.mapView loadMapData];
    }
}

#pragma mark ---------------network ---------------------/

- (void)loadData{
    self.type != CarportLongRentType ? [self loadCarportShortListData] : [self loadCarportLongListData];
}

- (void)loadCarportShortListData{
    kSelfWeak;
    [CarportShortListModel carportShortListWithPage:self.page success:^(StatusModel *statusModel) {
        kSelfStrong;
        [strongSelf.tbView.mj_header endRefreshing];
        [strongSelf.tbView.mj_footer endRefreshing];
        
        strongSelf.tbView.type = strongSelf.type;
        
        if (strongSelf.page == 1) {
            [strongSelf.tbView.dataArr removeAllObjects];
        }
        
        if (statusModel.flag == kFlagSuccess) {
            NSArray *dataArr = statusModel.data;
            if (dataArr.count > 0) {
                [strongSelf.tbView.dataArr addObjectsFromArray:dataArr];
            }
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
        [strongSelf.tbView reloadData];
    }];
}

- (void)loadCarportLongListData{
    kSelfWeak;
    [CarportLongListModel carportLongListWithPage:self.page success:^(StatusModel *statusModel) {
        kSelfStrong;
        [strongSelf.tbView.mj_header endRefreshing];
        [strongSelf.tbView.mj_footer endRefreshing];
        
        strongSelf.tbView.type = strongSelf.type;
        
        if (strongSelf.page == 1) {
            [strongSelf.tbView.dataArr removeAllObjects];
        }
        
        if (statusModel.flag == kFlagSuccess) {
            NSArray *dataArr = statusModel.data;
            if (dataArr.count > 0) {
                [strongSelf.tbView.dataArr addObjectsFromArray:dataArr];
            }
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
        [strongSelf.tbView reloadData];
    }];
}

#pragma mark ---------------action ---------------------/
- (void)codeAction{
//    CarportPayVC *vc = [[CarportPayVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    [self openQRCode];
    
}

- (void)listAction:(UIButton *)button{
    DLog(@"点击了 翻转");
    //获取到flipView
    UIView *flipView = self.navigationItem.rightBarButtonItem.customView;
    
    //取得需要翻转的按钮
    UIView *btn1 = [flipView viewWithTag:1];
    UIView *btn2 = [flipView viewWithTag:2];
    
    //是否从左侧翻转
    BOOL isLeft = btn1.hidden;
    
    //翻转视图
    [self flipWithView:flipView isLeft:isLeft];
    [self flipWithView:self.view isLeft:isLeft];
    
    //改变按钮显示状态
    btn1.hidden = !btn1.hidden;
    btn2.hidden = !btn2.hidden;
    
    //切换地图视图与列表视图
    self.mapView.hidden = !self.mapView.hidden;
    self.tbView.hidden = !self.tbView.hidden;
    
    if (!self.tbView.hidden) {
        [self.tbView.mj_header beginRefreshing];
    }else{
        [self.mapView loadMapData];
    }
}

#pragma mark -flip animation
/*
 view:需要翻转的视图
 isLeft :是否从左侧翻转
 */
- (void)flipWithView:(UIView *)view isLeft:(BOOL)isLeft{
    
    //翻转的效果 枚举
    UIViewAnimationOptions option = isLeft ? UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight;
    
    [UIView transitionWithView:view duration:.3 options:option animations:NULL completion:NULL];
}


#pragma mark ---------------lazy ---------------------/

- (void)initNavBarView{
    if (!_titleView) {
        _titleView = [[JMTitleSelectView alloc]init];
        kSelfWeak;
        _titleView.IndexChangeBlock = ^(NSInteger index) {
            kSelfStrong;
            strongSelf.type = index == 0 ? CarportShortRentType : CarportLongRentType;
        };
        
        self.navigationItem.titleView = _titleView;
    }
    
    self.navigationItem.leftBarButtonItem = [[self class] rightBarButtonWithName:nil imageName:@"home_qrcode" target:self action:@selector(codeAction)];
    
    // 创建翻转父视图
    UIView *flipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = flipView.bounds;
    [btn1 setTitle:@"列表" forState:UIControlStateNormal];
    btn1.titleLabel.font = kFontSizeBold17;
    [btn1 setTitleColor:kColorBlack forState:UIControlStateNormal];
    btn1.tag = 1;
    [btn1 addTarget:self action:@selector(listAction:) forControlEvents:UIControlEventTouchUpInside];
    [flipView addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = flipView.bounds;
    [btn2 setTitle:@"地图" forState:UIControlStateNormal];
    btn2.titleLabel.font = kFontSizeBold17;
    [btn2 setTitleColor:kColorBlack forState:UIControlStateNormal];
    btn2.tag = 2;
    [btn2 addTarget:self action:@selector(listAction:) forControlEvents:UIControlEventTouchUpInside];
    btn2.hidden = YES;
    [flipView addSubview:btn2];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:flipView];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (ParkingSpaceHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[ParkingSpaceHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    }
    return _headerView;
}

- (ParkingSpaceMapView *)mapView{
    if (!_mapView) {
        _mapView = [[ParkingSpaceMapView alloc]initWithFrame:CGRectMake(0, self.headerView.bottom, kScreenWidth, kBodyHeight - self.headerView.height - kTabBarHeight)];
//        kSelfWeak;
//        _mapView.loadBlock = ^{
//            kSelfStrong;
//            [strongSelf loadMapData];
//        };
    }
    return _mapView;
}

- (ParkingSpaceTBView *)tbView{
    if (!_tbView) {
        _tbView = [[ParkingSpaceTBView alloc]initWithFrame:CGRectMake(0, self.headerView.bottom, kScreenWidth, kBodyHeight - self.headerView.height - kTabBarHeight) style:UITableViewStylePlain];
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        kSelfWeak;
        _tbView.mj_header = [JMRefreshHeader headerWithRefreshingBlock:^{
            kSelfStrong;
            strongSelf.page = 1;
            [strongSelf loadData];
        }];
        _tbView.mj_footer = [JMRefreshFooter footerWithRefreshingBlock:^{
            kSelfStrong;
            strongSelf.page ++;
            [strongSelf loadData];
        }];
    }
    return _tbView;
}

@end
