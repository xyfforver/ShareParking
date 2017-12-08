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
@property (nonatomic , assign) BOOL help_type;//求租类型0 错时 1长租



@end
