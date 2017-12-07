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

//几分钟/小时/天前
+ (NSString *)stringIntervalFromLastDate:(NSString *)dateString;
//获取当前时间
+ (NSDate *)getNowDateEast8;

+ (NSString *)stringFromDate:(NSDate *)date;
//两个的时间间隔
+(NSString *)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2;

//获取当前系统时间的时间戳
+(NSInteger)getNowTimestamp;
//将某个时间转化成 时间戳
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;
//将某个时间戳转化成 时间
+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;



#pragma mark ---------------获取字段 ---------------------/
+ (NSString *)getRentObjectWithType:(BOOL)type;
+ (NSString *)getRentCarportWithType:(NSInteger)type;

@end
