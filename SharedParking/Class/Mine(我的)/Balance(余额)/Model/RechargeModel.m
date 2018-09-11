//
//  RechargeModel.m
//  SharedParking
//
//  Created by 尉超 on 2018/1/20.
//  Copyright © 2018年 galaxy. All rights reserved.
//

#import "RechargeModel.h"

@implementation RechargeModel

+ (void)rechargeListWithSuccess:(NetCompletionBlock)success{
    
    [self postWithStatusModelResponsePath:@"user_deposit_fee" params:nil onCompletion:success];
}
@end
