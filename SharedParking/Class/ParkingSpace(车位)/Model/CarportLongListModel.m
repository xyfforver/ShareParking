//
//  CarportLongListModel.m
//  SharedParking
//
//  Created by galaxy on 2017/12/4.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportLongListModel.h"

@implementation CarportLongListModel


//停车场长租列表
+ (void)carportLongListWithPage:(NSInteger)page success:(NetCompletionBlock)success{
    CreateParamsDic;
    [ParamsDic setObject:@(page) forKey:@"page"];
    [ParamsDic setObject:@"1" forKey:@"parking_type"];
    [ParamsDic setObject:@"30" forKey:@"lat"];
    [ParamsDic setObject:@"120" forKey:@"lng"];
    [ParamsDic setObject:@"杭州市" forKey:@"shi"];
    [self postWithStatusRecordListModelResponsePath:@"park_wordlist" params:ParamsDic onCompletion:success];
}



@end
