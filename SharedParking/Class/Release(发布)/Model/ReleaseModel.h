//
//  ReleaseModel.h
//  SharedParking
//
//  Created by galaxy on 2017/12/11.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseModel.h"

@interface ReleaseModel : BaseModel
@property (copy, nonatomic) NSString *park_id;
@property (copy, nonatomic) NSString *parking_number;
@property (assign, nonatomic) NSInteger parking_cheweitype;
@property (assign, nonatomic) BOOL parking_obj;
@property (copy, nonatomic) NSString *remark;
@property (copy, nonatomic) NSString *parking_img;
@property (copy, nonatomic) NSString *parking_chanquanimg;
//长租
@property (copy, nonatomic) NSString *parking_title;
@property (copy, nonatomic) NSString *parking_fee;
@property (copy, nonatomic) NSString *user_mobile;
#pragma mark ---------------停车场选择 ---------------------/
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *park_title;
@property (copy, nonatomic) NSString *park_address;

//错时车位发布
+ (void)releaseShortWithParkId:(NSString *)parkId parkNum:(NSString *)parkNum carType:(NSInteger)carType object:(NSInteger)object remark:(NSString *)remark carImg:(NSData *)carImg carportImg:(NSData *)carport success:(NetCompletionBlock)success;

//长租车位发布
+ (void)releaseLongWithTitle:(NSString *)title parkId:(NSString *)parkId parkNum:(NSString *)parkNum price:(NSString *)price telNum:(NSString *)telNum carType:(NSInteger)carType object:(NSInteger)object remark:(NSString *)remark carImg:(NSData *)carImg carportImg:(NSData *)carport success:(NetCompletionBlock)success;

//停车场列表
+ (void)releaseShortWithSearchStr:(NSString *)searchStr page:(NSInteger)page success:(NetCompletionBlock)success;

@end
