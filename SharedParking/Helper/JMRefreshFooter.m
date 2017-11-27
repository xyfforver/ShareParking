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
    
    self.stateLabel.hidden = YES;
    
}

- (void)endRefreshingWithNoMoreData {
    [super endRefreshingWithNoMoreData];
    
    self.hidden = YES;
}


@end

