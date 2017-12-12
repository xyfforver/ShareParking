//
//  CarNumberListTBCell.h
//  SharedParking
//
//  Created by galaxy on 2017/11/16.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarportShortItemModel.h"
@interface CarNumberListTBCell : UITableViewCell

@property (nonatomic , strong) CarportShortItemModel *itemModel;

@property (nonatomic , copy) void(^loadBlock)(void);

@end
