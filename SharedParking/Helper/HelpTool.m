
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

+ (NSString *)uuidUniqueFileName
{
    //Random random = new Random();
    //UUID uuid = UUID.randomUUID();
    //String name = random.nextInt(10000) + System.currentTimeMillis() + uuid.toString();
    
    //    uint32_t random = arc4random()%10000;
    
    NSString *uuidString = [[NSUUID UUID] UUIDString];
    
    UInt64 timeInterval = [[NSDate date] timeIntervalSince1970] *1000;
    
    NSString *fileName = [NSString stringWithFormat:@"%@%@", @(timeInterval), uuidString];
    
    return fileName;
}

+ (NSString *)contentTypeForImageData:(NSData *)data
{
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
        case 0x52:
            if ([data length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return nil;
    }
    return nil;
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

//获取当前系统时间的时间戳
#pragma mark - 获取当前时间的 时间戳

+(NSInteger)getNowTimestamp{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间
    
    NSLog(@"设备当前的时间:%@",[formatter stringFromDate:datenow]);
    
    //时间转时间戳的方法:

    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];

    NSLog(@"设备当前的时间戳:%ld",(long)timeSp); //时间戳的值

    return timeSp;
    
}

//将某个时间转化成 时间戳
#pragma mark - 将某个时间转化成 时间戳

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    
    //时间转时间戳的方法:
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];

    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值

    return timeSp;
    
}

//将某个时间戳转化成 时间

#pragma mark - 将某个时间戳转化成 时间

+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    
    format = [NSString isNull:format] ? @"YYYY-MM-dd HH:mm:ss" : format;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSLog(@"1296035591  = %@",confromTimesp);

    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];

    //NSLog(@"&&&&&&&confromTimespStr = : %@",confromTimespStr);
    return confromTimespStr;
    
}

//view转image
+ (UIImage *)getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//空闲度得到图片名
+ (NSString *)imageStringWithLeisure:(NSInteger)leisure{
    if (leisure >= 0 && leisure <= 30) {
        return @"map_leisure1";
    }else if (leisure > 30 && leisure <= 70){
        return @"map_leisure2";
    }else {
        return @"map_leisure3";
    }
}

#pragma mark ---------------获取字段 ---------------------/
+ (NSString *)getRentObjectWithType:(BOOL)type{
    if (type == 1) {
        return @"仅限本小区业主";
    }
    
    return @"不限";
}

+ (NSString *)getRentCarportWithType:(NSInteger)type{
    if (type == 0) {
        return @"小区";
    }else if (type == 1){
        return @"写字楼";
    }else{
        return @"其他";
    }
}

//错时 长租
+ (NSString *)getCarportTypeWithType:(BOOL)type{
    if (type == 1) {
        return @"长租";
    }
    
    return @"错时";
}

@end
