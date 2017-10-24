//
//  ParkingSpaceVC.m
//  SharedParking
//
//  Created by galaxy on 2017/10/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ParkingSpaceVC.h"

@interface ParkingSpaceVC ()
@property (nonatomic , strong) UIView *headerView;
@property (nonatomic , strong) UIView *mapView;
@property (nonatomic , strong) UITableView *tbView;
@end

@implementation ParkingSpaceVC
#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
}

- (void)initView{
    [self initNavBarView];
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.tbView];
    
    self.tbView.hidden = YES;
}

#pragma mark ---------------action ---------------------/
- (void)codeAction{
    
    
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
    self.navigationItem.title = @"车位";
    self.view.backgroundColor = kColorRandom;
    
    self.navigationItem.leftBarButtonItem = [[self class] rightBarButtonWithName:@"扫一扫" imageName:nil target:self action:@selector(codeAction)];
    
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

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        _headerView.backgroundColor = kColorRed;
    }
    return _headerView;
}

- (UIView *)mapView{
    if (!_mapView) {
        _mapView = [[UIView alloc]initWithFrame:CGRectMake(0, self.headerView.bottom, kScreenWidth, kBodyHeight - self.headerView.height)];
        _mapView.backgroundColor = kColorOrange;
    }
    return _mapView;
}

- (UITableView *)tbView{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.headerView.bottom, kScreenWidth, kBodyHeight - self.headerView.height) style:UITableViewStylePlain];
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorBlue;
    }
    return _tbView;
}
@end
