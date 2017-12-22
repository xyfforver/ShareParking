//
//  MyRequestVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/9.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "MyRequestVC.h"
#import "MyRequestRentHeadView.h"
#import "MyRequestRentView.h"
#import "MyRequestRentCLCell.h"

#import "RequestModel.h"
@interface MyRequestVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong) MyRequestRentHeadView *headView;
@property (nonatomic , strong) MyRequestRentView *rentView;
@property (nonatomic , strong) UICollectionView *clView;
@property (nonatomic , strong) RequestModel *requestModel;
@end

@implementation MyRequestVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self loadData];
}

- (void)initView{
    self.title = @"我的求租";
    
    [self.view addSubview:self.headView];
    [self.view addSubview:self.rentView];
    [self.view addSubview:self.clView];
    
}

#pragma mark ---------------NetWork-------------------------/
- (void)loadData{
    kSelfWeak;
    [RequestModel myRequestWithSuccess:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            strongSelf.requestModel = statusModel.data;
            strongSelf.headView.hidden = strongSelf.requestModel ;
            strongSelf.rentView.hidden = !strongSelf.headView.hidden;
            strongSelf.clView.hidden = !strongSelf.headView.hidden;
   
            strongSelf.rentView.model = strongSelf.requestModel.help;
            
            if (strongSelf.requestModel.parking_list.count == 0) {
                [WSProgressHUD showImage:nil status:@"显示暂时没有匹配到所需车位"];
            }
            
            [strongSelf.clView reloadData];

        }else if (statusModel.flag == 400){//没有数据
            strongSelf.headView.hidden = NO;
            strongSelf.rentView.hidden = !strongSelf.headView.hidden;
            strongSelf.clView.hidden = !strongSelf.headView.hidden;
        }
    }];
}

#pragma mark ---------------Event-------------------------/

#pragma mark ------------collectionView delegate ------------------/

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.requestModel.parking_list.count;
//    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyRequestRentCLCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyRequestRentCLCell" forIndexPath:indexPath];
    
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        
    }
    
    return view;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark ---------------Lazy-------------------------/
- (MyRequestRentHeadView *)headView{
    if (!_headView) {
        _headView = [[MyRequestRentHeadView alloc]initWithType:JMHeaderRequestRentType frame:CGRectMake(0, 0, kScreenWidth, [MyRequestRentHeadView getHeight])];
        _headView.hidden = YES;
        
        kSelfWeak;
        _headView.reloadBlock = ^{
            kSelfStrong;
            [strongSelf loadData];
        };
    }
    return _headView;
}

- (MyRequestRentView *)rentView{
    if (!_rentView) {
        _rentView = [[MyRequestRentView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, [MyRequestRentView getHeight])];
        _rentView.hidden = YES;
        
        kSelfWeak;
        _rentView.reloadBlock = ^{
            kSelfStrong;
            [strongSelf loadData];
        };
    }
    return _rentView;
}

- (UICollectionView *)clView{
    if (!_clView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.sectionInset = UIEdgeInsetsMake(kMargin15, kMargin15, kMargin15, kMargin15);
        layout.itemSize = CGSizeMake(kScreenWidth - kMargin15 * 2, 72);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        
        
        _clView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.rentView.bottom, kScreenWidth, kBodyHeight - self.rentView.bottom) collectionViewLayout:layout];
        _clView.delegate = self;
        _clView.dataSource = self;
        _clView.backgroundColor = kBackGroundGrayColor;
        _clView.hidden = YES;
        
        [_clView registerClass:[MyRequestRentCLCell class] forCellWithReuseIdentifier:@"MyRequestRentCLCell"];
        
    }
    return _clView;
}
@end
