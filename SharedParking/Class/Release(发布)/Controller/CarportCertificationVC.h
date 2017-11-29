//
//  CarportCertificationVC.h
//  SharedParking
//
//  Created by galaxy on 2017/11/29.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseViewController.h"

@interface CarportCertificationVC : BaseViewController

- (instancetype)initWithType:(CarportRentType)type;


@property (nonatomic , assign) CarportRentType type;
@end
