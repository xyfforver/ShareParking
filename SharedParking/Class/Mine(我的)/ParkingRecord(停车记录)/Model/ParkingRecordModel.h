//
//  ParkingRecordModel.h
//  SharedParking
//
//  Created by galaxy on 2017/12/7.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseModel.h"

@interface ParkingRecordModel : BaseModel
@property (copy, nonatomic) NSString *order_id;
@property (assign, nonatomic) CGFloat order_fee;
@property (copy, nonatomic) NSString *parking_number;
@property (assign, nonatomic) NSInteger order_chutime;
@property (assign, nonatomic) NSInteger order_jintime;
@property (copy, nonatomic) NSString *parking_id;
@property (copy, nonatomic) NSString *park_title;

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



@end
