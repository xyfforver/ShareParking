//
//  ReserveSuccessVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/24.
//  Copyright © 2017年 galaxy. All rights reserved.
//
//-----------------------------预订详情----------------------//
#import "ReserveSuccessVC.h"
#import "NavigationVC.h"

#import "MZTimerLabel.h"

#import "CarportReserveModel.h"
#import "MyReserveModel.h"
@interface ReserveSuccessVC ()<MZTimerLabelDelegate>
{
    dispatch_source_t _timer;//计时器
}
@property (strong, nonatomic) IBOutlet UILabel *numberLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *addressLab;
@property (strong, nonatomic) IBOutlet UIButton *nowBtn;
@property (strong, nonatomic) IBOutlet UIButton *afterBtn;
@property (strong, nonatomic) IBOutlet UILabel *infoLab;
@property (weak, nonatomic) IBOutlet UILabel *plateNumLab;//!<车牌号
@property (weak, nonatomic) IBOutlet UIButton *unlockButton;//!<一键开锁按钮

@property (nonatomic, strong) NSArray *locationArray;
@property (nonatomic , strong) MZTimerLabel *timeLabal;
@property (nonatomic, strong) CarportReserveModel *carportReserveModel;
@end

@implementation ReserveSuccessVC
- (instancetype)initWithReserveId:(NSString *)reserveId{
    self = [super init];
    if (self) {
        self.reserveId = reserveId;
    }
    return self;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_timer)
    {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = @"萧山写字楼";
    
    
    self.afterBtn.layer.borderWidth = 1;
    self.afterBtn.layer.borderColor = kColor6B6B6B.CGColor;
//    self.timeLabal  = [[MZTimerLabel alloc]initWithLabel:self.timeLab andTimerType:MZTimerLabelTypeTimer];
//    self.timeLabal.timeFormat = @"mm:ss";
//    self.timeLabal.delegate = self;
    
    
    NSString *numberStr = @"即刻起该车位将为您保留20分钟";
    NSMutableAttributedString *numberMuStr = [[NSMutableAttributedString alloc]initWithString:numberStr];
    [numberMuStr addAttribute:NSForegroundColorAttributeName value:kColorDD9900 range:NSMakeRange(numberStr.length - 4, 2)];
    self.infoLab.attributedText = numberMuStr;
    
    [self loadData];
}
#pragma mark -------------计时器所需-----------------
- (void)startTimer:(NSInteger)timeCount
{
    __block NSInteger count = timeCount;
    kSelfWeak;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if (count<=0)
        {
            dispatch_source_cancel(_timer);
        }
        else
        {
            count--;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf updateTimeLab:count];
        });
    });
    dispatch_resume(_timer);
}

- (void)updateTimeLab:(NSInteger)timeCount
{
    self.timeLab.text = [self getRemainingTime:timeCount];
}

- (NSString *)getRemainingTime:(NSInteger)time;
{
    if (time < 60)
    {
        return [NSString stringWithFormat:@"00:%02ld", time];
    }
    if (time >= 60 && time < 60 * 60)
    {
        NSInteger minute = (time / 60) % 60;
        NSInteger scond = time % 60;
        return [NSString stringWithFormat:@"%02ld:%02ld", minute, scond];
    }
    if (time >= 60 * 60 && time < 24 * 60 * 60)
    {
        NSInteger hour = (time / 60 / 60) % 24;
        NSInteger minute = (time / 60) % 60;
        NSInteger scond = time % 60;
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", hour, minute, scond];
    }
    if (time >= 24 * 60 * 60)
    {
        NSInteger day = time / 60 / 60 / 24;
        NSInteger hour = (time / 60 / 60) % 24;
        NSInteger minute = (time / 60) % 60;
        NSInteger scond = time % 60;
        return [NSString stringWithFormat:@"%02ld %02ld:%02ld:%02ld", day, hour, minute, scond];
    }
    return @"";
}
#pragma mark ---------------event ---------------------/
- (IBAction)nowAction:(id)sender {
    NavigationVC *vc = [[NavigationVC alloc]init];
    vc.latitude = [self.locationArray[1] floatValue];
    vc.longitude = [self.locationArray[0] floatValue];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)afterAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/**
 一键开锁

 @param sender button
 */
- (IBAction)unlockButtonAction:(id)sender {
    [UIAlertView alertViewWithTitle:@"提示" message:@"您确定已到达停车地点？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] onDismiss:^(int buttonIndex, NSString *buttonTitle) {
        [WSProgressHUD showWithMaskType:(WSProgressHUDMaskTypeClear)];
        [self unlock];
    } onCancel:nil];
}

/**
 取消预订

 @param sender button
 */
- (IBAction)cancleReserveAction:(id)sender {
    
    [UIAlertView alertViewWithTitle:@"提示" message:@"确定要取消该车位吗？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] onDismiss:^(int buttonIndex, NSString *buttonTitle) {
        [self cancelReserve];
    } onCancel:nil];
}

#pragma mark ---------------network ---------------------/
- (void)loadData{
    kSelfWeak;
    [CarportReserveModel reserveWithReserveId:self.reserveId success:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            CarportReserveModel *model = statusModel.data;
            strongSelf.title = model.park_title;
            strongSelf.numberLab.text = model.parking_number;
            strongSelf.addressLab.text = [NSString stringWithFormat:@"目的地：%@",model.park_address];
            strongSelf.plateNumLab.text = model.car_chepai1;
            if ([model.park_type isEqualToString:@"0"]) {
                strongSelf.unlockButton.hidden = YES;
            }else{
                strongSelf.unlockButton.hidden = NO;
            }
            NSInteger afterTime = model.reserve_time + 20 * 60;
            NSInteger value = afterTime - [HelpTool getNowTimestamp];
            value = value > 0 ? value : 0;
            [self startTimer:value];
//            [strongSelf.timeLabal setCountDownTime:value];
//            [strongSelf.timeLabal start];
            
            self.locationArray  = [NSArray new];
            self.locationArray = [model.park_jwd componentsSeparatedByString:@","];
            self.carportReserveModel = [CarportReserveModel new];
            self.carportReserveModel = model;

        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
    }];
}
//取消预订实现
- (void)cancelReserve{
    kSelfWeak;
    [CarportReserveModel cancelReserveWithId:self.reserveId success:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            [WSProgressHUD showImage:nil status:statusModel.message];
            [strongSelf.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
    }];
}

//开锁
-(void)unlock{
    
    kSelfWeak;
    [CarportReserveModel openLockWithParkingId:self.carportReserveModel.parking_id carNumId:self.carportReserveModel.car_id success:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            //strongSelf.isOpen = YES;
            [WSProgressHUD showImage:nil status:statusModel.message];
            [strongSelf.navigationController popToRootViewControllerAnimated:YES];
        }else {
            //strongSelf.message = statusModel.message;
            [WSProgressHUD showImage:nil status:statusModel.message];

        }
    }];
}


@end
