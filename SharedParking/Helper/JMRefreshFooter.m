//
//  JMRefreshFooter.m
//  yimaxingtianxia
//
//  Created by lingbao on 2017/5/19.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import "JMRefreshFooter.h"

@implementation JMRefreshFooter


- (void)prepare {
    [super prepare];
    
    _topInset = 40;
    
    UIImage *image1 = [UIImage imageNamed:@"bottomRefresh0"];
    UIImage *image2 = [UIImage imageNamed:@"bottomRefresh1"];
    UIImage *image3 = [UIImage imageNamed:@"bottomRefresh2"];
    UIImage *image4 = [UIImage imageNamed:@"bottomRefresh3"];
    
    NSArray *normalArray = @[image1];
    NSArray *gifArray = @[image1, image2,image3,image4];
    
    [self setImages:normalArray forState:MJRefreshStateIdle];
    
    [self setImages:gifArray forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:gifArray forState:MJRefreshStateRefreshing];
    
    self.stateLabel.hidden = YES;
    self.refreshingTitleHidden = YES;
    
    
    //    self.gifHeight = self.size.height;
    self.height += _topInset;
}
- (void)placeSubviews  {
    [super placeSubviews];
    self.stateLabel.textColor = UIColorHex(0xbababa);
    self.gifView.frame = CGRectMake(0, _topInset, kScreenWidth, self.mj_h-_topInset);
    self.stateLabel.frame = CGRectMake(0, _topInset, kScreenWidth, _topInset);
}
- (void)endRefreshingWithNoMoreData {
    [super endRefreshingWithNoMoreData];
    
    self.hidden = YES;
    
    //    self.stateLabel.hidden = NO;
    //    self.stateLabel.text = @"没有更多数据";
    
    //    self.stateLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, 25);
    //    self.height = 25;
}
- (void)resetNoMoreData {
    [super resetNoMoreData];
    //    self.stateLabel.hidden = YES;
    self.hidden = NO;
    
}



- (void)setTopInset:(CGFloat)topInset {
    _topInset = topInset;
    
    self.height += _topInset;
    [self placeSubviews];
}
@end
