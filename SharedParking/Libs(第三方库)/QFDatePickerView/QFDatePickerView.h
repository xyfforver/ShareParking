//
//  QFDatePickerView.h
//  dateDemo
//
//  Created by 情风 on 2017/1/12.
//  Copyright © 2017年 情风. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SelectBlock)(NSString *dateStr);
@interface QFDatePickerView : UIView

- (instancetype)initDatePackerWithResponse:(SelectBlock )block;

@property (nonatomic , copy) SelectBlock block;
- (void)show;

@end
