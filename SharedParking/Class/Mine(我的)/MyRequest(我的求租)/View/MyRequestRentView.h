//
//  MyRequestRentView.h
//  SharedParking
//
//  Created by galaxy on 2017/11/9.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyRequestModel.h"
@interface MyRequestRentView : UIView

@property (nonatomic , strong) MyRequestModel *model;

@property (nonatomic , copy) void(^reloadBlock)(void);

+ (CGFloat )getHeight;
@end
