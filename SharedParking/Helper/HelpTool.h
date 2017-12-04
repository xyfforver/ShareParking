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
+ (NSString *)stringWithInteger:(NSInteger)integer;
//求文本宽高
+ (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize;


+(void)archiverData:(id)object key:(NSString*)key;
+(id)unArchiverData:(NSString*)key;
+(void)archiverSetValue:(id)value key:(NSString*)key;
+(NSString*)unArchiverValue:(NSString*)key;
@end
