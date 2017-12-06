//
//  SearchHistoryView.h
//  SharedParking
//
//  Created by galaxy on 2017/11/1.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchHistoryView : UIView
@property (nonatomic, strong) NSMutableArray *historyData;

@property (nonatomic , copy) void(^selectBlock)(NSString *searchStr);

/**
 *  保存搜索记录
 */
- (void)saveHistoryKeyWord:(NSString *)keyword;

@end
