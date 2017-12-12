//
//  CarportShortItemModel.m
//  SharedParking
//
//  Created by galaxy on 2017/12/5.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportShortItemModel.h"

@implementation CarportShortItemModel

- (void)setCar_chepai:(NSString *)car_chepai{
    _car_chepai = car_chepai;
    
    self.parking_number = car_chepai;
}

//我的车牌列表
+ (void)carNumberListWithSuccess:(NetCompletionBlock)success{
    
    [self postWithStatusRecordListModelResponsePath:@"usercar_list" params:nil onCompletion:success];
}

//添加车牌
+ (void)addCarNumberWithNum:(NSString *)carNum endNum:(NSString *)endNum success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(carNum, @"car_chepai");
    DicObjectSet(endNum, @"car_fadongji");
    [self postWithStatusModelResponsePath:@"usercar_add" params:ParamsDic onCompletion:success];
}
@end
