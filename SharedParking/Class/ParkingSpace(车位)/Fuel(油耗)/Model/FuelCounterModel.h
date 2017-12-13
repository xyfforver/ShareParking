//
//  FuelCounterModel.h
//  SharedParking
//
//  Created by galaxy on 2017/12/13.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseModel.h"

@interface FuelCounterModel : BaseModel
@property (nonatomic , copy) NSString *total_youliang;
@property (nonatomic , copy) NSString *total_money;
@property (nonatomic , copy) NSString *average_youhao;
@property (nonatomic , copy) NSString *average_youfei;

//油耗计算器
+ (void)getAddFuelRecordWithSuccess:(NetCompletionBlock)success;


@end
