//
//  MineHeaderView.h
//  SharedParking
//
//  Created by galaxy on 2017/10/25.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineHeaderView : UIView
@property (nonatomic , strong) UserModel *userModel;

@property (nonatomic , copy) void(^pushBlock)(NSInteger type);//type 0:编辑 1:余额 2：车牌
@end
