//
//  ReserveSuccessVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/24.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ReserveSuccessVC.h"
#import "NavigationVC.h"

#import "MZTimerLabel.h"

#import "CarportReserveModel.h"
@interface ReserveSuccessVC ()<MZTimerLabelDelegate>
@property (strong, nonatomic) IBOutlet UILabel *numberLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *addressLab;
@property (strong, nonatomic) IBOutlet UIButton *nowBtn;
@property (strong, nonatomic) IBOutlet UIButton *afterBtn;

@property (nonatomic , strong) MZTimerLabel *timeLabal;
@end

@implementation ReserveSuccessVC
- (instancetype)initWithReserveId:(NSString *)reserveId{
    self = [super init];
    if (self) {
        self.reserveId = reserveId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = @"萧山写字楼";
    
    
    self.afterBtn.layer.borderWidth = 1;
    self.afterBtn.layer.borderColor = kColor6B6B6B.CGColor;
    self.timeLabal  = [[MZTimerLabel alloc]initWithLabel:self.timeLab andTimerType:MZTimerLabelTypeTimer];
    self.timeLabal.timeFormat = @"mm:ss";
    self.timeLabal.delegate = self;
    
    [self loadData];
}

#pragma mark ---------------event ---------------------/
- (IBAction)nowAction:(id)sender {
    NavigationVC *vc = [[NavigationVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)afterAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
            
            NSInteger afterTime = model.reserve_time + 20 * 60;
            NSInteger value = afterTime - [HelpTool getNowTimestamp];
            value = value > 0 ? value : 0;
            [strongSelf.timeLabal setCountDownTime:value];
            [strongSelf.timeLabal start];

        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
    }];
}

@end
