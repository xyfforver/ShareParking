//
//  PayInfoModel.h
//  yimaxingtianxia
//
//  Created by lingbao on 2017/7/27.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import "BaseModel.h"
typedef enum :NSInteger {
    PayOrderAliType,
    PayOrderWechatType,
    PayOrderMemberCardType,
}PayOrderType;
@interface PayInfoModel : BaseModel
//支付宝
@property (nonatomic , copy) NSString *value;

//微信
@property (nonatomic, copy)NSString *sign;
@property (nonatomic, copy)NSString *appid;
@property (nonatomic, copy)NSString *noncestr;
@property (nonatomic, copy)NSString *timestamp;
@property (nonatomic, copy)NSString *partnerid;//商户号
@property (nonatomic, copy)NSString *package;
@property (nonatomic, copy)NSString *prepayid;



//获取订单支付信息
+ (void)ordersPayWithOrderId:(NSString *)orderId price:(NSString *)price type:(PayOrderType)type success:(NetCompletionBlock)success;
//充值
+ (void)rechargeWithPriceId:(NSString *)priceId type:(PayOrderType)type  success:(NetCompletionBlock)success;


//支付宝支付
+ (void)getPayZhiFuBao:(StatusModel *)statusModel success:(NetCompletionBlock)success;

//上锁
+ (void)alipaylockWithOrderId:(NSString *)orderId payType:(NSString *)payType price:(NSString *)price success:(NetCompletionBlock)success;

//道闸出口
+(void)gateoutWithCarNumber:(NSString *)chepai payType:(NSString *)payType price:(NSString *)price success:(NetCompletionBlock)success;
@end
