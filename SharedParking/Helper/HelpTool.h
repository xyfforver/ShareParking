//
//  HelpTool.h
//  SharedParking
//
//  Created by galaxy on 2017/10/31.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HelpTool : NSObject
//计算两点之间的距离
+ (double)calculateTheDistanceWithLon1:(double) lon1
                                  Lat1:(double) lat1
                                  Lon2:(double) lon2
                                  Lat2:(double) lat2;
//距离换算
+ (NSString *)stringWithDistance:(NSInteger )distance;
@end
