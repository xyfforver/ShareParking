//
//  CarportShortItemModel.h
//  SharedParking
//
//  Created by galaxy on 2017/12/5.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseModel.h"

@interface CarportShortItemModel : BaseModel

@property (copy, nonatomic) NSString *id;
//错时 停车位
@property (copy, nonatomic) NSString *parking_number;

//预订 车牌号
@property (copy, nonatomic) NSString *car_chepai;
@property (copy, nonatomic) NSString *car_fadongji;//发动机

//我的车牌列表
+ (void)carNumberListWithSuccess:(NetCompletionBlock)success;

//添加车牌
+ (void)addCarNumberWithNum:(NSString *)carNum endNum:(NSString *)endNum success:(NetCompletionBlock)success;

//删除车牌
+ (void)deleteCarNumberWithCarId:(NSString *)carId success:(NetCompletionBlock)success;

//编辑车牌
+ (void)editCarNumberWithCarId:(NSString *)carId success:(NetCompletionBlock)success;

//更新车牌
+ (void)updateCarNumberWithNum:(NSString *)carNum endNum:(NSString *)endNum carId:(NSString *)carId success:(NetCompletionBlock)success;

//查违章
+ (void)checkViolationWithCarNum:(NSString *)carNum endNum:(NSString *)endNum success:(NetCompletionBlock)success;
@end
