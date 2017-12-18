//
//  CarportReserveModel.h
//  SharedParking
//
//  Created by galaxy on 2017/12/5.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseModel.h"

@interface CarportReserveModel : BaseModel
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *park_id;
@property (assign, nonatomic) CGFloat park_fee;
@property (copy, nonatomic) NSString *parking_number;
@property (assign, nonatomic) CGFloat park_feeovertime;
@property (strong, nonatomic) NSArray *car_chepai;

#pragma mark ---------------预订 ---------------------/
@property (copy, nonatomic) NSString *reserve_id;

#pragma mark ---------------预订成功 ---------------------/
@property (copy, nonatomic) NSString *park_title;
@property (assign, nonatomic) NSInteger reserve_time;
@property (copy, nonatomic) NSString *park_jwd;
@property (copy, nonatomic) NSString *park_address;
#pragma mark ---------------首页订单 ---------------------/
@property (assign, nonatomic) NSInteger order_jintime;

#pragma mark ---------------扫一扫 ---------------------/
@property (copy, nonatomic) NSString *park_opentime;
@property (copy, nonatomic) NSString *park_closetime;
@property (strong, nonatomic) NSArray *chepai_list;
/*
 id = 5;
 park_id = 1;
 park_fee = 4.00;
 parking_number = A02;
 car_chepai = (
 );
 */


//停车场预订 详情
+ (void)carportReserveWithParkingId:(NSString *)parkingId success:(NetCompletionBlock)success;

//预订
+ (void)reserveWithParkingId:(NSString *)parkingId carNumId:(NSString *)carNumId success:(NetCompletionBlock)success;
//预订成功
+ (void)reserveWithReserveId:(NSString *)reserveId success:(NetCompletionBlock)success;
//扫一扫进来
+ (void)qrcodeWithParkingId:(NSString *)parkingId success:(NetCompletionBlock)success;
//开锁
+ (void)openLockWithParkingId:(NSString *)parkingId carNumId:(NSString *)carNumId success:(NetCompletionBlock)success;

//首页预订
+ (void)homeReserveWithSuccess:(NetCompletionBlock)success;
//首页订单
+ (void)homeOrderWithSuccess:(NetCompletionBlock)success;
@end
