//
//  RequestCarportVC.h
//  SharedParking
//
//  Created by galaxy on 2017/11/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseViewController.h"

@interface RequestCarportVC : BaseViewController

- (instancetype)initWithRequestId:(NSString *)requestId;

@property (nonatomic , copy) NSString *requestId;
@end
