//
//  CarportShortListModel.m
//  SharedParking
//
//  Created by galaxy on 2017/12/2.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportShortListModel.h"

@implementation CarportShortListModel

//停车场错时列表
+ (void)carportShortListWithPage:(NSInteger)page success:(NetCompletionBlock)success{
    CreateParamsDic;
    [ParamsDic setObject:@(page) forKey:@"page"];
    [ParamsDic setObject:@"0" forKey:@"parking_type"];
    [ParamsDic setObject:@"30" forKey:@"lat"];
    [ParamsDic setObject:@"120" forKey:@"lng"];
    [ParamsDic setObject:@"杭州市" forKey:@"shi"];
    [self postWithStatusRecordListModelResponsePath:@"park_wordlist" params:ParamsDic onCompletion:success];
}

//搜索
+ (void)searchWithTitle:(NSString *)title success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(title, @"park_title");
    
    [self postWithStatusRecordListModelResponsePath:@"park_search" params:ParamsDic onCompletion:success];
}
@end
