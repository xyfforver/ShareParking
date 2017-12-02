//
//  SearchModel.m
//  SharedParking
//
//  Created by galaxy on 2017/12/2.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel
//搜索
+ (void)searchWithTitle:(NSString *)title success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(title, @"park_title");
    
    [self postWithStatusRecordListModelResponsePath:@"park_search" params:ParamsDic onCompletion:success];
}
@end
