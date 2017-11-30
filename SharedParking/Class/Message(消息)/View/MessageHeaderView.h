//
//  MessageHeaderView.h
//  SharedParking
//
//  Created by galaxy on 2017/11/30.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageHeaderView : UIView
@property (nonatomic, assign) NSInteger selectedSegmentIndex;
@property (nonatomic, copy) void (^IndexChangeBlock)(NSInteger index);

- (instancetype)initWithItems:(NSArray *)items frame:(CGRect)frame;

+ (CGFloat)defaultHeight;
@end
