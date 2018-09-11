//
//  CarportPayVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/13.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportPayVC.h"
#import "ParkingRecordModel.h"
#import "MZTimerLabel.h"
#import "OrderPayMethodView.h"
#import "PayInfoModel.h"
#import "ParkingRecordDetailVC.h"
#import "PayCouponView.h"
@interface CarportPayVC ()<MZTimerLabelDelegate>
@property (nonatomic , strong) UIImageView *bgView;
@property (nonatomic , strong) UIImageView *bgItemView;
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) MZTimerLabel *timeLab;
@property (nonatomic , strong) UILabel *priceLab;
@property (nonatomic , strong) UIButton *closeBtn;
@property (nonatomic , strong) OrderPayMethodView *payView;
@property (nonatomic , strong) PayCouponView *couponView;

@property (nonatomic , strong) NSDate *time;
@property (nonatomic , assign) NSInteger timeCount;
@property (nonatomic , strong) ParkingRecordModel *parkingModel;
@property (nonatomic , strong) ParkingRecordModel *parkRuleMode;//计费
@end

@implementation CarportPayVC
- (instancetype)initWithOrderId:(NSString *)orderId{
    self = [super init];
    if (self) {
        self.orderId = orderId;
    }
    return self;
}
#pragma mark ---------------LifeCycle-------------------------/
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payResault:) name:kWXpayresult object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payResault:) name:kZhifubaoPaysuccessNoti object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kWXpayresult object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kZhifubaoPaysuccessNoti object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self loadData];
    [self loadParkRuleData];
}

- (void)initView{
    self.title = @"结算";
    self.timeCount = 1;
    
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.bgItemView];
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.timeLab];
    [self.view addSubview:self.couponView];
    
    [self.view addSubview:self.priceLab];
    [self.view addSubview:self.closeBtn];
    [self.view addSubview:self.payView];

    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(180);
    }];
    
    [self.bgItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.bgView);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgView);
        make.centerX.mas_equalTo(self.bgView.mas_centerX).offset(-50);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right).offset(5);
        make.centerY.mas_equalTo(self.titleLab.mas_centerY);
    }];
    
    [self.couponView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.bgView.mas_bottom);
        make.height.mas_equalTo(55);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.couponView.mas_bottom).offset(1);
        make.height.mas_equalTo(55);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.top.mas_equalTo(self.priceLab.mas_bottom).offset(100);
        make.width.mas_equalTo(185);
        make.height.mas_equalTo(40);
    }];
    
//    self.priceLab.text = @"当前停车费：12元";
}

#pragma mark ---------------NetWork-------------------------/
- (void)loadData{
    kSelfWeak;
    [ParkingRecordModel orderInfoWithOrderId:self.orderId success:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            strongSelf.parkingModel = statusModel.data;
            
            //[strongSelf setParkingFee];
            
            strongSelf.time = [NSDate dateWithTimeIntervalSince1970:strongSelf.parkingModel.order_jintime];
            [strongSelf startTime];
            
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
            [strongSelf backToSuperView];

        }
    }];
    
    
}

//获取计费价格
-(void)loadParkRuleData{
    kSelfWeak;
    [ParkingRecordModel parkingPayWithOrderId:self.orderId success:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            strongSelf.parkRuleMode = statusModel.data;
            [strongSelf setParkingFee];
        }
    }];
}
//余额支付
- (void)lockCarportData{
    [WSProgressHUD showWithMaskType:(WSProgressHUDMaskTypeClear)];
    CGFloat price = self.parkRuleMode.order_fee;
    NSString *zerotype = @"0";
    //原价格为0
    if (price == 0) {
        price = 0;
        zerotype = @"0";
    }
    //使用优惠券后价格大于0
    else if (price - 5 > 0) {
        price = price - 5;
        zerotype = @"0";
    }
    //使用优惠券后价格小于等于0
    else{
        price = 0;
        zerotype = @"1";
    }
    kSelfWeak;
    [ParkingRecordModel lockWithOrderId:self.orderId payType:@"blancepay" price:[NSString stringWithFormat:@"%.2f", price] zeroType:zerotype success:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            [strongSelf.timeLab pause];
//            [[NSNotificationCenter defaultCenter]postNotificationName:kOpenParkingSpaceSuccessData object:nil];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [WSProgressHUD showImage:nil status:@"已上锁"];
                if (strongSelf.reloadBlock) {
                    strongSelf.reloadBlock();
                }
               // [strongSelf backToSuperView];
                [self gotoOrderDetailVC];
            });
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
    }];
}

