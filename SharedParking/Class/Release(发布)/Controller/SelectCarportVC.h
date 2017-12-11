//
//  SelectCarportVC.h
//  SharedParking
//
//  Created by galaxy on 2017/12/11.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseViewController.h"

@interface SelectCarportVC : BaseViewController

@property (nonatomic , copy) void(^backBlock)(NSString *parkId,NSString *parkTitle);

@end
