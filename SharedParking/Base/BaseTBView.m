//
//  BaseTBView.m
//  yimaxingtianxia
//
//  Created by lingbao on 2017/6/3.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import "BaseTBView.h"
@interface BaseTBView()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>


@end
@implementation BaseTBView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        self.backgroundColor = kColorWhite;
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;

    }
    return self;
}

#pragma mark ---------------DZNEmptyDataSetSource ---------------------/
// 返回图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
//    if (self.type == BaseTBViewNetDisconnectType) {
//        self.type = BaseTBViewDataEmptyType;
//
//        return [UIImage imageNamed:@"mine_qq"];
//    }
    return [UIImage imageNamed:@"loading_null"];
}

// 空白区域点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    if (self.reloadDataBlock) {
        self.reloadDataBlock();
    }
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂时没有数据哦~";
//    if (self.type == BaseTBViewNetDisconnectType) {
//        title = @"无网络连接，请检查网络";
//    }
    NSDictionary *attributes = @{
                                 NSFontAttributeName:kFontSize14,
                                 NSForegroundColorAttributeName:kColorC1C1C1
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}


@end
