//
//  MessageModel.h
//  SharedParking
//
//  Created by galaxy on 2017/12/8.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseModel.h"

@interface MessageModel : BaseModel
@property (copy, nonatomic) NSString *message_content;
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *create_time;
@property (copy, nonatomic) NSString *parking_id;
@property (copy, nonatomic) NSString *message_title;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *message_img;
@property (assign, nonatomic) NSInteger istype;
/*
 
 istype = 1;
 message_content = 您成功预订了一个车位,请在20分钟内停车。;
 update_time = 1512722871;
 id = 4;
 isdelete = 0;
 user_id = 8;
 create_time = 1512722871;
 parking_id = 13;
 message_title = 车位预订提醒;
 
 */

//我的消息
+ (void)myMessageWithPage:(NSInteger )page success:(NetCompletionBlock)success;
//系统消息
+ (void)systemMessageWithPage:(NSInteger )page success:(NetCompletionBlock)success;
@end
