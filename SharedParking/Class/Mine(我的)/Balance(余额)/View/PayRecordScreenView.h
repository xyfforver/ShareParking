//
//  PayRecordScreenView.h
//  yimaxingtianxia
//
//  Created by galaxy on 2017/9/26.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ScreenBlock)(NSInteger selectCount);
@interface PayRecordScreenView : UIView
- (instancetype)initWithType:(NSInteger )type Confirm:(ScreenBlock )selectConfirm;

@property (nonatomic , assign) NSInteger type;
@property (nonatomic , copy) ScreenBlock selectConfirm;

- (void)show;
- (void)dismiss;
@end
