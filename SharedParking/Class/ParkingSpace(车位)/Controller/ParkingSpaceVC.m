//
//  ParkingSpaceVC.m
//  SharedParking
//
//  Created by galaxy on 2017/10/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ParkingSpaceVC.h"
#import <AVFoundation/AVFoundation.h>
#import "SGQRCodeScanningVC.h"
#import "CarportPayVC.h"
#import "CarportOpenVC.h"

#import "ParkingSpaceHeaderView.h"
#import "ParkingSpaceMapView.h"
#import "ParkingSpaceTBView.h"
#import "JMTitleSelectView.h"
#import "RobParkingView.h"
#import "LongRentView.h"
#import "ParkingOrderView.h"

#import "CarportListModel.h"
@interface ParkingSpaceVC ()
@property (nonatomic , strong) JMTitleSelectView *titleView;
@property (nonatomic , strong) ParkingSpaceHeaderView *headerView;
@property (nonatomic , strong) ParkingSpaceMapView *mapView;
@property (nonatomic , strong) ParkingSpaceTBView *tbView;
@property (nonatomic , strong) UIButton *selectedBtn;
@property (nonatomic , assign) CarportRentType type;

@property (nonatomic , strong) RobParkingView *itemView;
@property (nonatomic , strong) LongRentView *rentView;
@property (nonatomic , strong) ParkingOrderView *orderView;

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
    
    self.mapView.mapView.delegate = nil; // 不用时，置nil
    //关闭定位
    [self.mapView.service stopUserLocationService];
    self.mapView.service.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
}

- (void)initView{
    [self initNavBarView];
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.tbView];
    [self.mapView addSubview:self.itemView];
    [self.mapView addSubview:self.rentView];
    [self.mapView addSubview:self.orderView];
    
    self.tbView.hidden = YES;
    
    self.type = CarportShortRentType;
}

- (void)setType:(CarportRentType)type{
    _type = type;
    
    self.itemView.hidden = type == CarportLongRentType;
    self.rentView.hidden = type != CarportLongRentType;
    
    
    [self loadCarportListData];
}

- (void)loadCarportListData{
    kSelfWeak;
    [CarportListModel carportListWithCity:@"杭州市" type:self.type page:1 success:^(StatusModel *statusModel) {
        kSelfStrong;
        [strongSelf.tbView.mj_header endRefreshing];
        [strongSelf.tbView.mj_footer endRefreshing];
        if (strongSelf.page == 1) [strongSelf.tbView.dataArr removeAllObjects];
        
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
//    CarportOpenVC *vc = [[CarportOpenVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        SGQRCodeScanningVC *vc = [[SGQRCodeScanningVC alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    });
                    // 用户第一次同意了访问相机权限
                    NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                    
                } else {
                    // 用户第一次拒绝了访问相机权限
                    NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            SGQRCodeScanningVC *vc = [[SGQRCodeScanningVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertC addAction:alertA];
            [self presentViewController:alertC animated:YES completion:nil];
            
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
    }
    
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
//        _mapView.backgroundColor = kColorOrange;
    }
    return _mapView;
}

- (ParkingSpaceTBView *)tbView{
    if (!_tbView) {
        _tbView = [[ParkingSpaceTBView alloc]initWithFrame:CGRectMake(0, self.headerView.bottom, kScreenWidth, kBodyHeight - self.headerView.height - kTabBarHeight) style:UITableViewStylePlain];
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tbView;
}

- (RobParkingView *)itemView{
    if (!_itemView) {
        _itemView = [[RobParkingView alloc]initWithFrame:CGRectMake(40, self.mapView.height - [RobParkingView getHeight] - 50, kScreenWidth - 40 * 2, [RobParkingView getHeight])];
        _itemView.hidden = YES;
    }
    return _itemView;
}

- (LongRentView *)rentView{
    if (!_rentView) {
        _rentView = [[LongRentView alloc]initWithFrame:CGRectMake(40, self.mapView.height - [LongRentView getHeight] - 50, kScreenWidth - 40 * 2, [LongRentView getHeight])];
        _rentView.hidden = YES;
    }
    return _rentView;
}

- (ParkingOrderView *)orderView{
    if (!_orderView) {
        _orderView = [[ParkingOrderView alloc]initWithFrame:CGRectMake(40, self.mapView.height - [ParkingOrderView getHeight] - 50, kScreenWidth - 40 * 2, [ParkingOrderView getHeight])];
        _orderView.hidden = YES;
    }
    return _orderView;
}
@end
