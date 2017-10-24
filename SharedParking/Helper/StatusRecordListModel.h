//
//  StatusRecordListModel.h
//  EasyGo
//
//  Created by 徐佳琦 on 16/8/8.
//  Copyright © 2016年 Jackie. All rights reserved.
//

#import "BaseModel.h"

@interface StatusRecordListModel : BaseModel
@property (assign, nonatomic) NSInteger totalCount;
@property (assign, nonatomic) NSInteger endPageIndex;
@property (assign, nonatomic) NSInteger beginPageIndex;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger pageCount;
@property (assign, nonatomic) NSInteger numPerPage;

@property (strong, nonatomic) NSArray *recordList;
@end
