//
//  CarportShortDetailModel.h
//  SharedParking
//
//  Created by galaxy on 2017/12/4.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseModel.h"

@interface CarportShortDetailModel : BaseModel
@property (copy, nonatomic) NSString *park_img;
@property (copy, nonatomic) NSString *park_title;
@property (copy, nonatomic) NSString *park_jwd;
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *park_closetime;
@property (copy, nonatomic) NSString *park_type;//停车类型 0 道闸 1 地锁
@property (copy, nonatomic) NSString *park_fee;
@property (assign, nonatomic) NSInteger distance;
@property (copy, nonatomic) NSString *park_address;



//停车场详情
+ (void)carportShortDetailWithCarPortId:(NSString *)carPortId type:(NSInteger)type success:(NetCompletionBlock)success;

@end
