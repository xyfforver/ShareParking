//
//  CarNumberListVC.h
//  SharedParking
//
//  Created by galaxy on 2017/11/16.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseViewController.h"

@interface CarNumberListVC : BaseViewController

@property (nonatomic , copy) void(^selectBlock)(NSString *carNum , NSString *endNum);

@end
