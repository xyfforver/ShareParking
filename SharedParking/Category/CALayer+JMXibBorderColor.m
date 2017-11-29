//
//  CALayer+JMXibBorderColor.m
//  SharedParking
//
//  Created by galaxy on 2017/11/29.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CALayer+JMXibBorderColor.h"

@implementation CALayer (JMXibBorderColor)



- (void)setBorderColorWithUIColor:(UIColor *)color
{
    
    self.borderColor = color.CGColor;
}


@end
