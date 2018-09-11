//
//  ParkingRecordDetailModel.h
//  SharedParking
//
//  Created by 尉超 on 2018/1/20.
//  Copyright © 2018年 galaxy. All rights reserved.
//

#import "BaseModel.h"

@interface ParkingRecordDetailModel : BaseModel
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *order_fee;//!<停车费用
@property (copy, nonatomic) NSString *order_sn;
@property (copy, nonatomic) NSString *order_pay;

@property (copy, nonatomic) NSString *parking_number;
@property (assign, nonatomic) NSInteger order_chutime;
@property (assign, nonatomic) NSInteger order_jintime;
@property (copy, nonatomic) NSString *parking_id;
@property (copy, nonatomic) NSString *park_title;
@property (assign, nonatomic) NSInteger order_status;//订单状态 0 正在进行 1取消订单 2 已完成
@property (copy, nonatomic) NSString *order_paytype;
@property (assign, nonatomic) NSInteger isdelete;
@property (assign, nonatomic) NSInteger user_id;
@property (assign, nonatomic) NSInteger car_id;
@property (assign, nonatomic) NSInteger reserve_id;
@property (assign, nonatomic) NSInteger create_time;
@property (copy, nonatomic) NSString *car_chepai;
@property (copy, nonatomic) NSString *park_address;

//订单详情
+ (void)parkingorderInfoWithOrderId:(NSString *)orderId success:(NetCompletionBlock)success;

@end
