//
//  UIButton+EnlargeEdge.h
//  EasyGo
//
//  Created by 徐佳琦 on 16/5/30.
//  Copyright © 2016年 Ju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EnlargeEdge)

- (void)setEnlargeEdge:(CGFloat) size;
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

@end
