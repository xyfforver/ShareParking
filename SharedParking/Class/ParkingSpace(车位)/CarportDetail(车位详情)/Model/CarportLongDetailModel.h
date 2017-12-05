//
//  CarportLongDetailModel.h
//  SharedParking
//
//  Created by galaxy on 2017/12/5.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseModel.h"

@interface CarportLongDetailModel : BaseModel

@property (copy, nonatomic) NSString *parking_title;
@property (copy, nonatomic) NSString *parking_img;
@property (copy, nonatomic) NSString *parking_fee;
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *user_mobile;
@property (copy, nonatomic) NSString *park_address;
@property (copy, nonatomic) NSString *parking_type;
@property (copy, nonatomic) NSString *remark;
@property (copy, nonatomic) NSString *park_closetime;
@property (copy, nonatomic) NSString *park_opentime;

@property (assign, nonatomic) BOOL parking_obj;//出租对象 0不限 1仅限本小区业主
@property (assign, nonatomic) NSInteger parking_fabutype;
@property (assign, nonatomic) NSInteger parking_cheweitype;
@property (assign, nonatomic) NSInteger distance;
/*
 parking_shenhe = 1;
 parking_title = 我是长租停车位400每月;
 user_id = 1;
 parking_img = /tmp/uploads/20171204/c184f5231b3d06a4871d1db1e6e1295d.png;
 istype = 1;
 parking_fee = 400.00;
 park_id = 2;
 create_time = 1509693729;
 views = 3;
 park_jwd = 120.2585946755,30.1872740708;
 parking_obj = 0;
 isdelete = 0;
 user_mobile = 15093220162;
 parking_number = A02;
 id = 2;
 parking_cheweitype = 1;
 parking_chanquanimg = /tmp/uploads/20171204/c184f5231b3d06a4871d1db1e6e1295d.png;
 distance = 32480;
 park_address = 杭州萧山金城路;
 parking_type = 1;
 parking_fabutype = 1;
 update_time = 1512442099;
 remark = 我是长租用户;
 */
//停车场详情
+ (void)carportLongDetailWithCarPortId:(NSString *)carPortId success:(NetCompletionBlock)success;

@end
