//
//  CarportShortListModel.h
//  SharedParking
//
//  Created by galaxy on 2017/12/2.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseModel.h"

@interface CarportShortListModel : BaseModel

@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *park_title;
@property (copy, nonatomic) NSString *park_type;//停车类型 0 道闸 1 地锁
@property (assign, nonatomic) NSInteger zhanyongnum;
@property (assign, nonatomic) NSInteger zongnum;

@property (copy, nonatomic) NSString *shi;
@property (copy, nonatomic) NSString *park_opentime;
@property (copy, nonatomic) NSString *isdelete;
@property (assign, nonatomic) CarportRentType parking_type;
@property (copy, nonatomic) NSString *park_fee;
@property (copy, nonatomic) NSString *sheng;
@property (copy, nonatomic) NSString *park_closetime;
@property (copy, nonatomic) NSString *park_address;
@property (copy, nonatomic) NSString *park_img;
@property (copy, nonatomic) NSString *remark;
@property (copy, nonatomic) NSString *qu;
@property (copy, nonatomic) NSString *park_jwd;
@property (copy, nonatomic) NSString *adminuser_id;
@property (copy, nonatomic) NSString *create_time;
@property (assign, nonatomic) NSInteger distance;


//停车场错时列表
+ (void)carportShortListWithPage:(NSInteger)page success:(NetCompletionBlock)success;


//搜索
+ (void)searchWithTitle:(NSString *)title success:(NetCompletionBlock)success;

@end