//支付宝微信支付地锁
-(void)alipayOrWxpayOfdisuowithtype:(NSString *)type{
    //价格为0 或者使用优惠券后价格为0 自动使用余额支付
    if (self.parkRuleMode.order_fee == 0 || (self.parkRuleMode.order_fee - 5 <= 0)) {
        [self lockCarportData];
    }else{
    
        
    
    kSelfWeak;
    [PayInfoModel alipaylockWithOrderId:self.orderId payType:type price:[NSString stringWithFormat:@"%.2f", self.parkRuleMode.order_fee-5] success:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            [strongSelf.timeLab pause];
            //    [[NSNotificationCenter defaultCenter]postNotificationName:kOpenParkingSpaceSuccessData object:nil];
            [self getPayResult];

        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
        
    }];
    }
}
- (void)closeParkingSpace{
    [WSProgressHUD showWithStatus:@"上锁中~"];
//    kSelfWeak;
//    [ParkingModel openOrCloseParkingSpaceWithType:@"1" cid:self.carCid zid:self.zid success:^(StatusModel *statusModel) {
        //kSelfStrong;
        //self.isClose = YES;
        [self.timeLab pause];
        [[NSNotificationCenter defaultCenter]postNotificationName:kOpenParkingSpaceSuccessData object:nil];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [WSProgressHUD showImage:nil status:@"支付成功，已上锁"];
            if (self.reloadBlock) {
                self.reloadBlock();
            }
           // [self backToSuperView];
            [self gotoOrderDetailVC];
        });
//    }];
}
//跳转到订单详情界面
-(void)gotoOrderDetailVC{
    [self backToSuperView];
    ParkingRecordDetailVC *vc = [ParkingRecordDetailVC new];
    vc.order_id = self.orderId;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)getPayPriceIsTan:(BOOL)isTan{
    //    kSelfWeak;closeAnaccountWithCard:self.zid success:^(StatusModel *statusModel)
//    [ParkingModel closeAnAccountWithCarId:self.zid success:^(StatusModel *statusModel) {
//        kSelfStrong;kSelfStrong if
//        if(statusModel.flag == kFlagSuccess){
//            strongSelf.parkingModel = statusModel.data;
//            CGFloat price = strongSelf.timeCount * strongSelf.parkingModel.carcost - strongSelf.parkingModel.mycouponprice;
//            NSString *str = nil;
//            if (strongSelf.parkingModel.mycouponprice == 0) {
//                str = [NSString stringWithFormat:@"停车费为：%.2f元",strongSelf.timeCount * strongSelf.parkingModel.carcost];
//            }else{
//                str = [NSString stringWithFormat:@"停车费为：%.2f元\n优惠后为：%.2f元",strongSelf.timeCount * strongSelf.parkingModel.carcost,price <= 0 ? 0 : price];
//            }
//            strongSelf.priceLab.text = str;
//            strongSelf.time = [NSDate dateWithTimeIntervalSince1970:[strongSelf.parkingModel.starttime integerValue]];
//            [strongSelf startTime];
//
//            if (isTan) {
//                [UIAlertView alertViewWithTitle:@"支付" message:str cancelButtonTitle:@"确定" otherButtonTitles:nil onDismiss:nil onCancel:^{
//                    if(price <= 0){
//                        [strongSelf closeParkingSpace];
//                    }else{
//                        [strongSelf showPay];
//                    }
//                }];
//            }
//        }else{
//            [WSProgressHUD showImage:nil status:statusModel.message];
//        }
//    }];
    CGFloat price = self.timeCount * self.parkingModel.park_fee;
    if (isTan) {
//        [UIAlertView alertViewWithTitle:@"支付" message:str cancelButtonTitle:@"确定" otherButtonTitles:nil onDismiss:nil onCancel:^{
            if(price <= 0){
                [self closeParkingSpace];
            }else{
                [self showPay];
            }
//        }];
    }
}




#pragma mark ---------------Event-------------------------/
- (void)closeAnAccount:(UIButton *)button{
    [UIAlertView alertViewWithTitle:@"提示" message:@"请确认您的爱车已开出停车位" cancelButtonTitle:@"还没有" otherButtonTitles:@[@"已开出"] onDismiss:^(int buttonIndex, NSString *buttonTitle) {
//        [WSProgressHUD show];
       //[self lockCarportData];
      //  [self getPayPriceIsTan:YES];
        //获取支付金额
        [self loadParkRuleData];
        [self showPay];
    } onCancel:^{
        
    }];
}

