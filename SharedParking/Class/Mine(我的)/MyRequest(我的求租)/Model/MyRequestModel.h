//
//  MyRequestModel.h
//  SharedParking
//
//  Created by galaxy on 2017/12/8.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseModel.h"

@interface MyRequestModel : BaseModel

@property (nonatomic , assign) CGFloat help_money;
@property (nonatomic , copy) NSString *create_time;
@property (nonatomic , assign) NSInteger help_fanwei;
@property (nonatomic , copy) NSString *help_address;
@property (nonatomic , copy) NSString *id;
@property (nonatomic , assign) BOOL help_type;//求租类型0 错时 1长租

//我的求租信息
+ (void)myRequestInfoWithId:(NSString *)requestId success:(NetCompletionBlock)success;
//删除我的发布
+ (void)deleteMyRequestWithId:(NSString *)requestId success:(NetCompletionBlock)success;
//更新我的求租信息
+ (void)UpdateMyRequestInfoWithId:(NSString *)helpId address:(NSString *)address range:(NSString *)range price:(NSString *)price success:(NetCompletionBlock)success;
//发布我的求租信息
+ (void)issueMyRequestInfoWithAddress:(NSString *)address range:(NSString *)range price:(NSString *)price success:(NetCompletionBlock)success;



@end
