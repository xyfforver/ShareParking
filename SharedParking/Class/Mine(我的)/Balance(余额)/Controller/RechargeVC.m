//
//  RechargeVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/30.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "RechargeVC.h"
#import "RechargeCLCell.h"
@interface RechargeVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) UIView *titleView;
@property (nonatomic , strong) UICollectionView *clView;
@property (nonatomic , strong) UIView *infoView;
@end

@implementation RechargeVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];

}

- (void)initView{
    self.title = @"充值";
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.titleView];
    [self.scrollView addSubview:self.clView];
    [self.scrollView addSubview:self.infoView];
}

#pragma mark ---------------NetWork-------------------------/


#pragma mark ---------------Event-------------------------/

#pragma mark ------------collectionView delegate ------------------/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RechargeCLCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RechargeCLCell" forIndexPath:indexPath];
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark ---------------Lazy-------------------------/
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0 , 0, kScreenWidth, kBodyHeight)];
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        _titleView.backgroundColor = kColorWhite;
        
        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.font = kFontSize15;
        titleLab.textColor = kColor333333;
        titleLab.text = @"请选择充值金额";
//        titleLab.backgroundColor = kColorRed;
        titleLab.frame = CGRectMake(kMargin15, 0, kScreenWidth - 2 * kMargin15, 40);
        [_titleView addSubview:titleLab];
    }
    return _titleView;
}

- (UICollectionView *)clView{
    if (!_clView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.sectionInset = UIEdgeInsetsMake(kMargin15, kMargin15, 20, kMargin15);
        CGFloat itemWidth = (kScreenWidth - 2 *kMargin15 - 40 * 2)/3.0;
        layout.itemSize = CGSizeMake(itemWidth, 40);
        layout.minimumLineSpacing = kMargin15;
        _clView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.titleView.bottom, kScreenWidth, 150) collectionViewLayout:layout];
        _clView.delegate = self;
        _clView.dataSource = self;
        _clView.backgroundColor = kColorWhite;
        
        [_clView registerClass:[RechargeCLCell class] forCellWithReuseIdentifier:@"RechargeCLCell"];
        _clView.showsVerticalScrollIndicator = NO;
        
        
    }
    return _clView;
}

- (UIView *)infoView{
    if (!_infoView) {
        _infoView = [[UIView alloc]initWithFrame:CGRectMake(0, self.clView.bottom, kScreenWidth, 300)];
        
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin15, 25, 100, 15)];
        titleLab.font = kFontSize14;
        titleLab.textColor = kColor333333;
        titleLab.text = @"充值说明";
        [_infoView addSubview:titleLab];
        
        UILabel *infoLab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin15, titleLab.bottom + 5, kScreenWidth - kMargin15 * 2, 110)];
        infoLab.font = kFontSize14;
        infoLab.textColor = kColor6B6B6B;
        infoLab.numberOfLines = 0;
        infoLab.text = @"1.现金余额仅可用于支付分刻停车涉及的产品或服务所生产的相关费用。\n2.充值本金不可用于转移或转增。\n3.充值本金余额可申请提现。";
        [_infoView addSubview:infoLab];
        
        UIButton *rechangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rechangeBtn setTitle:@"充值" forState:UIControlStateNormal];
        rechangeBtn.frame = CGRectMake((kScreenWidth - 185)/2.0, infoLab.bottom + 40, 185, 40);
        rechangeBtn.layer.cornerRadius = 20;
        rechangeBtn.titleLabel.font = kFontSize15;
        [rechangeBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        rechangeBtn.backgroundColor = kNavBarColor;
        [_infoView addSubview:rechangeBtn];
    }
    return _infoView;
}

@end
