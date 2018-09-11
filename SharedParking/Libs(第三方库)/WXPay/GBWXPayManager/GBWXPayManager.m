//
//  GBWXPayManager.m
//  微信支付
//
//  Created by 张国兵 on 15/7/25.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.
//

#import "GBWXPayManager.h"
#import "PayInfoModel.h"

@implementation GBWXPayManager
/**
 *  针对多个商户的支付
 *
 *  @param orderID    支付订单号
 *  @param orderTitle 订单的商品描述
 *  @param amount     订单总额
 *  @param notifyURL  支付结果异步通知
 *  @param seller     商户号（收款账号）
 */

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static GBWXPayManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[GBWXPayManager alloc] init];
    });
    return instance;
}


+(void)wxpayWithPreID:(NSString*)preID
             orderTitle:(NSString*)orderTitle
                 amount:(NSString*)amount
               sellerID:(NSString *)sellerID
                  appID:(NSString*)appID
              partnerID:(NSString*)partnerID{
    //微信支付的金额单位是分转化成我们比较常用的'元'
    NSString*realPrice=[NSString stringWithFormat:@"%.f",amount.floatValue*100];
    if(realPrice.floatValue<=0){
        return;
    }
    //创建支付签名对象
    payRequsestHandler *req = [payRequsestHandler alloc];
    //初始化支付签名对象
    [req init:appID mch_id:sellerID];
    //设置密钥
    [req setKey:partnerID];
    
    //获取到实际调起微信支付的参数后，在app端调起支付
//    NSMutableDictionary *dict = [req sendPay_demo:orderID title:orderTitle price: realPrice];
//    NSMutableDictionary *dict = [req sendPay_demo:<#(NSString *)#> title:<#(NSString *)#> price:<#(NSString *)#> :preID];

    NSMutableDictionary *dict = [req sendPay_demo:nil title:orderTitle price:realPrice :preID];
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        
        [self alert:@"提示信息" msg:debug];
        
        NSLog(@"%@\n\n",debug);
    }else{
        NSLog(@"%@\n\n",[req getDebugifo]);
        
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
        BOOL status = [WXApi sendReq:req];
        NSLog(@"%d",status);
        
    }
    
}

/**
 *  单一用户
 *
 *  @param orderID    支付订单号
 *  @param orderTitle 订单的商品描述
 *  @param amount     订单总额
 */
+(void)wxpayWithAmount:(NSString*)amount weiDic:(NSDictionary *)dict{
    //微信支付的金额单位是分转化成我们比较常用的'元'
    NSString *realPrice=[NSString stringWithFormat:@"%.f",amount.floatValue*100];
    if(realPrice.floatValue<=0){
        return;
    }
    NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
    //调起微信支付
    //创建支付签名对象
    //初始化支付签名对象
    PayReq *req             = [[PayReq alloc] init];
    req.openID              = [dict objectForKey:@"appid"];
    req.partnerId           = [dict objectForKey:@"partnerid"];
    req.prepayId            = [dict objectForKey:@"prepayid"];
    req.nonceStr            = [dict objectForKey:@"noncestr"];
    req.timeStamp           = stamp.intValue;
    req.package             = [dict objectForKey:@"package"];
    req.sign                = [dict objectForKey:@"sign"];
    BOOL status = [WXApi sendReq:req];
    NSLog(@"%d",status);
}

+ (void)wxpayWithAmount:(NSString*)amount wechatModel:(PayInfoModel *)wechatModel {
    //微信支付的金额单位是分转化成我们比较常用的'元'
    NSString *realPrice = [NSString stringWithFormat:@"%.f",amount.floatValue*100];
    if(realPrice.floatValue<=0){
        return;
    }
    NSString *stamp  = wechatModel.timestamp;
    //调起微信支付
    //创建支付签名对象
    //初始化支付签名对象
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = wechatModel.appid;
    req.partnerId           = wechatModel.partnerid;
    req.prepayId            = wechatModel.prepayid;
    req.nonceStr            = wechatModel.noncestr;
    req.timeStamp           = stamp.intValue;
    req.package             = @"Sign=WXPay";
    req.sign                = wechatModel.sign;

    if (![WXApi isWXAppInstalled]) {
        [WSProgressHUD showImage:nil status:@"请安装微信"];
    }
    if (wechatModel.sign==nil && wechatModel.partnerid==nil) {
        [WSProgressHUD showImage:nil status:@"未知错误"];
    }
    
    BOOL status = [WXApi sendReq:req];
    NSLog(@"%d",status);
}

//是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面。

//如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面。
#pragma mark - 微信支付回调
- (void)onResp:(BaseResp *)resp
{
    if (self.payResult) {
        self.payResult(resp);
    }
    
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
//        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                [[NSNotificationCenter defaultCenter] postNotificationName:kWXpayresult object:@"1"];
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                strTitle = @"支付失败,请重新支付~";
                [[NSNotificationCenter defaultCenter] postNotificationName:kWXpayresult object:@"0"];
                break;
        }
    }
    [WSProgressHUD showImage:nil status:strTitle];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];
}





//客户端提示信息
+ (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}
@end
