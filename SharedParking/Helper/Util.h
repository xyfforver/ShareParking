//
//  Util.h
//  HKMember
//
//  Created by Jackie on 14-7-23.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

//限制textField不能输入的字符
+(BOOL)limitTextFieldCanNotInputWord:(NSString *)string limitStr:(NSString *)limitStr;

//限制textField输入的文字
+(BOOL)limitTextFieldInputWord:(NSString *)string limitStr:(NSString *)limitStr;

//判断输入的字符长度 一个汉字算2个字符
+ (NSUInteger)unicodeLengthOfString:(NSString *)text;

//字符串截到对应的长度包括中文 一个汉字算2个字符
+ (NSString *)subStringIncludeChinese:(NSString *)text ToLength:(NSUInteger)length;

//限制UITextField输入的长度，包括汉字  一个汉字算2个字符
+(void)limitIncludeChineseTextField:(UITextField *)textField Length:(NSUInteger)maxLength;

//限制UITextField输入的长度，不包括汉字
+(void)limitTextField:(UITextField *)textField Length:(NSUInteger)maxLength;

//限制UITextView输入的长度，包括汉字  一个汉字算2个字符
+(void)limitIncludeChineseTextView:(UITextView *)textview Length:(NSUInteger)maxLength;

//限制UITextView输入的长度，不包括汉字
+(void)limitTextView:(UITextView *)textview Length:(NSUInteger)maxLength;

// 是否是纯数字
+ (BOOL)isPureInt:(NSString*)string;

// 一个字符串中与首字母（"\r"）相同的连续字符个数 (针对搜狗输入的换行键)
+ (int)repeatCharCount:(NSString *)string;
// 输入全部为空格时的处理
+ (int)allSpaceCount:(NSString *)string;
// 输入全部为空格和换行符时的处理
+ (int)repeatSpaceAndCharCount:(NSString *)string;

@end
