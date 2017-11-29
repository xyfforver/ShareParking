//
//  OpenStateVC.h
//  yimaxingtianxia
//
//  Created by lingbao on 2017/7/7.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import "BaseViewController.h"

@interface OpenStateVC : BaseViewController
- (instancetype)initWithCid:(NSString *)cid zid:(NSString *)zid;

@property (nonatomic , copy) NSString *cid;
@property (nonatomic , copy) NSString *zid;
@end
