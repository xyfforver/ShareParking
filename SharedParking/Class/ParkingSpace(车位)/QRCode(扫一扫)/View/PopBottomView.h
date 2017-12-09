//
//  PopBottomView.h
//  lyx
//
//  Created by apple on 2017/10/25.
//  Copyright © 2017年 seeday. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarportShortItemModel.h"
typedef void(^BlockCallBackIndex)(CarportShortItemModel *model);

@interface PopBottomView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_data;
}
@property (nonatomic,strong) UIView *view_bg;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *data;
@property (nonatomic,strong) UIColor *cancelColor;
@property (nonatomic,strong) BlockCallBackIndex blockCallBackIndex;

-(void)viewShow;

-(void)removeOperateView;

@end
