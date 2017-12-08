//
//  MyRequestItemModel.h
//  SharedParking
//
//  Created by galaxy on 2017/12/8.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseModel.h"

@interface MyRequestItemModel : BaseModel
@property (nonatomic , copy) NSString *zongnum;
@property (nonatomic , copy) NSString *park_address;
@property (nonatomic , copy) NSString *distance;
@property (nonatomic , copy) NSString *zhanyongnum;
@end
