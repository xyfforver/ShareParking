//
//  JMRefreshHeader.m
//  yimaxingtianxia
//
//  Created by lingbao on 2017/5/19.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import "JMRefreshHeader.h"

@implementation JMRefreshHeader


- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    //    NSMutableArray *idleImages = [NSMutableArray array];
    UIImage *image1 = [UIImage imageNamed:@"topRefresh0"];
    UIImage *image2 = [UIImage imageNamed:@"topRefresh1"];
    NSArray *normalArray = @[image1];
    NSArray *gifArray = @[image1, image2];
    
    [self setImages:normalArray forState:MJRefreshStateIdle];
    
    [self setImages:gifArray forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [self setImages:gifArray forState:MJRefreshStateRefreshing];
    
    
    [self setTitle:@"正在加载‘(*>﹏<*)‘" forState:MJRefreshStateRefreshing];
    [self setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    
    self.mj_h = image1.size.height + 25;
    self.lastUpdatedTimeLabel.hidden = YES;
    //    self.stateLabel.hidden = YES;
}

- (void)placeSubviews  {
    [super placeSubviews];
    
    self.gifView.frame = CGRectMake(0, 25, self.mj_w, self.mj_h-25);
    self.stateLabel.frame = CGRectMake(0, 0, self.mj_w, 25);
    self.stateLabel.textColor = UIColorHex(0xbababa);
    self.gifView.contentMode = UIViewContentModeCenter;
}

//- (void)prepare
//{
//    MJRefreshGifHeader *gifHeader = [[MJRefreshGifHeader alloc] init];
//
//    UIImage *image1 = [UIImage imageNamed:@"1-1"];
//    UIImage *image2 = [UIImage imageNamed:@"2-1"];
//    NSArray *normalArray = @[image1];
//    NSArray *gifArray = @[image1, image2];
//    // 普通状态
//    [gifHeader setImages:normalArray duration:0.9 forState:MJRefreshStateIdle];
//
//    // 刷新状态
//    [gifHeader setImages:gifArray duration:0.2 * 2 forState:MJRefreshStateRefreshing];
//
//}

- (void)endRefreshingWithNoMoreData {
    self.hidden = YES;
}

@end
