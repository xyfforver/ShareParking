//
//  MyReserveTBCell.h
//  SharedParking
//
//  Created by galaxy on 2017/12/7.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyReserveModel.h"
@interface MyReserveTBCell : UITableViewCell

@property (nonatomic , strong) MyReserveModel *reserveModel;

@property (nonatomic , copy) void(^reloadBlock)(void);

+ (CGFloat )getHeight;

@end
