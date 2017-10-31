//
//  GasStationInfoView.h
//  SharedParking
//
//  Created by galaxy on 2017/10/30.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GasStationModel.h"
typedef void (^SelectBlock)(CGFloat latitude,CGFloat longitude);
@interface GasStationInfoView : UIView
- (instancetype)initWithConfirmBlock:(SelectBlock)confirmBlock;

@property (nonatomic , copy) SelectBlock confirmBlock;

@property (nonatomic , strong) GasStationModel *gasStationModel;

- (void)show;
- (void)dismiss;
@end
