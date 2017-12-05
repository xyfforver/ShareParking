//
//  ReserveSuccessVC.h
//  SharedParking
//
//  Created by galaxy on 2017/11/24.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseViewController.h"

@interface ReserveSuccessVC : BaseViewController

- (instancetype)initWithReserveId:(NSString *)reserveId;

@property (nonatomic , copy) NSString *reserveId;
@end
