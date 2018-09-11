//
//  ParkingRecordModel.h
//  SharedParking
//
//  Created by galaxy on 2017/12/7.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseModel.h"

@interface ParkingRecordModel : BaseModel
@property (copy, nonatomic) NSString *id;
@property (assign, nonatomic) CGFloat order_fee;//!<结算价格
@property (copy, nonatomic) NSString *parking_number;
@property (assign, nonatomic) NSInteger order_chutime;
@property (assign, nonatomic) NSInteger order_jintime;
@property (copy, nonatomic) NSString *parking_id;
@property (copy, nonatomic) NSString *park_title;
@property (assign, nonatomic) NSInteger order_status;//订单状态 0 正在进行 1取消订单 2 已完成

#pragma mark ---------------付款页 ---------------------/
@property (assign, nonatomic) CGFloat park_fee;

#pragma mark ---------------计费规则----------/
//@property (assign, nonatomic) CGFloat order_fee;//!<结算价格
@property (copy, nonatomic) NSString *rule_fee;//!<停车场单价/小时

/*
 order_id = 13;
 order_fee = 0.00;
 parking_number = A03;
 order_chutime = 0;
 order_jintime = 1512613235;
 parking_id = 6;
 park_title = 360国贸地下停车场;
 
 */
//停车记录
+ (void)parkingRecordWithPage:(NSInteger )page success:(NetCompletionBlock)success;
//车位订单详情
+ (void)orderInfoWithOrderId:(NSString *)orderId success:(NetCompletionBlock)success;
//上锁
+ (void)lockWithOrderId:(NSString *)orderId payType:(NSString *)payType price:(NSString *)price zeroType:(NSString *)zerotype success:(NetCompletionBlock)success;
//停车费用
+ (void)parkingPayWithOrderId:(NSString * )orderid success:(NetCompletionBlock)success;


@end
