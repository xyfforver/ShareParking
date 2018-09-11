//
//  CarportPayVC.h
//  SharedParking
//
//  Created by galaxy on 2017/11/13.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseViewController.h"

@interface CarportPayVC : BaseViewController
- (instancetype)initWithOrderId:(NSString *)orderId;

@property (nonatomic , copy) NSString *orderId;
@property (nonatomic , copy) NSString *park_type;//!<1地锁 0道闸
@property (nonatomic , copy) void(^reloadBlock)(void);
@end
