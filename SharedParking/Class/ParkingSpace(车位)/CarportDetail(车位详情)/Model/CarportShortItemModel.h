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
@end
