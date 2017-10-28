//
//  ParkingSpaceMapView.m
//  SharedParking
//
//  Created by galaxy on 2017/10/28.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ParkingSpaceMapView.h"
@interface ParkingSpaceMapView ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate>
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UIButton *userCenterBtn;
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) UIButton *minusBtn;

@end

@implementation ParkingSpaceMapView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    
    [self addSubview:self.mapView];
    [self addSubview:self.imgView];
    [self addSubview:self.userCenterBtn];
    [self addSubview:self.addBtn];
    [self addSubview:self.minusBtn];
    
    [self addItemButton];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
    }];
    
    [self.userCenterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgView);
        make.bottom.mas_equalTo(-15);
    }];
    
    
    [self.minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(self.userCenterBtn);
        make.width.height.mas_equalTo(35);
    }];

    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(self.minusBtn.mas_top);
        make.width.height.mas_equalTo(self.minusBtn);
    }];
    
}

- (void)setUpMapDelegate{
    self.mapView.delegate = self;
}

- (void)addItemButton{
    NSArray *titleArr = @[@"求租",@"违章",@"加油",@"油耗"];
    NSArray *imgArr = @[@"home_rent",@"home_search",@"home_addFuel",@"home_fuel"];
    CGFloat itemWidth = 40;
    for (int i = 0; i < imgArr.count; i++) {
        UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [itemBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [itemBtn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        itemBtn.titleLabel.font = kFontSize10;
        [itemBtn setTitleColor:kColor4292D3 forState:UIControlStateNormal];
        [itemBtn setBackgroundColor:kColorWhite];
        [itemBtn addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        itemBtn.layer.cornerRadius = 3;
        itemBtn.layer.borderColor = kBackGroundGrayColor.CGColor;
        itemBtn.layer.borderWidth = 0.5;
        itemBtn.layer.shadowColor = [[UIColor grayColor] colorWithAlphaComponent:0.8].CGColor;
        itemBtn.layer.shadowOffset = CGSizeMake(2,2);
        itemBtn.layer.shadowOpacity = 0.5;
        itemBtn.layer.shadowRadius = 2;
        
        itemBtn.tag = 100 + i;
        itemBtn.frame = CGRectMake(kScreenWidth - itemWidth - 15, 15 + i * (itemWidth + 15), itemWidth, itemWidth);
        [itemBtn lc_imageTitleVerticalAlignmentWithSpace:1];
        
        [self addSubview:itemBtn];
    }
}

#pragma mark ---------------event ---------------------/
- (void)itemAction:(UIButton *)button{
    NSInteger tag = button.tag - 100;
    switch (tag) {
        case 0:{
            
        }
            break;
        case 1:{
            
        }
            break;
        case 2:{
            
        }
            break;
        case 3:{
            
        }
            break;
        default:
            break;
    }
}

- (void)userCenterAction:(UIButton *)button{
    
}

- (void)addAction:(UIButton *)button{
    NSInteger zoomLevel = self.mapView.zoomLevel;
    [self.mapView setZoomLevel:zoomLevel + 1];
}

- (void)minusAction:(UIButton *)button{
    NSInteger zoomLevel = self.mapView.zoomLevel;
    [self.mapView setZoomLevel:zoomLevel - 1];
}

#pragma mark -----------------Lazy---------------------/
- (BMKMapView *)mapView{
    if (!_mapView) {
        ///初始化地图
        _mapView = [[BMKMapView alloc] initWithFrame:self.bounds];
        _mapView.delegate = self;
        _mapView.rotateEnabled = NO;//禁用旋转手势
        [_mapView setMapType:BMKMapTypeStandard];
        _mapView.isSelectedAnnotationViewFront = YES;//选中图标显示在最上面
        
        //在手机上当前可使用的级别为3-21级
        _mapView.zoomLevel = 13;
        
        ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
        _mapView.showsUserLocation = YES;
        //
        
        BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
        displayParam.isAccuracyCircleShow = false;//精度圈是否显示
        [_mapView updateLocationViewWithParam:displayParam];
    }
    return _mapView;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.image = [UIImage imageNamed:@"home_busy"];
    }
    return _imgView;
}

- (UIButton *)userCenterBtn{
    if (!_userCenterBtn) {
        _userCenterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_userCenterBtn setImage:[UIImage imageNamed:@"home_location"] forState:UIControlStateNormal];
        [_userCenterBtn addTarget:self action:@selector(userCenterAction:) forControlEvents:UIControlEventTouchUpInside];
        [_userCenterBtn setEnlargeEdge:5];
    }
    return _userCenterBtn;
}

- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setTitle:@"+" forState:UIControlStateNormal];
        _addBtn.titleLabel.font = [UIFont fontWithName:CUSTOMFONTULTRABOLD size:22];
        [_addBtn setTitleColor:kColorDeepBlack forState:UIControlStateNormal];
        [_addBtn setBackgroundColor:kColorWhite];
        [_addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (UIButton *)minusBtn{
    if (!_minusBtn) {
        _minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_minusBtn setTitle:@"-" forState:UIControlStateNormal];
        _minusBtn.titleLabel.font = [UIFont fontWithName:CUSTOMFONTULTRABOLD size:22];
        [_minusBtn setTitleColor:kColorDeepBlack forState:UIControlStateNormal];
        [_minusBtn setBackgroundColor:kColorWhite];
        [_minusBtn addTarget:self action:@selector(minusAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _minusBtn;
}

@end
