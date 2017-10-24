//
//  NSString+String.h
//  EasyGo
//
//  Created by 徐佳琦 on 16/4/19.
//  Copyright © 2016年 Ju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (String)
+ (BOOL)isNull:(NSString *)string;
- (BOOL)isBlank;
- (NSString *)stringByStrippingWhitespace;
+ (NSString*) uniqueString;
- (NSString*) urlEncodedString;
- (NSString*) urlDecodedString;
///计算文件MD5值
+ (NSString*)getFileMD5WithPath:(NSString*)path;


- (NSString *)stringToMD5;
+ (NSString *)calculateTimeWithTimeFormatter:(long long)timeSecond;

@end
