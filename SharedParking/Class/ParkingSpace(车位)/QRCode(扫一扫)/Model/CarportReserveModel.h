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


@end
