//
//  PayRecordModel.h
//  yimaxingtianxia
//
//  Created by Galaxy on 2017/10/7.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import "BaseModel.h"

@interface PayRecordModel : BaseModel
@property (nonatomic , copy) NSString *event;
@property (nonatomic , copy) NSString *price;
@property (nonatomic , copy) NSString *zprice;
@property (nonatomic , copy) NSString *sprice;
@property (nonatomic , copy) NSString *addtime;
@property (nonatomic , copy) NSString *pname;
@property (nonatomic , copy) NSString *comadd;
@property (nonatomic , copy) NSString *type;
//获取支付明细列表
+ (void)getPayRecordListWithAddTime:(NSString *)addTime type:(NSInteger)type page:(NSInteger)page success:(NetCompletionBlock)success;
@end
