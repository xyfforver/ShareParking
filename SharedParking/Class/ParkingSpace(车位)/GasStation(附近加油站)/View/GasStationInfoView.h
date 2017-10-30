//
//  GasStationInfoView.h
//  SharedParking
//
//  Created by galaxy on 2017/10/30.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SelectBlock)(CGFloat latitude,CGFloat longitude);
@interface GasStationInfoView : UIView
- (instancetype)initWithConfirmBlock:(SelectBlock)confirmBlock;

@property (nonatomic , copy) SelectBlock confirmBlock;


- (void)show;
- (void)dismiss;
@end
