//
//  UIButton+LCAlignment.h
//  Pods
//
//  Created by jiangliancheng on 16/4/8.
//
//

#import <UIKit/UIKit.h>

@interface UIButton (LCAlignment)

- (void)lc_titleImageHorizontalAlignmentWithSpace:(float)space;    //文字在左,图片在右
- (void)lc_imageTitleHorizontalAlignmentWithSpace:(float)space;    //图片在左,文字在右

- (void)lc_titleImageVerticalAlignmentWithSpace:(float)space;      //文字在上,图片在下
- (void)lc_imageTitleVerticalAlignmentWithSpace:(float)space;      //图片在上,文字在下

@end
