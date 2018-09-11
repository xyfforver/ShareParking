//
//  ParkingRecordDetailVC.m
//  SharedParking
//
//  Created by 尉超 on 2018/1/20.
//  Copyright © 2018年 galaxy. All rights reserved.
//

#import "ParkingRecordDetailVC.h"
#import "ParkingRecordDetailModel.h"
@interface ParkingRecordDetailVC ()
@property (weak, nonatomic) IBOutlet UILabel *parkCardLab;//!< 车牌号
@property (weak, nonatomic) IBOutlet UILabel *beginDateLab;//!< 开始日期
@property (weak, nonatomic) IBOutlet UILabel *beginTimeLab;//!< 开始时间
@property (weak, nonatomic) IBOutlet UILabel *endDateLab;//!< 结束日期
@property (weak, nonatomic) IBOutlet UILabel *endTimeLab;//!< 结束时间
@property (weak, nonatomic) IBOutlet UILabel *parkingNameLab;//!< 停车场名称
@property (weak, nonatomic) IBOutlet UILabel *parkAddressLab;//!< 停车场地址
@property (weak, nonatomic) IBOutlet UILabel *parkingStatus;//!< 停车状态
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLab;//!< 订单编号
@property (weak, nonatomic) IBOutlet UILabel *parkTimeLab;//!< 停车时长
@property (weak, nonatomic) IBOutlet UILabel *parkMoneyLab;//!< 停车费用
@property (weak, nonatomic) IBOutlet UILabel *parkNumberLab;//!< 车位号

@end

@implementation ParkingRecordDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    
    [self loadData];
    //[WSProgressHUD ];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark ---------------NetWork-------------------------/
- (void)loadData{
    kSelfWeak;
    [ParkingRecordDetailModel parkingorderInfoWithOrderId:self.order_id success:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            ParkingRecordDetailModel *model = statusModel.data;
            [strongSelf setDataWith:model];
        }
        
    }];
}

-(void)setDataWith:(ParkingRecordDetailModel *)model{
    self.parkCardLab.text = model.car_chepai;
    self.parkingNameLab.text = model.park_title;
    self.parkAddressLab.text = model.park_address;
    self.orderNumberLab.text = [NSString stringWithFormat:@"订单编号：%@", model.order_sn];
    self.parkMoneyLab.text = [NSString stringWithFormat:@"停车费用：%@元", model.order_fee];
    self.parkNumberLab.text = [NSString stringWithFormat:@"车位号：%@", model.parking_number];
    switch (model.order_status) {
        case 0:
            self.parkingStatus.text = @"进行中";
            break;
        case 1:
            self.parkingStatus.text = @"已取消";
            break;
        case 2:
            self.parkingStatus.text = @"已支付";
            break;
        default:
            break;
    }
    //时间戳的处理
    //时间戳转化成时间
    NSDateFormatter *stampFormatter1 = [[NSDateFormatter alloc] init];
    [stampFormatter1 setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //以 1970/01/01 GMT为基准，然后过了secs秒的时间
    NSDate *stampDate_begin = [NSDate dateWithTimeIntervalSince1970:model.order_jintime];
    NSDate *stampDate_end = [NSDate dateWithTimeIntervalSince1970:model.order_chutime];

    [stampFormatter1 setDateStyle:(NSDateFormatterMediumStyle)];
    self.beginDateLab.text = [stampFormatter1 stringFromDate:stampDate_begin];
    
    NSDateFormatter *stampFormatter2 = [[NSDateFormatter alloc] init];
    [stampFormatter2 setTimeStyle:(NSDateFormatterShortStyle)];
    [stampFormatter2 setDateFormat:@"HH:mm:ss"];

    self.beginTimeLab.text = [stampFormatter2 stringFromDate:stampDate_begin];
    
    if (model.order_chutime == 0) {
        self.endDateLab.text = @"------";
        self.endTimeLab.text = @"------";
    }else{
        self.endDateLab.text = [stampFormatter1 stringFromDate:stampDate_end];
        self.endTimeLab.text = [stampFormatter2 stringFromDate:stampDate_end];

    }
    //NSLog(@"时间戳转化时间 >>> %@",[stampFormatter1 stringFromDate:stampDate_begin]);
    [self calculateTimeWith:model];
    
}
//计算时间间隔
-(void)calculateTimeWith:(ParkingRecordDetailModel *)model{
    //首先创建格式化对象
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //然后创建日期对象
    
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:model.order_jintime];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.order_chutime];
    
    //计算时间间隔（单位是秒）
    
    NSTimeInterval time = [date timeIntervalSinceDate:date1];
    
    //计算天数、时、分、秒
    
    int days = ((int)time)/(3600*24);
    
    int hours = ((int)time)%(3600*24)/3600;
    
    int minutes = ((int)time)%(3600*24)%3600/60;
    
    int seconds = ((int)time)%(3600*24)%3600%60;
    
    NSString *dateContent = [[NSString alloc] initWithFormat:@"停车时长：%i天%i小时%i分%i秒",days,hours,minutes,seconds];
    
    //（%i可以自动将输入转换为十进制,而%d则不会进行转换）
    
    //赋值显示
    if (model.order_chutime == 0) {
        self.parkTimeLab.text = @"------";
    }else{
    self.parkTimeLab.text = dateContent;
    }
//    UILabel *timeLab = (UILabel *)[self.view viewWithTag:666666];
//
//    timeLab.text = dateContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
