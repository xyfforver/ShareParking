
//
//  HelpTool.m
//  SharedParking
//
//  Created by galaxy on 2017/10/31.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "HelpTool.h"

@implementation HelpTool

#pragma mark ---------------计算两点之间的距离 ---------------------/
+ (double)calculateTheDistanceWithLon1:(double) lon1
                                  Lat1:(double) lat1
                                  Lon2:(double) lon2
                                  Lat2:(double) lat2{
    double er = 6371393.0f;//地球半径
    //第一个位置的经纬度
    double radlong1 = M_PI*lon1/180.0f;
    double radlat1 = M_PI*lat1/180.0f;
    //第二个位置的经纬度
    double radlat2 = M_PI*lat2/180.0f;
    double radlong2 = M_PI*lon2/180.0f;
    //判断经纬度的正负
    if( radlat1 < 0 ) radlat1 = M_PI/2 + fabs(radlat1);
    if( radlat1 > 0 ) radlat1 = M_PI/2 - fabs(radlat1);
    if( radlat2 < 0 ) radlat2 = M_PI/2 + fabs(radlat2);
    if( radlat2 > 0 ) radlat2 = M_PI/2 - fabs(radlat2);
    if( radlong2 < 0 ) radlong2 = M_PI*2 - fabs(radlong2);
    
    double x1 = er * cos(radlong1) * sin(radlat1);
    double y1 = er * sin(radlong1) * sin(radlat1);
    double z1 = er * cos(radlat1);
    double x2 = er * cos(radlong2) * sin(radlat2);
    double y2 = er * sin(radlong2) * sin(radlat2);
    double z2 = er * cos(radlat2);
    double d = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2));
    double theta = acos((er*er+er*er-d*d)/(2*er*er));
    
    double dist  = theta * er;
    //返回最终的距离
    return dist;
}

+ (NSString *)stringWithDistance:(NSInteger )distance{
    NSString *str = [NSString stringWithFormat:@"%ldm",distance];
    
    if (distance >= 1000 && distance <= 1000000) {
        str = [NSString stringWithFormat:@"%.1fkm",distance/1000.0];
    }else if(distance > 1000000){
        //距离大于1000km时显示太远
        str = @"距离太远";
    }
    
    return str;
}

+ (NSString *)stringWithInteger:(NSInteger)integer{
    return [NSString stringWithFormat:@"%ld",integer];
}

//球文本宽高
+ (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize

{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize size = [str boundingRectWithSize:maxSize
                                    options:NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                                 attributes:dict
                                    context:nil].size;
    
    return size;
}


+(void)archiverData:(id)object key:(NSString*)key
{
    NSData* data       = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:data forKey:key];
    [ud synchronize];
}

+(id)unArchiverData:(NSString*)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData* data       = [ud objectForKey:key];
    id my_object       = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return my_object;
}


+(void)archiverSetValue:(id)value key:(NSString*)key
{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    [ud setObject:value forKey:key];
    [ud synchronize];
}


+(NSString*)unArchiverValue:(NSString*)key
{
    NSUserDefaults* ud=[NSUserDefaults standardUserDefaults];
    
    return [ud valueForKey:key];
}


#pragma mark - 多久以前
+ (NSString *)stringIntervalFromLastDate:(NSString *)dateString{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *compareDate = [date dateFromString:dateString];
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

+(NSDate *)getNowDateEast8{
    return [NSDate dateWithTimeIntervalSinceNow:8 * 60 * 60];
}

+ (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}


//两个的时间间隔
+(NSString *)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d1=[date dateFromString:dateString1];
    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
    NSDate *d2=[date dateFromString:dateString2];
    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
    NSTimeInterval cha=late2-late1;
    NSString *timeString=@"";
    //86400
    timeString = [NSString stringWithFormat:@"%f", cha/1];
    timeString = [timeString substringToIndex:timeString.length-7];
    timeString=[NSString stringWithFormat:@"%@", timeString];
    return timeString;
}
@end
