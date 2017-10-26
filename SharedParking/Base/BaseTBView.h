//
//  BaseTBView.h
//  yimaxingtianxia
//
//  Created by lingbao on 2017/6/3.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef enum :NSInteger {
//    BaseTBViewDataEmptyType,
//    BaseTBViewNetDisconnectType,
//    
//}BaseTBViewType;
@interface BaseTBView : UITableView
@property (nonatomic , copy) void(^reloadDataBlock)();
//@property (nonatomic , assign) BaseTBViewType type;
@end
