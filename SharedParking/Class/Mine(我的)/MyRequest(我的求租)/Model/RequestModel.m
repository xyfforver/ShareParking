//
//  RequestModel.m
//  SharedParking
//
//  Created by galaxy on 2017/12/8.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "RequestModel.h"
#import "MyRequestItemModel.h"

@implementation RequestModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"parking":[MyRequestItemModel class]};
}




//我的求租
+ (void)myRequestWithSuccess:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(GetDataManager.latitude, @"lat");
    DicObjectSet(GetDataManager.longitude, @"lng");
    [self postWithStatusModelResponsePath:@"user_help" params:ParamsDic onCompletion:success];
    
}
@end
