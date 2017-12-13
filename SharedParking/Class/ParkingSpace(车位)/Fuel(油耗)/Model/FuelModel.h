//
//  FuelModel.h
//  SharedParking
//
//  Created by galaxy on 2017/12/13.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseModel.h"

@interface FuelModel : BaseModel


@property (nonatomic , assign) NSInteger refuel_time;
@property (nonatomic , copy) NSString *refuel_youjia;
@property (nonatomic , copy) NSString *refuel_youliang;
@property (nonatomic , copy) NSString *refuel_money;
@property (nonatomic , copy) NSString *refuel_licheng;
//添加加油记录
+ (void)addFuelRecordWithDateStr:(NSString *)dateStr mileage:(NSString *)mileage price:(NSString *)price  oilPrice:(NSString *)oilPrice  oilMass:(NSString *)oilMass success:(NetCompletionBlock)success;

//加油记录列表
+ (void)fuelRecordListWithPage:(NSInteger)page success:(NetCompletionBlock)success;


@end
