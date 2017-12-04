//
//  CarportLongListModel.h
//  SharedParking
//
//  Created by galaxy on 2017/12/4.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseModel.h"

@interface CarportLongListModel : BaseModel


@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *parking_title;
@property (copy, nonatomic) NSString *parking_img;
@property (assign, nonatomic) CarportRentType parking_type;//停车类型 0 错时 1 长租
@property (assign, nonatomic) BOOL parking_fabutype;//发布类型 0 后台发布 1 前台个人发布
@property (assign, nonatomic) NSInteger parking_cheweitype;//车位类型 0小区 1写字楼 2 其他

@property (copy, nonatomic) NSString *user_id;
@property (copy, nonatomic) NSString *istype;
@property (copy, nonatomic) NSString *parking_fee;
@property (copy, nonatomic) NSString *park_id;
@property (copy, nonatomic) NSString *create_time;
@property (copy, nonatomic) NSString *park_address;
@property (copy, nonatomic) NSString *park_img;
@property (copy, nonatomic) NSString *park_jwd;
@property (copy, nonatomic) NSString *parking_obj;
@property (copy, nonatomic) NSString *isdelete;
@property (copy, nonatomic) NSString *parking_number;


@property (copy, nonatomic) NSString *remark;
@property (copy, nonatomic) NSString *update_time;
@property (assign, nonatomic) NSInteger distance;






//停车场长租列表
+ (void)carportLongListWithPage:(NSInteger)page success:(NetCompletionBlock)success;

@end
