//
//  PayInfoModel.m
//  yimaxingtianxia
//
//  Created by lingbao on 2017/7/27.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import "PayInfoModel.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "GBWXPayManager.h"
@implementation PayInfoModel
// 获取订单支付信息
+ (void)ordersPayWithOrderId:(NSString *)orderId price:(NSString *)price type:(PayOrderType)type success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(orderId, @"orderid");
    
    NSString *typeStr = [PayInfoModel getType:type];
    DicObjectSet(typeStr, @"type");
    
    kSelfWeak;
    [self postWithStatusModelResponsePath:@"My/confirmpay" params:ParamsDic onCompletion:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            if (type == PayOrderAliType) {
                [strongSelf getPayZhiFuBao:statusModel success:success];
            }else if (type == PayOrderWechatType){
                PayInfoModel *model = statusModel.data;
                [GBWXPayManager wxpayWithAmount:price wechatModel:model];
            }
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
    }];
}



//车位支付
+ (void)parkingPayWithOrderId:(NSString *)orderId price:(NSString *)price type:(PayOrderType)type success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(orderId, @"orderid");
    DicObjectSet(price, @"price");
    NSString *typeStr = [PayInfoModel getType:type];
    DicObjectSet(typeStr, @"type");
    
    kSelfWeak;
    [self postWithStatusModelResponsePath:@"My/carpay" params:ParamsDic onCompletion:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            if (type == PayOrderAliType) {
                [strongSelf getPayZhiFuBao:statusModel success:success];
            }else if (type == PayOrderWechatType){
                PayInfoModel *model = statusModel.data;
                [GBWXPayManager wxpayWithAmount:price wechatModel:model];
            }
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
    }];
}


//充值  priceId为充值金额
+ (void)rechargeWithPriceId:(NSString *)priceId type:(PayOrderType)type success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(priceId, @"in_fee");
    NSString *typeStr = [PayInfoModel getType:type];
    DicObjectSet(typeStr, @"in_paytype");

    kSelfWeak;
    [self postWithStatusModelResponsePath:@"user_deposit" params:ParamsDic onCompletion:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            if (type == PayOrderAliType) {
                [strongSelf getPayZhiFuBao:statusModel success:success];
            }else if (type == PayOrderWechatType){
                PayInfoModel *model = statusModel.data;
                [GBWXPayManager wxpayWithAmount:@"0.01" wechatModel:model];
            }
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
    }];
}


//获取支付类型
+ (NSString *)getType:(PayOrderType)orderType{
    if (orderType == PayOrderAliType) {
        return @"alipay";
    }else if (orderType == PayOrderWechatType){
        return @"wxpay";
    }else if (orderType == PayOrderMemberCardType){
        return @"cardpay";
    }
    return nil;
}

#pragma mark --------------------支付---------------------
//支付宝支付
+ (void)getPayZhiFuBao:(StatusModel *)statusModel success:(NetCompletionBlock)success{
    PayInfoModel *model = statusModel.data;
    [[AlipaySDK defaultService] payOrder:model.value fromScheme:kZhiFuBaoSchemes callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        if (resultDic){
            NSString *resultStatus = [resultDic objectForKey:@"resultStatus"];
            if([resultStatus isEqualToString:@"9000"]){
                DLog(@"支付宝支付成功");
                if (success) {
                    success(statusModel);
                }
            }
        }
    }];
}
//上锁
+ (void)alipaylockWithOrderId:(NSString *)orderId payType:(NSString *)payType price:(NSString *)price success:(NetCompletionBlock)success{
    NSString *zeroType = @"0";
    CreateParamsDic;
    DicObjectSet(orderId, @"order_id");
    DicObjectSet(payType, @"order_paytype");
    DicObjectSet(price, @"order_fee");
    DicObjectSet(zeroType, @"zero_type");
    
    kSelfWeak;
    [self postWithStatusModelResponsePath:@"parking_closelock" params:ParamsDic onCompletion:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess){
           // [strongSelf getPayZhiFuBao:statusModel success:success];
            if ([payType isEqualToString:@"alipay"]) {
                [strongSelf getPayZhiFuBao:statusModel success:success];
            }else if ([payType isEqualToString:@"wxpay"]){
                PayInfoModel *model = statusModel.data;
                [GBWXPayManager wxpayWithAmount:price wechatModel:model];
            }
        }
    }];
    //[self postWithStatusModelResponsePath:@"parking_closelock" params:ParamsDic onCompletion:success];
}

//道闸出口
+(void)gateoutWithCarNumber:(NSString *)chepai payType:(NSString *)payType price:(NSString *)price success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(chepai, @"chepai");
    kSelfWeak;
    [self postWithStatusModelResponsePath:@"gate_out" params:ParamsDic onCompletion:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            NSLog(@"出门了");
            if ([payType isEqualToString:@"alipay"]) {
                [strongSelf getPayZhiFuBao:statusModel success:success];
            }else if ([payType isEqualToString:@"wxpay"]){
                PayInfoModel *model = statusModel.data;
                [GBWXPayManager wxpayWithAmount:price wechatModel:model];
            }
        }
    }];
}


@end
