//
//  ReleaseModel.m
//  SharedParking
//
//  Created by galaxy on 2017/12/11.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ReleaseModel.h"

@implementation ReleaseModel
//错时车位发布
+ (void)releaseShortWithParkId:(NSString *)parkId parkNum:(NSString *)parkNum carType:(NSInteger)carType object:(NSInteger)object remark:(NSString *)remark carImg:(NSData *)carImg carportImg:(NSData *)carport success:(NetCompletionBlock)success{
    
    CreateParamsDic;
    DicObjectSet(parkId, @"park_id");
    DicObjectSet(parkNum, @"parking_number");
    DicObjectSet(@(carType), @"parking_cheweitype");
    DicObjectSet(@(object), @"parking_obj");
    DicObjectSet(remark, @"remark");
    
    DLog(@"\n<<-----------请求--------------------\n%@",ParamsDic);
    NSString *baseUrl = [NSString stringWithFormat:@"%@%@",LingBao_BASE_URL,@"release_short"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:baseUrl parameters:ParamsDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //随机文件名
        NSString *fileName = [HelpTool uuidUniqueFileName];
        //获取文件后缀
        NSString *carExtension = [HelpTool contentTypeForImageData:carImg];
        NSString *carImgName = [fileName stringByAppendingPathExtension:carExtension];
        DLog(@"%@",carImgName);
        [formData appendPartWithFileData:carImg name:@"parking_chanquanimg" fileName:carImgName mimeType:carExtension];
        
        NSString *carportExtension = [HelpTool contentTypeForImageData:carport];
        NSString *carportName = [fileName stringByAppendingPathExtension:carportExtension];
        DLog(@"%@",carportName);
        [formData appendPartWithFileData:carImg name:@"parking_img" fileName:carportName mimeType:carportExtension];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        DLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers error:nil];
        
        DLog(@"\n<<-----------返回--------------------\n Url == %@\n data == %@\n------------------------------->>",baseUrl,json);
        StatusModel *statusModel = [StatusModel statusModelWithKeyValues:json];
        if (success) {
            success(statusModel);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"error===%@",error);
    }];
}

//停车场列表
+ (void)releaseShortWithSearchStr:(NSString *)searchStr page:(NSInteger)page success:(NetCompletionBlock)success{
    CreateParamsDic;
    [ParamsDic setObject:@(page) forKey:@"page"];
    [ParamsDic setObject:searchStr forKey:@"park_title"];
    [self postWithStatusRecordListModelResponsePath:@"select_park" params:ParamsDic onCompletion:success];
}
@end
