//
//  FKAllOrderHeaderView.h
//  SharedParking
//
//  Created by 尉超 on 2018/1/16.
//  Copyright © 2018年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FKAllOrderHeaderView : UIView
@property (nonatomic, assign) NSInteger selectedSegmentIndex;
@property (nonatomic, copy) void (^IndexChangeBlock)(NSInteger index);

- (instancetype)initWithItems:(NSArray *)items frame:(CGRect)frame;

+ (CGFloat)defaultHeight;
@end
