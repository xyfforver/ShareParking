//
//  MyIssueTBCell.h
//  SharedParking
//
//  Created by galaxy on 2017/11/10.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyIssueModel.h"
@interface MyIssueTBCell : UITableViewCell

@property (nonatomic , strong) MyIssueModel *issueModel;

@property (nonatomic , copy) void(^reloadBlock)(void);

+ (CGFloat)getHeight;

@end
