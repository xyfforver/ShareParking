//
//  CarportDetailVC.h
//  SharedParking
//
//  Created by galaxy on 2017/11/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseViewController.h"

@interface CarportDetailVC : BaseViewController

- (instancetype)initWithCarportId:(NSString *)carportId type:(CarportRentType )type;

@property (nonatomic , copy) NSString *carportId;
@property (nonatomic , assign) CarportRentType type;


@end
