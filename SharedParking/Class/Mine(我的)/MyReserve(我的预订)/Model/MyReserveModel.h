//
//  MyReserveModel.h
//  SharedParking
//
//  Created by galaxy on 2017/12/7.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseModel.h"

@interface MyReserveModel : BaseModel
@property (copy, nonatomic) NSString *car_id;
@property (copy, nonatomic) NSString *parking_number;
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *reserve_time;
@property (copy, nonatomic) NSString *park_address;
@property (copy, nonatomic) NSString *park_title;
@property (copy, nonatomic) NSString *parking_id;
@property (copy, nonatomic) NSString *park_jwd;
@property (assign, nonatomic) NSInteger reserve_status;

@property (assign, nonatomic) CGFloat latitude;
@property (assign, nonatomic) CGFloat longitude;

/*
 car_id = 3;
 parking_number = A01;
 id = 9;
 reserve_time = 1512462358;
 isdelete = 0;
 reserve_status = 1;
 park_address = 杭州萧山区金城路蓝爵国际写字楼;
 user_id = 8;
 park_title = 蓝爵国际停车场;
 parking_id = 7;
 park_jwd = 120.2585946755,30.1872740708;
 */

//我的预订
+ (void)myReserveWithPage:(NSInteger )page success:(NetCompletionBlock)success;

//取消预订
+ (void)cancelReserveWithId:(NSString *)reserveId success:(NetCompletionBlock)success;

@end
