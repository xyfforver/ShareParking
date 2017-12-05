//
//  CarportDetailVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportDetailVC.h"
#import "CarportDetailHeaderView.h"
#import "CarportDetailShortCLView.h"
#import "CarportDetailRentTBView.h"

#import "CarportShortDetailModel.h"
#import "CarportLongDetailModel.h"
@interface CarportDetailVC ()
@property (nonatomic , strong) CarportDetailHeaderView *headerView;
@property (nonatomic , strong) CarportDetailShortCLView *shortCLView;
@property (nonatomic , strong) CarportDetailRentTBView *rentTBView;

@end

@implementation CarportDetailVC

#pragma mark ---------------LifeCycle-------------------------/
- (instancetype)initWithCarportId:(NSString *)carportId type:(CarportRentType)type{
    self = [super init];
    if (self) {
        self.carportId = carportId;
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self loadData];

}

- (void)initView{
    self.fd_prefersNavigationBarHidden = YES;
    
    [self.view addSubview:self.headerView];
    if (self.type == CarportShortRentType) {
        [self.view addSubview:self.shortCLView];
    }else{
        [self.view addSubview:self.rentTBView];
    }
}

#pragma mark ---------------NetWork-------------------------/
- (void)loadData{
    if (self.type == CarportShortRentType) {
        [self loadShortData];
    }else{
        [self loadBrowseData];
        [self loadLongData];
    }
}

- (void)loadShortData{
    kSelfWeak;
    [CarportShortDetailModel carportShortDetailWithCarPortId:self.carportId success:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            CarportShortDetailModel *model = statusModel.data;
            strongSelf.headerView.shortModel = model;
            strongSelf.shortCLView.shortModel = model;
            [strongSelf.shortCLView reloadData];
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
    }];
}

- (void)loadLongData{
    kSelfWeak;
    [CarportLongDetailModel carportLongDetailWithCarportId:self.carportId success:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            CarportLongDetailModel *model = statusModel.data;
            strongSelf.headerView.longModel = model;
            strongSelf.rentTBView.longModel = model;
            [strongSelf.rentTBView reloadData];
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
    }];
}

- (void)loadBrowseData{
    [CarportLongDetailModel browseWithCarportId:self.carportId success:^(StatusModel *statusModel) {
        
    }];
}
#pragma mark ---------------Event-------------------------/


#pragma mark ---------------Lazy-------------------------/
- (CarportDetailHeaderView *)headerView{
    if (!_headerView) {
        CGFloat height = [CarportDetailHeaderView getHeight];
        height = self.type == CarportShortRentType ? height - 20 : height;
        
        _headerView = [[CarportDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height) type:self.type];
    }
    return _headerView;
}

- (CarportDetailShortCLView *)shortCLView{
    if (!_shortCLView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.sectionInset = UIEdgeInsetsMake(15, kMargin15, 0, kMargin15);
        layout.minimumLineSpacing = 2;
        layout.minimumInteritemSpacing = 2;
        layout.itemSize = CGSizeMake((kScreenWidth - 2 * kMargin15 - 4)/3.0, 45);
        
        _shortCLView = [[CarportDetailShortCLView alloc]initWithFrame:CGRectMake(0, self.headerView.bottom + kMargin10, kScreenWidth, kScreenHeight - self.headerView.bottom - kMargin10) collectionViewLayout:layout];
        
    }
    return _shortCLView;
}

- (CarportDetailRentTBView *)rentTBView{
    if (!_rentTBView) {
        _rentTBView = [[CarportDetailRentTBView alloc]initWithFrame:CGRectMake(0, self.headerView.bottom + kMargin10, kScreenWidth, kScreenHeight - self.headerView.bottom - kMargin10) style:UITableViewStylePlain];
        
    }
    return _rentTBView;
}
@end
