//
//  BaseCLView.h
//  yimaxingtianxia
//
//  Created by lingbao on 2017/6/3.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCLView : UICollectionView
@property (nonatomic , copy) void(^reloadDataBlock)();

@end
