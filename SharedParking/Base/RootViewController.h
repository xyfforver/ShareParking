//
//  RootViewController.h
//  yimaxingtianxia
//
//  Created by lingbao on 2017/5/18.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITabBarController
{
    
    UIScrollView *startScroll;
    
    UIImageView *img;
    
}




////重写set方法，pop或dismiss到tabbar视图，并选择selectedIndex
//- (void)setSelectedIndex:(NSUInteger)selectedIndex;
@end
