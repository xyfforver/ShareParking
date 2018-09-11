//
//  RechargeModel.h
//  SharedParking
//
//  Created by 尉超 on 2018/1/20.
//  Copyright © 2018年 galaxy. All rights reserved.
//

#import "BaseModel.h"

@interface RechargeModel : BaseModel
@property (nonatomic , copy) NSString *deposit_fee;
//@property (nonatomic , strong) NSArray *list;
//@property (nonatomic , assign) BOOL ispass;
+ (void)rechargeListWithSuccess:(NetCompletionBlock)success;

@end
