//
//  JMRefreshFooter.h
//  yimaxingtianxia
//
//  Created by lingbao on 2017/5/19.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface JMRefreshFooter : MJRefreshAutoGifFooter

//UI默认是40,由于项目中不同页面要求 scroView 有不同的边距，所以开放这个属性（MDZZ）
@property (nonatomic,assign)CGFloat topInset;


@end
