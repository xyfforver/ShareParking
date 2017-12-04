//
//  CarportDetailModel.h
//  SharedParking
//
//  Created by galaxy on 2017/12/4.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseModel.h"

@interface CarportDetailModel : BaseModel



//停车场详情
+ (void)carportDetailWithCarPortId:(NSString *)carPortId type:(NSInteger)type success:(NetCompletionBlock)success;

@end
