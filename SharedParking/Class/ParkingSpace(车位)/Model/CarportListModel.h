//
//  CarportListModel.h
//  SharedParking
//
//  Created by galaxy on 2017/12/2.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseModel.h"

@interface CarportListModel : BaseModel

@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *shi;
@property (copy, nonatomic) NSString *park_title;
@property (copy, nonatomic) NSString *park_opentime;
@property (copy, nonatomic) NSString *park_type;
@property (copy, nonatomic) NSString *isdelete;
@property (copy, nonatomic) NSString *parking_type;
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
@property (copy, nonatomic) NSString *update_time;


//停车场列表
+ (void)carportListWithCity:(NSString *)city type:(NSInteger)type page:(NSInteger)page success:(NetCompletionBlock)success;



@end
