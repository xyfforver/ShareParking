//
//  CarportDetailHeaderView.h
//  SharedParking
//
//  Created by galaxy on 2017/11/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarportShortDetailModel.h"
#import "CarportLongDetailModel.h"
@interface CarportDetailHeaderView : UIView


@property (nonatomic , strong) CarportShortDetailModel *shortModel;
@property (nonatomic , strong) CarportLongDetailModel *longModel;



+ (CGFloat)getHeight;

@end
