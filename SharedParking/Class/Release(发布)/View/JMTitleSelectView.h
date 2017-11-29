//
//  JMTitleSelectView.h
//  SharedParking
//
//  Created by galaxy on 2017/11/27.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMTitleSelectView : UIView

@property (nonatomic, assign) NSInteger selectedSegmentIndex;

@property (nonatomic, copy) void (^IndexChangeBlock)(NSInteger index);


@end
