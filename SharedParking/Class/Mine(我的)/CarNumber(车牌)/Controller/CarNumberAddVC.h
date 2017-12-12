//
//  CarNumberAddVC.h
//  SharedParking
//
//  Created by galaxy on 2017/11/16.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseViewController.h"
#import "CarportShortItemModel.h"
@interface CarNumberAddVC : BaseViewController

- (instancetype)initWithType:(NSInteger)type;


@property (nonatomic , assign) NSInteger type;//0 绑定  1 添加  2 编辑
@property (nonatomic , strong) CarportShortItemModel *carModel;//编辑时需要的参数
@property (nonatomic , copy) void(^loadBlock)(void);

@end
