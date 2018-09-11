//
//  OrderPayMethodView.h
//  yimaxingtianxia
//
//  Created by lingbao on 2017/6/8.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderPayMethodView : UIView

- (instancetype)initWithIsRechange:(BOOL)isRechange frame:(CGRect)frame;

@property (nonatomic , copy) void(^payMethodBlock)(NSInteger index);

@property (nonatomic , copy) NSString *price;
@property (nonatomic , assign) BOOL isRechange;
@end
