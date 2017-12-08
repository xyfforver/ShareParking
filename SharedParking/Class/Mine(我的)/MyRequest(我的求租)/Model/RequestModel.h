//
//  RequestModel.h
//  SharedParking
//
//  Created by galaxy on 2017/12/8.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseModel.h"
#import "MyRequestModel.h"
@interface RequestModel : BaseModel
@property (nonatomic , strong) NSArray *parking;

@property (nonatomic , strong) MyRequestModel *help;

//我的求租
+ (void)myRequestWithSuccess:(NetCompletionBlock)success;
@end