- (void)showPay{
    [UIView animateWithDuration:0.2 animations:^{
        self.payView.top = kBodyHeight - kTabbarSafeBottomMargin - self.payView.height;
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


- (void)payMethod:(NSInteger)index{
    CGFloat price = self.parkRuleMode.order_fee;
    //地锁支付
    if ([self.park_type isEqualToString:@"1"]) {
        if (index == 0) {
            DLog(@"微信支付");
            [self alipayOrWxpayOfdisuowithtype:@"wxpay"];
            
        }else if(index == 1){
            DLog(@"支付宝支付");
            
            [self alipayOrWxpayOfdisuowithtype:@"alipay"];
            
            
        }else{
            DLog(@"余额支付");
            [self lockCarportData];
            
        }

    }//道闸下支付
    else if ([self.park_type isEqualToString:@"0"]){
        if (index == 0) {
            [WSProgressHUD showImage:nil status:@"道闸支付紧急开发中，请耐心等待"];
        }
        else if (index == 1){
            [WSProgressHUD showImage:nil status:@"道闸支付紧急开发中，请耐心等待"];

        }else{
            [WSProgressHUD showImage:nil status:@"道闸支付紧急开发中，请耐心等待"];

//            [PayInfoModel gateoutWithCarNumber:@"浙A88888" payType:@"blancepay" price:[NSString stringWithFormat:@"%.2f", price] success:^(StatusModel *statusModel) {
//
//            }];
        }
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
    [WSProgressHUD showImage:nil status:@"付款成功!"];
    [self closeParkingSpace];
}




- (void)startTime{
    NSDate *endD = [NSDate date];
    NSTimeInterval start = [self.time timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSInteger value = end - start;
    if (value > 0) {
        NSInteger time = value % (60 * 60 * 24);
        NSInteger day = value / (60 * 60 * 24);
        DLog(@"%ld---%ld",day,time);
        if (day > 0) {
            //超过一天
            self.titleLab.text = [NSString stringWithFormat:@"计时：%ld天 ",day];
        }else{
            self.titleLab.text = @"计时：";
        }
    }
    self.timeLab.startDate = self.time;
    [self.timeLab start];
}

- (void)setParkingFee{
    CGFloat price = self.parkRuleMode.order_fee;
    if (price == 0) {
        price = 0;
    }
    //使用优惠券后价格大于0
    else if (price - 5 > 0) {
        price = price - 5;
    }
    //使用优惠券后价格小于等于0
    else{
        price = 0;
    }
    NSString *priceStr = [NSString stringWithFormat:@"%.2f",price];
    NSString *str = [NSString stringWithFormat:@"合计：%@元",priceStr];
    NSMutableAttributedString *contentMuStr = [[NSMutableAttributedString alloc]initWithString:str];
    [contentMuStr addAttribute:NSForegroundColorAttributeName value:kColorDD9900 range:NSMakeRange(str.length - priceStr.length - 1, priceStr.length)];
    self.priceLab.attributedText = contentMuStr;
}

#pragma mark ---------------delegate ---------------------/
- (void)timerLabel:(MZTimerLabel *)timerLabel countingTo:(NSTimeInterval)time timertype:(MZTimerLabelType)timerType{
    NSInteger count = time/60/60 + 1;
    
    if (count != self.timeCount) {
        self.timeCount = count;
        [self setParkingFee];
    }
}


#pragma mark ---------------Lazy-------------------------/
- (UIImageView *)bgView{
    if (!_bgView) {
        _bgView = [[UIImageView alloc]init];
        _bgView.image = [UIImage imageNamed:@"carport_bg"];
    }
    return _bgView;
}

- (UIImageView *)bgItemView{
    if (!_bgItemView) {
        _bgItemView = [[UIImageView alloc]init];
        _bgItemView.image = [UIImage imageNamed:@"carport_bgirem"];
    }
    return _bgItemView;
}


- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSizeBold18;
        _titleLab.textColor = kColor333333;
        _titleLab.text = @"计时：";
        _titleLab.textAlignment = NSTextAlignmentRight;
    }
    return _titleLab;
}

- (MZTimerLabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[MZTimerLabel alloc] init];
        _timeLab.timerType = MZTimerLabelTypeStopWatch;
        //do some styling
        _timeLab.timeLabel.backgroundColor = [UIColor clearColor];
        _timeLab.timeLabel.font = kFontSizeBold18;
        _timeLab.timeLabel.textColor = kColorDD9900;
        _timeLab.timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLab.delegate = self;
    }
    return _timeLab;
}

- (UILabel *)priceLab{
    if (!_priceLab) {
        _priceLab = [[UILabel alloc]init];
        _priceLab.backgroundColor = kColorWhite;
        _priceLab.font = kFontSize18;
        _priceLab.textColor = kColor333333;
        _priceLab.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLab;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setTitle:@"点击结算" forState:UIControlStateNormal];
        _closeBtn.titleLabel.font = kFontSize15;
        [_closeBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_closeBtn setBackgroundColor:kNavBarColor];
        [_closeBtn addTarget:self action:@selector(closeAnAccount:) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.layer.cornerRadius = 20;
        _closeBtn.layer.masksToBounds = YES;
    }
    return _closeBtn;
}
- (OrderPayMethodView *)payView{
    if (!_payView) {
        _payView = [[OrderPayMethodView alloc]initWithFrame:CGRectMake(0, kBodyHeight, kScreenWidth, 250)];
        kSelfWeak;
        _payView.payMethodBlock = ^(NSInteger index) {
            kSelfStrong;
            if ([strongSelf.park_type isEqualToString:@"0"]) {
                [strongSelf payMethod:index];
            }else{
            [strongSelf payMethod:index];
            }
        };
    }
    return _payView;
}

-(PayCouponView *)couponView{
    if (!_couponView) {
        _couponView = [[PayCouponView alloc] init];
    }
    return _couponView;
}
@end
