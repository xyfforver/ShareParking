//
//  BaseCLView.m
//  yimaxingtianxia
//
//  Created by lingbao on 2017/6/3.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import "BaseCLView.h"
@interface BaseCLView()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>


@end
@implementation BaseCLView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        self.backgroundColor = kColorWhite;
    }
    return self;
}


#pragma mark ---------------DZNEmptyDataSetSource ---------------------/
// 返回图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"message_null"];
}

// 空白区域点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    if (self.reloadDataBlock) {
        self.reloadDataBlock();
    }
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂时没有数据哦~";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:kFontSize14,
                                 NSForegroundColorAttributeName:kColorC1C1C1
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}


@end
