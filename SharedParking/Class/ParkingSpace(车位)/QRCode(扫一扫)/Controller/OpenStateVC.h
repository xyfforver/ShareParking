//
//  OpenStateVC.h
//  yimaxingtianxia
//
//  Created by lingbao on 2017/7/7.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import "BaseViewController.h"

@interface OpenStateVC : BaseViewController
- (instancetype)initWithCarportId:(NSString *)carportId carNumId:(NSString *)carNumId;

@property (nonatomic , copy) NSString *carportId;
@property (nonatomic , copy) NSString *carNumId;

@end
