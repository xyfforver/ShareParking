//
//  RechargeVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/30.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "RechargeVC.h"
#import "RechargeCLCell.h"
#import "OrderPayMethodView.h"
#import "PayInfoModel.h"
#import "RechargeModel.h"
@interface RechargeVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) UIView *titleView;
@property (nonatomic , strong) UICollectionView *clView;
@property (nonatomic , strong) UIView *infoView;
@property (nonatomic , strong) OrderPayMethodView *payView;
@property (nonatomic , strong) RechargeModel *rechargeModel;

@property (nonatomic , copy) NSString *priceId;
@property (nonatomic , strong) NSMutableArray *priceArray;


@end

@implementation RechargeVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];

    [self loadData];
}

- (void)initView{
    self.title = @"充值";
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.titleView];
    [self.scrollView addSubview:self.clView];
    [self.scrollView addSubview:self.infoView];
    [self.scrollView addSubview:self.payView];
}

#pragma mark ---------------NetWork-------------------------/
- (void)loadData{
    kSelfWeak;
    [WSProgressHUD show];
    [RechargeModel rechargeListWithSuccess:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            strongSelf.rechargeModel = statusModel.data;
            NSArray *array = [strongSelf.rechargeModel.deposit_fee componentsSeparatedByString:@","];
            strongSelf.priceArray = [NSMutableArray arrayWithArray:array];
//            strongSelf.moneyView.moneyLab.text = [NSString stringWithFormat:@"%.2f",[strongSelf.rechargeModel.totalprice floatValue]];
            [strongSelf.clView reloadData];
            [WSProgressHUD dismiss];
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
    }];
}

#pragma mark ---------------Event-------------------------/
-(void)clickRechangeBtn:(UIButton *)button{
    NSLog(@"我要充钱");
//    if ([NSString isNull:self.priceId]) {
//        [WSProgressHUD showImage:nil status:@"请选择充值金额"];
//        return;
//    }
    [self showPay];
}

- (void)payMethod:(NSInteger)index{
    
    switch (index) {
        case 0:{
            DLog(@"微信支付");
            [WSProgressHUD showImage:nil status:@"该功能正在紧急开发，敬请期待"];
            //[PayInfoModel rechargeWithPriceId:self.priceId type:PayOrderWechatType success:nil];
        }
            break;
        case 1:{
            DLog(@"支付宝支付");
            [PayInfoModel rechargeWithPriceId:self.priceId type:PayOrderAliType success:^(StatusModel *statusModel) {
                [self getPayResult];
            }];
        }
            break;
        case 2:{
            DLog(@"会员卡支付");
        }
            break;
        default:
            break;
    }
}

- (void)payResault:(NSNotification *)note {
    NSString *str = note.object;
    if ([str isEqualToString:@"1"]) {
        [self getPayResult];
    }else{
        //支付失败
        [WSProgressHUD showImage:nil status:@"支付失败"];
    }
}

- (void)getPayResult{
    [WSProgressHUD showImage:nil status:@"支付成功！"];
    [self dismissPay];
    
    if (self.rechangeBlock) {
        self.rechangeBlock();
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self backToSuperView];
    });
}

- (void)showPay{
    [UIView animateWithDuration:0.2 animations:^{
        self.payView.top = kBodyHeight - kTabbarSafeBottomMargin - self.payView.height;
    }];
}

- (void)dismissPay{
    [UIView animateWithDuration:0.2 animations:^{
        self.payView.top = kBodyHeight;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    
    //隐藏支付页面
    CGRect collectionViewRect = self.payView.frame;
    if (!CGRectContainsPoint(collectionViewRect, point)) {
        [UIView animateWithDuration:0.2 animations:^{
            self.payView.top = kBodyHeight;
        }];
    }
}


#pragma mark ------------collectionView delegate ------------------/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.priceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RechargeCLCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RechargeCLCell" forIndexPath:indexPath];
    cell.titleLab.text = [NSString stringWithFormat:@"%@元", self.priceArray[indexPath.row]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    RechargeCLCell *cell = (RechargeCLCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderColor = kColorDD9900.CGColor;
    cell.titleLab.textColor = kColorDD9900;
    cell.imgView.hidden = NO;
    self.priceId = self.priceArray[indexPath.row];
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    RechargeCLCell *cell = (RechargeCLCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderColor = kColorC1C1C1.CGColor;
    cell.titleLab.textColor = kColor333333;
    cell.imgView.hidden = YES;
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
        [rechangeBtn addTarget:self action:@selector(clickRechangeBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        rechangeBtn.backgroundColor = kNavBarColor;
        [_infoView addSubview:rechangeBtn];
    }
    return _infoView;
}
- (OrderPayMethodView *)payView{
    if (!_payView) {
        _payView = [[OrderPayMethodView alloc]initWithIsRechange:YES frame:CGRectMake(0, kBodyHeight, kScreenWidth, 200)];
        kSelfWeak;
        _payView.payMethodBlock = ^(NSInteger index) {
            kSelfStrong;
            [strongSelf payMethod:index];
            
        };
    }
    return _payView;
}
- (NSMutableArray *)priceArray{
    if (!_priceArray) {
        _priceArray = [[NSMutableArray alloc]init];
    }
    return _priceArray;
}
@end
