//
//  MyIssueModel.h
//  SharedParking
//
//  Created by galaxy on 2017/12/7.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseModel.h"

@interface MyIssueModel : BaseModel
@property (copy, nonatomic) NSString *park_id;
@property (assign, nonatomic) CGFloat parking_fee;
@property (assign, nonatomic) NSInteger parking_cheweitype;
@property (copy, nonatomic) NSString *park_address;
@property (copy, nonatomic) NSString *parking_type;
@property (assign, nonatomic) BOOL parking_obj;
@property (copy, nonatomic) NSString *park_title;
@property (copy, nonatomic) NSString *parking_id;



//我的发布
+ (void)myIssueWithPage:(NSInteger )page success:(NetCompletionBlock)success;
//删除发布
+ (void)deleteIssueWithId:(NSString *)parkingId success:(NetCompletionBlock)success;

/*
 park_id = 2;
 parking_fee = 5.00;
 parking_cheweitype = 0;
 park_address = 杭州萧山金城路;
 parking_type = 0;
 parking_obj = 0;
 park_title = 蓝山国际停车场;
 parking_id = 1;
 parking_shenhe = 1;
 */

@end
