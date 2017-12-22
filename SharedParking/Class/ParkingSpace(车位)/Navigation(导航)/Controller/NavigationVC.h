//
//  NavigationVC.h
//  SharedParking
//
//  Created by galaxy on 2017/11/29.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseViewController.h"

@interface NavigationVC : BaseViewController

- (instancetype)initWithLatitude:(CGFloat )latitude longitude:(CGFloat)longitude titleStr:(NSString *)titleStr;

@property (copy , nonatomic) NSString *titleStr;
@property (assign, nonatomic) CGFloat latitude;
@property (assign, nonatomic) CGFloat longitude;

@end
