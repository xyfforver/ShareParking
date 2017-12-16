//
//  LongRentView.h
//  SharedParking
//
//  Created by galaxy on 2017/11/29.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarportShortListModel.h"
@interface LongRentView : UIView

@property (nonatomic , strong) CarportShortListModel *model;

+ (CGFloat)getHeight;
@end
