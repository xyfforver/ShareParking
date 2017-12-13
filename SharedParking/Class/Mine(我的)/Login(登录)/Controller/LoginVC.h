//
//  LoginVC.h
//  SharedParking
//
//  Created by galaxy on 2017/12/1.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginVC : BaseViewController

- (instancetype)initWithType:(NSInteger)type completionBack:(dispatch_block_t)completionBack;

@property (nonatomic, assign) NSInteger type; // 0 登录 1 修改手机号
@property (nonatomic, copy) dispatch_block_t completionBack;

@end
