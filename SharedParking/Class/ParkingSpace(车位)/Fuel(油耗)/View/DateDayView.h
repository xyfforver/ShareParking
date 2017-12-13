//
//  DateDayView.h
//  mayixingBoss
//
//  Created by lingbao on 2017/8/7.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SelectBlock)(NSString *dateStr);
@interface DateDayView : UIView

- (instancetype)initWithConfirm:(SelectBlock )selectConfirm;

@property (nonatomic , copy) SelectBlock selectConfirm;

- (void)show;
- (void)dismiss;
@end
