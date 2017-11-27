//
//  PayRecordGroupModel.h
//  yimaxingtianxia
//
//  Created by Galaxy on 2017/10/8.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import "BaseModel.h"

@interface PayRecordGroupModel : BaseModel
@property (nonatomic , assign) NSInteger year;
@property (nonatomic , assign) NSInteger month;
@property (nonatomic , strong) NSArray *list;
@property (nonatomic , copy) NSString *zprice;
@property (nonatomic , copy) NSString *sprice;
@end
